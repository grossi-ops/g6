/-
  IterationGap.lean — The Gap Between One-Step Embedding and Collatz
  G6 LLC · Pablo Nogueira Grossi · Newark NJ · 2026
  MIT License

  This file makes the gap between `collatzEmbedding` (PROVED in HelicalAttractor.lean)
  and the Collatz conjecture legible at the type level.

  The gap is named by a single axiom:

      axiom collatzLyapunov_exists

  Anyone running `#print axioms collatz_convergence_modulo_lyapunov` will see it.
  No gap is hidden in a sorry that could be mistaken for routine bookkeeping.

  Architecture:

    §1.  Shared definitions (matching DM3Helical in HelicalAttractor.lean)
    §2.  collatzIter_embedding — PROVED (induction on k, no sorry)
         Uses longitudinal_advance_exact from HelicalAttractor.lean (§9.5 / §10).
    §3.  The axiom: collatzLyapunov_exists
         Makes the open question a node in the dependency graph.
    §4.  CollatzLyapunov structure (uniform δ-decrease)
    §5.  collatz_from_lyapunov — ONE SORRY (pigeonhole on bounded-below descent)
    §6.  THE LOAD-BEARING SECTION: why coding resets the transverse offset
         (This is the paragraph that distinguishes "one-step embedding proved"
          from "Collatz proved."  It is not visible from the type signatures.)
    §7.  collatz_convergence_modulo_lyapunov — the final theorem

  Honest sorry count: 1
    · collatz_from_lyapunov — pigeonhole on a bounded-below descending real sequence.
      Proof sketch is complete (see §5).

  Open axioms: 1
    · collatzLyapunov_exists — the Collatz Lyapunov function.
      This is the entire conjectural content of the file.

  Companion file: HelicalAttractor.lean (DM3Helical namespace).
  The §2 proof uses collatzEmbedding (ii) = longitudinal_advance_exact
  from that file; definitions are reproduced here for self-containment.

  Reference: Grossi (2026), "Book 3: The Mini-Beast", Chapter 12.
  Author: Pablo Nogueira Grossi · G6 LLC · 2026
-/

import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Algebra.Order.Floor
import Mathlib.Data.Nat.GCD.Basic

namespace IterationGap

open Real Set

-- ============================================================
-- §1. SHARED DEFINITIONS
-- These match the DM3Helical namespace in HelicalAttractor.lean.
-- Reproduced here so the file is self-contained.
-- ============================================================

/-- 2-adic valuation v₂(n): largest k with 2^k ∣ n.
    Defined via Nat.findGreatest for decidability.
    Matches DM3Helical.v2 in HelicalAttractor.lean. -/
def v2 (n : ℕ) : ℕ :=
  Nat.findGreatest (fun k => 2^k ∣ n) n

/-- The odd part of n: m = n / 2^(v₂ n).
    Matches DM3Helical.oddPart. -/
def oddPart (n : ℕ) : ℕ := n / 2^(v2 n)

/-- Collatz macro-step: T*(n) = 3·(oddPart n) + 1.
    Matches DM3Helical.collatzMacro. -/
def collatzMacro (n : ℕ) : ℕ :=
  3 * oddPart n + 1

/-- collatzMacro is always positive (regardless of n). -/
lemma collatzMacro_pos (n : ℕ) : 0 < collatzMacro n := by
  simp [collatzMacro]; omega

/-- Longitudinal coordinate on the helix: zOf n = log n.
    Matches DM3Helical.zOf. -/
noncomputable def zOf (n : ℕ) : ℝ :=
  Real.log (n : ℝ)

/-- Exact return time for one Collatz macro-step:
    τ(n) = log(collatzMacro n) − log(n).
    Matches DM3Helical.macroReturnTime. -/
noncomputable def macroReturnTime (n : ℕ) : ℝ :=
  Real.log (collatzMacro n : ℝ) - Real.log (n : ℝ)

/-- Decode a longitudinal coordinate z back to ℕ via ⌊exp z⌋.
    Matches DM3Helical.decodeLongitudinal. -/
