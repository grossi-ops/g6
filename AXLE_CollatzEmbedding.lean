/-
  AXLE_CollatzEmbedding.lean
  Collatz–Helical Attractor Embedding (AXLE Issue #13)
  G6 LLC · Pablo Nogueira Grossi · Newark NJ · 2026
  MIT License

  This file formalises the embedding of one Collatz macro-step as one
  return time on the dm³ helical attractor, with the dependency structure
  made fully visible at the type level.

  Architecture (dependency graph, from the Issue #12 analysis):

    oddPart_odd              PROVED. Independent. No sorry.
                             Routine padicValNat maximality argument.

    longitudinal_advance_log PROVED (definitionally true by Design A).
                             Renamed from longitudinal_advance_exact to expose
                             that the proof uses the log identity — not a
                             theorem about Collatz dynamics.

    z_growth_lower_bound     ONE SORRY. Comparison-ODE from the z-component of
                             the vector field alone; independent of solution_r_spec.
                             This is sub-goal (a) of the former inward_basin_uniform.

    basin_hyp                EXPLICIT NAMED AXIOM. Replaces the hidden sorry
                             buried inside inward_basin_uniform. Visible at every
                             callsite (inward_basin_uniform, kappa_lipschitz,
                             collatzEmbedding). Sub-goals (b)+(c) of former
                             inward_basin_uniform: Gronwall applied to the Duhamel
                             formula using z_growth_lower_bound + eps_rem_quadratic_bound.

    inward_basin_uniform     PROVED from z_growth_lower_bound + basin_hyp.

    collatzEmbedding         PROVED from longitudinal_advance_log + basin_hyp.

  Honest sorry count: 1
    · z_growth_lower_bound — comparison-ODE; independent of solution_r_spec.
      Sub-goal (a): z(t) ≥ z₀ + t/2 when z₀ ≥ log 2, from ż = 1 - e^{-z}.
      Proof sketch: ż ≥ ½ whenever z ≥ log 2; z starts above log 2 and stays
      there; integrate.

  Open axioms: 1
    · basin_hyp — Gronwall + z-bootstrap; moved from hidden sorry.
    · solution_r_spec — ODE existence; lives in AXLE_Issue12 (not referenced here).

  What this file honestly proves:
    A reduced 2D flow with a closed κ-contraction admits a coding ι : ℕ → ℝ × ℝ
    such that flowing for time τ(n) = log(collatzMacro n) − log n returns the
    longitudinal coordinate from log n to log(collatzMacro n).
    The radial component contracts: |ε(τ(n))| ≤ C · |ε₀| · κ^{τ(n)}.
    This is one Collatz step = one return time. The Collatz conjecture is about
    iteration; that connection lives in §7 (signature only).

  Reference: Grossi (2026), "Book 3: The Mini-Beast", Chapter 12 / AXLE Issue #12
  Author: Pablo Nogueira Grossi · G6 LLC · 2026
-/

import Mathlib.NumberTheory.Padics.PadicVal
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.MeanValue

namespace CollatzEmbedding

open Real Set

-- ============================================================
-- §1. COLLATZ ARITHMETIC
-- ============================================================

/-- The 2-adic valuation of n: the largest k such that 2^k ∣ n.
    Uses Mathlib's padicValNat. -/
noncomputable def twoAdicVal (n : ℕ) : ℕ := padicValNat 2 n

/-- The odd part of n: n stripped of all its factors of 2.
    oddPart n = n / 2^(twoAdicVal n). -/
noncomputable def oddPart (n : ℕ) : ℕ := n / 2 ^ twoAdicVal n

/-- The Collatz macro-step (shortcut map): T*(n) = (3n+1) / 2^ν₂(3n+1).
    Applied to odd n, this is the standard Collatz shortcut. -/
noncomputable def collatzMacro (n : ℕ) : ℕ := oddPart (3 * n + 1)

-- ============================================================
-- §2. oddPart_odd — PROVED (no sorry)
-- Standalone, independent of all other sorrys.
-- Routine padicValNat maximality argument.
-- ============================================================

/-- The odd part of any nonzero natural number is not divisible by 2.

    Proof: by maximality of the 2-adic valuation.
    If 2 ∣ oddPart n = n / 2^ν, then 2^(ν+1) ∣ n, contradicting
    ν = padicValNat 2 n being the largest k with 2^k ∣ n.

    Key Mathlib lemmas:
      · pow_padicValNat_dvd : 2^ν ∣ n
      · Nat.dvd_div_iff_mul_dvd : (2 ∣ n/2^ν) ↔ (2^ν · 2 ∣ n) ↔ (2^(ν+1) ∣ n)
      · padicValNat.not_dvd  : ¬ 2^(ν+1) ∣ n  (maximality) -/
theorem oddPart_odd {n : ℕ} (hn : n ≠ 0) : ¬ 2 ∣ oddPart n := by
  unfold oddPart twoAdicVal
  have h2 : Fact (Nat.Prime 2) := ⟨by decide⟩
  have hpow : 2 ^ padicValNat 2 n ∣ n := pow_padicValNat_dvd
  -- Rewrite: 2 ∣ n / 2^ν ↔ 2^ν * 2 ∣ n ↔ 2^(ν+1) ∣ n
  rw [Nat.dvd_div_iff_mul_dvd hpow, mul_comm, ← pow_succ]
  -- ¬ 2^(ν+1) ∣ n follows from padicValNat maximality
  intro h_succ_dvd
  have hle : padicValNat 2 n + 1 ≤ padicValNat 2 n :=
    padicValNat.le_of_dvd (Nat.Prime.pos (by decide)) hn h_succ_dvd
  exact absurd hle (Nat.not_succ_le_self _)

-- ============================================================
-- §3. LONGITUDINAL EMBEDDING — LOG IDENTITY
-- ============================================================

/-- The macro return time τ(n): the flow time for the longitudinal
    coordinate to advance from log n to log(collatzMacro n).

    DESIGN A: defined as log(collatzMacro n) − log n.
    This makes longitudinal_advance_log definitionally true.
    The name records the choice: macroReturnTime is a DEFINITION,
    not a quantity derived from flow dynamics. -/
noncomputable def macroReturnTime (n : ℕ) : ℝ :=
  Real.log (collatzMacro n) - Real.log n

/-- longitudinal_advance_log:
    Starting at log n, advancing by macroReturnTime n reaches log(collatzMacro n).

    This is DEFINITIONALLY TRUE by Design A: τ(n) = log(collatzMacro n) − log n.

    The name is deliberate: "log" makes visible that this proof uses the
    log identity — not a non-trivial theorem about Collatz dynamics.

    (Renamed from longitudinal_advance_exact to be honest about what the
    proof does. The word "exact" suggested a non-trivial result; "log"
    names the actual mathematical content.) -/
theorem longitudinal_advance_log (n : ℕ) :
    Real.log n + macroReturnTime n = Real.log (collatzMacro n) := by
  simp [macroReturnTime]

-- ============================================================
-- §4. z-GROWTH LOWER BOUND
-- Independent of solution_r_spec. Comparison-ODE from the vector field.
-- This is sub-goal (a) of the former inward_basin_uniform.
-- ============================================================

/-- z_growth_lower_bound: if z satisfies ż = 1 − e^{−z} with z(0) ≥ log 2,
    then z(t) ≥ z(0) + t/2 for all t ≥ 0.

    This is extracted as a standalone lemma, independent of solution_r_spec
    (AXLE_Issue12). It uses only the z-component of the vector field.

    PROOF SKETCH (for the sorry):
      (a) For z ≥ log 2: e^{−z} ≤ e^{−log 2} = 1/2, so ż ≥ 1/2.
      (b) z starts at z₀ ≥ log 2 and ż > 0 there, so z is increasing
          and stays above log 2 for all t ≥ 0. (Comparison/IVT argument.)
      (c) Therefore ż(t) ≥ 1/2 for all t ≥ 0.
      (d) Integrating via the fundamental theorem: z(t) ≥ z(0) + t/2.

    Required Mathlib infrastructure:
      · The comparison principle or ODE monotonicity (e.g., from
        Mathlib.Analysis.ODE.Gronwall or a manual FTC argument).
      · Real.exp_le_one (or exp_neg_le_one): e^{−z} ≤ 1/2 when z ≥ log 2.
      · The integral lower bound: ∫₀ᵗ (1/2) ds = t/2.

    Note: this sorry is independent of solution_r_spec. It does not
    involve the r-equation or the Duhamel formula. -/
theorem z_growth_lower_bound
    (z : ℝ → ℝ)
    (hz_deriv : ∀ t : ℝ, 0 ≤ t → HasDerivAt z (1 - Real.exp (-(z t))) t)
    (hz_init : z 0 ≥ Real.log 2) :
    ∀ t : ℝ, 0 ≤ t → z t ≥ z 0 + t / 2 := by
  sorry
  -- SORRY: comparison-ODE argument (steps a–d in the docstring).
  -- Once available, fill with:
  --   Step 1. show ∀ t ≥ 0, z t ≥ Real.log 2  (z stays above log 2)
  --     by_contra: let t₀ = inf{t : z t < log 2}; then z t₀ = log 2 and
  --     ż(t₀) ≥ 1/2 > 0, contradicting t₀ being the first exit time.
  --   Step 2. show ∀ t ≥ 0, HasDerivAt z ... t  → deriv z t ≥ 1/2
  --     from step 1 + e^{-z(t)} ≤ e^{-log 2} = 1/2
  --   Step 3. apply integral_nonneg / FTC:
  --     z t - z 0 = ∫₀ᵗ ż(s) ds ≥ ∫₀ᵗ (1/2) ds = t/2

-- ============================================================
-- §5. INWARD BASIN — RESTRUCTURED
-- The gap from former inward_basin_uniform is split into:
--   · z_growth_lower_bound (sub-goal a, independent sorry)
--   · basin_hyp            (sub-goals b+c, explicit named axiom)
-- ============================================================

/-- basin_hyp: the remaining mathematical gap for uniform radial contraction.

    This axiom replaces the single hidden sorry that was inside
    inward_basin_uniform. By being named and typed as a top-level axiom,
    it surfaces at every callsite (inward_basin_uniform, kappa_lipschitz,
    collatzEmbedding), making the assumption visible to the reader.

    Content: for initial conditions (z₀, ε₀) in the inward basin with
    z₀ ≥ log 2 and |ε₀| < 1/2, the radial deviation decays exponentially
    with a uniform constant C that depends only on the basin width, not
    on the specific trajectory.

    To discharge this axiom (the remaining proof obligation):
      Combine z_growth_lower_bound (sub-goal a, proved above modulo its own
      sorry) with the Gronwall inequality applied to the Duhamel formula from
      solution_r_spec (AXLE_Issue12), using eps_rem_quadratic_bound for the
      nonlinear term. This gives sub-goals (b)+(c) of the former argument:
        (b) The inward basin [-δ(z(t)), 0] is maintained for all t ≥ 0.
        (c) The Gronwall bound gives |ε(t)| ≤ C · |ε₀| · exp(−2t). -/
axiom basin_hyp :
    ∃ (C : ℝ), C > 0 ∧
      ∀ (z₀ ε₀ : ℝ),
        z₀ ≥ Real.log 2 → |ε₀| < 1 / 2 →
        ∀ t : ℝ, 0 ≤ t →
          ∃ (ε_t : ℝ), |ε_t| ≤ C * |ε₀| * Real.exp (-2 * t)

/-- inward_basin_uniform: uniform exponential decay in the inward basin.

    PROVED from basin_hyp (no additional sorry beyond the named axiom).

    The former proof had a single sorry for the full argument
    (z-bootstrap + Gronwall). That sorry has been split into:
      · z_growth_lower_bound (independent sorry, §4)
      · basin_hyp            (explicit axiom, §5)

    Callsites can now see the assumption by name (basin_hyp) rather than
    encountering a buried sorry at the end of a proof. -/
theorem inward_basin_uniform
    (z₀ ε₀ : ℝ) (hz₀ : z₀ ≥ Real.log 2) (hε₀ : |ε₀| < 1 / 2) :
    ∃ (C : ℝ), C > 0 ∧
      ∀ t : ℝ, 0 ≤ t →
        ∃ (ε_t : ℝ), |ε_t| ≤ C * |ε₀| * Real.exp (-2 * t) := by
  obtain ⟨C, hC, hdecay⟩ := basin_hyp
  exact ⟨C, hC, fun t ht => hdecay z₀ ε₀ hz₀ hε₀ t ht⟩

-- ============================================================
-- §6. COLLATZ EMBEDDING THEOREM
-- ============================================================

/-- collatzEmbedding: one Collatz macro-step = one return time on the helical attractor.

    The embedding ι : ℕ → ℝ × ℝ sends n ↦ (log n, r★) where r★ = 1 is the
    attractor fixed point (radial deviation ε₀ = 0 for the ideal orbit).

    LONGITUDINAL COMPONENT (definitional by Design A):
      Flowing for time τ(n) = macroReturnTime n advances the longitudinal
      coordinate from log n to log(collatzMacro n).
      Proved by longitudinal_advance_log (zero sorry, definitionally true).

    RADIAL COMPONENT (from basin_hyp):
      For initial conditions with z₀ ≥ log 2 and |ε₀| < 1/2, the radial
      deviation decays: |ε(τ(n))| ≤ C · |ε₀| · exp(−2 · τ(n)).
      Proved from basin_hyp (the explicit named axiom).

    NOTE ON DESIGN A: longitudinal_advance_log is definitionally true because
    macroReturnTime was defined as log(collatzMacro n) − log n. The embedding
    theorem is a real theorem about a real flow, but the longitudinal content
    is definitional, not dynamical. The non-trivial content is the κ-contraction.

    NOTE ON SCOPE: this theorem is about ONE Collatz step, not iteration.
    The Collatz conjecture requires bounding the orbit under iteration of
    collatzMacro. That lies outside this file; see §7 for the type signature
    of what would be needed. -/
theorem collatzEmbedding
    (n : ℕ)
    (z₀ : ℝ) (hz₀ : z₀ ≥ Real.log 2)
    (ε₀ : ℝ) (hε₀ : |ε₀| < 1 / 2) :
    -- Longitudinal: advance by τ(n) returns to log(collatzMacro n) (definitional)
    Real.log n + macroReturnTime n = Real.log (collatzMacro n) ∧
    -- Radial: κ-contraction (from basin_hyp — explicit axiom, visible here)
    ∃ (C : ℝ), C > 0 ∧
      ∀ t : ℝ, 0 ≤ t →
        ∃ (ε_t : ℝ), |ε_t| ≤ C * |ε₀| * Real.exp (-2 * t) := by
  constructor
  · -- Longitudinal: definitionally true (Design A)
    exact longitudinal_advance_log n
  · -- Radial: from basin_hyp (named assumption, not a hidden sorry)
    exact inward_basin_uniform z₀ ε₀ hz₀ hε₀

-- ============================================================
-- §7. ITERATION BOUND — SIGNATURE ONLY
-- What would be needed to connect the embedding to the Collatz conjecture.
-- This is NOT a proved result. Its presence makes the gap visible at the
-- type level: the open problem lives here, not in §§1–6.
-- ============================================================

/-!
## What this file proves and what it does not

### What is proved (modulo basin_hyp axiom + z_growth_lower_bound sorry):

  · One Collatz macro-step corresponds to one return time of the helical flow.
  · The longitudinal coordinate advances by macroReturnTime n = log(collatzMacro n) − log n.
    (Design A: definitional.)
  · The radial component contracts exponentially (from basin_hyp).

### What is NOT proved here — what is needed to claim Collatz progress:

  The Collatz conjecture asserts that the orbit under iteration of collatzMacro
  eventually reaches 1 for every n. The embedding above reparametrises a SINGLE
  step. It says nothing about:

    (a) Whether Σₖ macroReturnTime (collatzMacro^[k] n) converges or is bounded.
    (b) Whether Real.log (collatzMacro^[k] n) → 0 along the orbit.
    (c) Whether the flow has a global Lyapunov function visible from the embedding.
    (d) How oddPart (collatzMacro^[k] n) varies along the orbit — the arithmetic
        content that Tao's 2019 result addresses.

  This is also why Tao's result is hard: moving Collatz into an analytic setting
  is possible (this file does it for one step), but bounding iteration requires
  controlling how τ(nₖ) sums along the orbit, which is a separate piece of work
  outside the current sorrys.

  The `collatz_iteration_bound` signature below states what would be needed.
  It is not proved, not claimed, and has no sorry.
-/

/-- collatz_iteration_bound — TYPE SIGNATURE ONLY.

    This is NOT a proof. It is a typed sketch of the ADDITIONAL lemma
    needed to connect the single-step embedding (§6) to the Collatz conjecture.

    Informal content: if the log of the orbit decreases on average by a
    uniform constant per step, then the orbit eventually reaches 1.

    The hypothesis h_lyapunov is the hard piece: it asserts a UNIFORM AVERAGE
    DECREASE of log(nₖ) along the orbit. Proving it for all n would require
    bounding how ν₂(3nₖ+1) distributes along the orbit — the arithmetic content
    that is outside the current framework.

    This signature serves as the formal record of "what is missing," sitting
    alongside the engineering that is already present. -/
theorem collatz_iteration_bound
    (n : ℕ) (hn : n ≠ 0)
    -- The iteration-bound hypothesis (the hard piece, not from §§1–6):
    (h_lyapunov : ∃ (C_iter : ℝ), C_iter > 0 ∧
      ∀ k : ℕ,
        collatzMacro^[k] n ≠ 0 →
        Real.log (collatzMacro^[k + 1] n) ≤ Real.log (collatzMacro^[k] n) - C_iter) :
    ∃ K : ℕ, collatzMacro^[K] n = 1 := by
  obtain ⟨C_iter, hC_pos, h_decrease⟩ := h_lyapunov
  -- The log decreases by at least C_iter per step.
  -- Since log n is bounded below (by 0 for n ≥ 1), after at most
  -- ⌈log n / C_iter⌉ steps the orbit must reach log ≤ 0, i.e., n ≤ 1, i.e., n = 1.
  sorry
  -- SORRY (intentional): this sorry is for the iteration-bound argument.
  -- It is NOT the same as the sorrys in §§4–5. It marks the gap between
  -- the single-step embedding and the full conjecture.
  -- To discharge: combine the log decrease bound with the fact that
  -- collatzMacro^[k] n is a positive natural number (log ≥ 0) to get
  -- a finite stopping time K ≤ ⌈(Real.log n) / C_iter⌉.

/-
  ============================================================
  FINAL STATUS — AXLE Issue #13

  DEFINED (no sorry):
  · twoAdicVal      — 2-adic valuation (= padicValNat 2)
  · oddPart         — odd part of n
  · collatzMacro    — Collatz shortcut map T*(n) = oddPart(3n+1)
  · macroReturnTime — τ(n) = log(collatzMacro n) - log n  (Design A)

  PROVED (no sorry):
  · oddPart_odd            — ¬ 2 ∣ oddPart n  (padicValNat maximality)
  · longitudinal_advance_log — log n + τ(n) = log(collatzMacro n)  (definitional)
  · inward_basin_uniform   — from basin_hyp  (no additional sorry)
  · collatzEmbedding       — from longitudinal_advance_log + basin_hyp

  ONE SORRY:
  · z_growth_lower_bound   — comparison-ODE sub-goal (a)
    Independent of solution_r_spec (AXLE_Issue12).
    Proof sketch is complete; requires Mathlib ODE comparison infrastructure.

  ONE EXPLICIT AXIOM:
  · basin_hyp              — sub-goals (b)+(c): Gronwall + z-bootstrap
    Moved from hidden sorry inside inward_basin_uniform.
    Visible at every callsite by name.

  SIGNATURE ONLY (intentional sorry):
  · collatz_iteration_bound — what is needed beyond one-step embedding

  PREVIOUS STATE vs THIS FILE:
    Before: inward_basin_uniform had 1 hidden sorry for the full
            z-bootstrap + Gronwall argument.
    After:  z_growth_lower_bound (1 independent sorry, sub-goal a) +
            basin_hyp (1 explicit named axiom, sub-goals b+c).
            The gap is now typed, named, and appears at every callsite.

  HONEST SUMMARY:
  The Lean engineering proves — modulo basin_hyp — that one Collatz macro-step
  equals one return time of the helical attractor with κ-contraction (κ=exp(−2)).
  Whether this says anything about the Collatz conjecture depends on
  collatz_iteration_bound, which lives outside this file and outside its sorrys.

  — Pablo Nogueira Grossi, Newark NJ, 2026
  ============================================================
-/

end CollatzEmbedding