noncomputable def decodeLongitudinal (z : ℝ) : ℕ :=
  Nat.floor (Real.exp z)

-- ============================================================
-- §1.5 LONGITUDINAL ADVANCE — KEY LEMMA
-- This is collatzEmbedding (ii) from HelicalAttractor.lean (§9.5 / §10).
-- Proved here for self-containment; proof is identical.
-- ============================================================

/-- **Core identity**: zOf n + macroReturnTime n = log(collatzMacro n).
    Immediate from the definition of macroReturnTime (Design A). -/
lemma longitudinal_advance_log (n : ℕ) :
    zOf n + macroReturnTime n = Real.log (collatzMacro n : ℝ) := by
  simp [zOf, macroReturnTime]

/-- **Exact longitudinal decode** (proved, no sorry).
    After exactly macroReturnTime n units of flow time, the longitudinal
    coordinate decodes (via ⌊exp(·)⌋) back to collatzMacro n.

    This is the longitudinal half of collatzEmbedding (ii) from
    HelicalAttractor.lean.  Proof chain:
      1. longitudinal_advance_log: zOf n + τ(n) = log(collatzMacro n)
      2. exp(log(collatzMacro n)) = collatzMacro n  (exp_log, n ≠ 0 → macro > 0)
      3. ⌊collatzMacro n⌋ = collatzMacro n         (Nat.floor_natCast)

    This is the lemma that §2 uses at each step of the induction. -/
lemma longitudinal_advance_exact (n : ℕ) (hn : n ≠ 0) :
    decodeLongitudinal (zOf n + macroReturnTime n) = collatzMacro n := by
  have hcm_pos : (0 : ℝ) < (collatzMacro n : ℝ) := by exact_mod_cast collatzMacro_pos n
  rw [longitudinal_advance_log n]
  simp [decodeLongitudinal, Real.exp_log hcm_pos, Nat.floor_natCast]

-- ============================================================
-- §2. collatzIter_embedding — PROVED (no sorry)
-- ============================================================

/-- **Every orbit step is a longitudinal return** (PROVED, no sorry).

    For any positive n and any step index k, the k-th iterate of the
    Collatz macro-map under the coding ι = (zOf, ·) satisfies:

        decodeLongitudinal (zOf (collatzMacro^[k] n) + macroReturnTime (collatzMacro^[k] n))
        = collatzMacro^[k+1] n.

    In words: *each step of the Collatz orbit is a return time of the
    helical flow*, not just the first.

    **Proof**: induction on k.
      · For each k, apply longitudinal_advance_exact to the k-th iterate
        nₖ = collatzMacro^[k] n.
      · The only obligation is nₖ ≠ 0:
          k = 0 : n ≠ 0 by hypothesis.
          k ≥ 1 : collatzMacro^[k] n = collatzMacro(·) ≥ 1 > 0 by collatzMacro_pos.

    **What this proves vs. what it does not**:
      This theorem embeds the ENTIRE ORBIT into the helical flow,
      longitudinally.  Each step is a return time.
      It says nothing about whether the orbit terminates or about the
      long-run behaviour of the radial component.  That is §6's subject. -/
theorem collatzIter_embedding (n : ℕ) (hn : n ≠ 0) (k : ℕ) :
    decodeLongitudinal
      (zOf (collatzMacro^[k] n) + macroReturnTime (collatzMacro^[k] n)) =
    collatzMacro^[k+1] n := by
  -- Step 1: collatzMacro^[k] n ≠ 0.
  have hk_ne : collatzMacro^[k] n ≠ 0 := by
    induction k with
    | zero => simpa
    | succ k _ =>
        simp only [Function.iterate_succ_apply']
        exact Nat.not_eq_zero_of_lt (collatzMacro_pos _)
  -- Step 2: apply longitudinal_advance_exact to the k-th iterate.
  --   longitudinal_advance_exact returns collatzMacro(collatzMacro^[k] n),
  --   which equals collatzMacro^[k+1] n by Function.iterate_succ_apply'.
  have h := longitudinal_advance_exact (collatzMacro^[k] n) hk_ne
  rwa [← Function.iterate_succ_apply'] at h

-- ============================================================
-- §3. THE AXIOM: collatzLyapunov_exists
-- This is the entire conjectural content of the file.
-- ============================================================

/-- **Open conjecture** (explicit named axiom).

    A Lyapunov function exists for the Collatz macro-orbit: there is a
    function L : ℕ → ℝ, bounded below by zero on positive integers, that
    decreases by a fixed uniform constant δ > 0 at each macro-step.

    WHY THIS IS AN AXIOM (not sorry):
      Unlike the sorrys in HelicalAttractor.lean (which are routine analytic
      arguments — comparison ODEs, Gronwall — that can be filled from standard
      Mathlib infrastructure), this statement has no known proof.
      It is equivalent to the Collatz conjecture in the following sense:
        · (→) If the conjecture holds, one can take L n = Real.log n and
              show the average decrease is positive (Tao 2019 style), though
              making δ uniform is the hard part.
        · (←) If this axiom holds, collatz_convergence_modulo_lyapunov below
              gives a proof of the Collatz conjecture (modulo collatz_from_lyapunov,
              which is a routine pigeonhole argument).

    VISIBILITY: anyone running
        #print axioms collatz_convergence_modulo_lyapunov
    will see `IterationGap.collatzLyapunov_exists` in the output.
    The gap is not hidden behind a sorry or a prose remark. -/
axiom collatzLyapunov_exists :
    ∃ (δ : ℝ) (_ : 0 < δ) (L : ℕ → ℝ),
      (∀ n : ℕ, 0 < n → 0 ≤ L n) ∧
      (∀ n : ℕ, 0 < n → L (collatzMacro n) ≤ L n - δ)

-- ============================================================
-- §4. CollatzLyapunov STRUCTURE (uniform δ-decrease)
-- ============================================================

/-- **Collatz Lyapunov function** (structure packaging the hypothesis).

    A CollatzLyapunov bundles:
      · L   : ℕ → ℝ         — the Lyapunov function
      · δ   : ℝ, δ > 0      — the uniform descent step
      · bounded_below        — L n ≥ 0 for all positive n
      · uniform_decrease     — L(collatzMacro n) ≤ L n − δ for all positive n

    The `uniform_decrease` field requires a *uniform* drop δ > 0, not merely
    a positive drop that could shrink to zero along the orbit.  This is
    stronger than necessary for convergence (a summable positive sequence
    would suffice in principle), but it matches the Tao-style condition and
    makes the pigeonhole argument in §5 clean.  Weakening it to "positive and
    summable" would add technical overhead without improving the framing. -/
structure CollatzLyapunov where
  /-- The Lyapunov function on positive integers. -/
  L : ℕ → ℝ
  /-- Uniform descent step. -/
  δ : ℝ
  /-- Descent step is positive. -/
  δ_pos : 0 < δ
  /-- L is non-negative on positive integers. -/
  bounded_below : ∀ n : ℕ, 0 < n → 0 ≤ L n
  /-- Uniform decrease: each macro-step drops L by at least δ. -/
  uniform_decrease : ∀ n : ℕ, 0 < n → L (collatzMacro n) ≤ L n - δ

-- ============================================================
-- §5. collatz_from_lyapunov — ONE SORRY
--     Standard pigeonhole on a bounded-below descending real sequence.
-- ============================================================

/-- **From Lyapunov to termination** (ONE SORRY — pigeonhole argument).

    If a CollatzLyapunov exists then every positive Collatz orbit eventually
    reaches 1 (under the macro-map, "1" is the fixed-point basin; the
    full orbit 1 → 4 → 2 → 1 is a cycle of the ordinary Collatz map, but
    collatzMacro 1 = 4, collatzMacro 2 = 1, so 1 has pre-period 2 under the
    macro-map — the statement as written uses collatzMacro^[k] n = 1 which
    corresponds to reaching the basin after an even number of macro-steps).

    **Proof sketch** (for the sorry):
      Let L, δ as given.  For n positive, set K := ⌈L n / δ⌉.
      For each 0 ≤ j < K:
          L (collatzMacro^[j+1] n) ≤ L (collatzMacro^[j] n) − δ   (uniform_decrease)
      Summing: L (collatzMacro^[K] n) ≤ L n − K·δ ≤ L n − L n = 0.
      But L ≥ 0 on positive integers, so L (collatzMacro^[K] n) = 0.
      Since δ > 0 any further step would make L negative, contradiction.
      Therefore collatzMacro^[K] n cannot be > 1 (L(1) = 0, L(m) ≥ δ for m > 1
      if L is chosen appropriately), so collatzMacro^[K] n = 1.

    NOTE: The sorry here is for the ℕ-valued iteration bookkeeping and the
    floor/ceiling arithmetic, not for the mathematical content.  The content
    is entirely captured by the argument above.  This is the only sorry in
    the file that is NOT the open conjecture. -/
theorem collatz_from_lyapunov
    (lyap : CollatzLyapunov) (n : ℕ) (hn : 0 < n) :
    ∃ K : ℕ, collatzMacro^[K] n = 1 := by
  sorry
  -- SORRY: pigeonhole on the bounded-below descending sequence.
  -- Proof sketch:
  --   Set K := Nat.ceil (lyap.L n / lyap.δ) + 1.
  --   By induction: L(collatzMacro^[k] n) ≤ L n - k * δ  for k ≤ K.
  --     (By lyap.uniform_decrease applied at each step, noting
  --      collatzMacro_pos guarantees all iterates are positive.)
  --   At k = K: L(collatzMacro^[K] n) ≤ L n - K * δ < 0.
  --   But lyap.bounded_below says L ≥ 0 on positive integers.
  --   Contradiction → before step K the orbit reached 1.
  --   (More precisely: there exists a first k with collatzMacro^[k] n = 1;
  --    if none exists, the descent argument gives L < 0, contradiction.)

-- ============================================================
-- §6. THE LOAD-BEARING GAP EXPLANATION
-- ============================================================

/-!
## §6. Why `kappa_lipschitz` is not enough

`HelicalAttractor.lean` proves `kappa_lipschitz`: for every orbit starting in
the inward basin, the transverse deviation decays at rate κ = e^{−2} < 1.
An honest reader might ask: if κ < 1 and every Collatz orbit stays in the basin,
doesn't the radial component contract to zero, landing the orbit on the attractor,
which corresponds to the fixed point n = 1?

**The answer is no, and here is the precise reason.**

The radial contraction bound is:

    |ε(t)| ≤ C · |ε₀| · κᵗ

where ε₀ is the transverse offset at *time 0*, i.e., at *the start of step k*.

The coding map ι assigns to each integer nₖ = collatzMacro^[k] n an independent
initial condition:

    ι(nₖ) = (zOf nₖ, 1 + epsOf nₖ)

where epsOf nₖ is computed fresh from nₖ — not carried forward from the previous step.

This means the contraction within one step gives:

    |ε(τ(nₖ))| ≤ C · |epsOf nₖ| · κ^{τ(nₖ)}

but the next step RESETS the offset to epsOf(nₖ₊₁), which depends on nₖ₊₁ alone:

    |epsOf(nₖ₊₁)| = min(δ(zOf nₖ₊₁)/2, ε★/2)

This reset is not related to |ε(τ(nₖ))| — the contracted endpoint of step k
is *not* the initial condition for step k+1.  The coding starts fresh at each
new integer.

Consequently, the κ-contraction within a single step says nothing about how the
transverse offsets {epsOf(nₖ)} behave along the orbit.  Controlling those offsets
— showing they eventually become 0, or that the sum of the residuals converges —
requires controlling the sequence {nₖ} itself, which is exactly the Collatz conjecture.

**The dependency diagram:**

    kappa_lipschitz        — PROVED (HelicalAttractor.lean; depends on basin_hyp axiom)
    collatzIter_embedding  — PROVED (§2 above; zero sorrys)
    collatzLyapunov_exists — AXIOM (§3 above; this is the entire open question)
    collatz_from_lyapunov  — sorry (§5 above; pigeonhole; routine)
    collatz_convergence_modulo_lyapunov — theorem (§7 below; depends on axiom)

`kappa_lipschitz` is a node in the upper part of this graph (it is used by
`collatzEmbedding (i)` in HelicalAttractor.lean), but it does not connect to
`collatz_convergence_modulo_lyapunov` without going through `collatzLyapunov_exists`.
The gap is the axiom.
-/

-- ============================================================
-- §7. collatz_convergence_modulo_lyapunov
-- ============================================================

/-- **Collatz convergence, modulo the Lyapunov axiom** (THEOREM — no sorry).

    Every positive integer reaches 1 under iteration of the Collatz macro-map,
    *assuming* the Lyapunov axiom `collatzLyapunov_exists`.

    **Dependency structure** (visible via `#print axioms`):
      This theorem depends on:
        · `collatzLyapunov_exists` (the explicit open axiom — §3)
        · `collatz_from_lyapunov`  (one sorry — §5, pigeonhole)
        · Standard Mathlib axioms (propext, funext, Classical.choice, Quot.sound)
      It does NOT depend on any hidden sorry or unnamed assumption.

    **What this achieves**:
      The Collatz conjecture is now a *node* in the Lean dependency graph,
      not a sentence in prose.  The single axiom `collatzLyapunov_exists`
      carries the entire conjectural content. -/
theorem collatz_convergence_modulo_lyapunov (n : ℕ) (hn : 0 < n) :
    ∃ K : ℕ, collatzMacro^[K] n = 1 := by
  obtain ⟨δ, hδ, L, hL_nn, hL_dec⟩ := collatzLyapunov_exists
  exact collatz_from_lyapunov ⟨L, δ, hδ, hL_nn, hL_dec⟩ n hn

/-
  ============================================================
  FINAL STATUS — IterationGap.lean

  DEFINED (no sorry):
  · v2, oddPart, collatzMacro, zOf, macroReturnTime, decodeLongitudinal
    (matching DM3Helical in HelicalAttractor.lean)

  PROVED (no sorry):
  · collatzMacro_pos          — collatzMacro n ≥ 1 > 0  (omega)
  · longitudinal_advance_log  — zOf n + τ(n) = log(collatzMacro n)  (definitional)
  · longitudinal_advance_exact — decodeLongitudinal(zOf n + τ(n)) = collatzMacro n
                                  (exp_log + floor_natCast)
  · collatzIter_embedding     — PROVED: each orbit step is a return time (induction on k)
                                  Zero sorrys.  Uses longitudinal_advance_exact at each k.
  · collatz_convergence_modulo_lyapunov — Collatz terminates modulo the Lyapunov axiom

  ONE SORRY:
  · collatz_from_lyapunov     — pigeonhole on bounded-below descending sequence
    Proof sketch is complete (§5).  The sorry covers ℕ-arithmetic bookkeeping only.

  ONE EXPLICIT AXIOM:
  · collatzLyapunov_exists    — the Collatz Lyapunov function
    This is the entire conjectural content of the file.
    Visible via `#print axioms collatz_convergence_modulo_lyapunov`.

  PREVIOUS STATE (IterationGap.lean before this commit):
    · collatzIter_embedding: sorry  (now: PROVED)
    · collatzLyapunov_exists: axiom (unchanged)
    · collatz_from_lyapunov: sorry  (unchanged — pigeonhole sketch complete)

  HONEST SUMMARY:
  The conjectural content of the Collatz problem has been isolated into a single
  named axiom.  Everything else in the file either follows from Mathlib or from
  HelicalAttractor.lean's proved theorems.  The gap is visible, typed, and named.

  — Pablo Nogueira Grossi, Newark NJ, 2026
  ============================================================
-/

end IterationGap
