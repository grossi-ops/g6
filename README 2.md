# AXLE — Automated eXtensible Lean Engine
### Formal Verification of GTCT Invariants · Principia Orthogona Book 3

[![Lean 4](https://img.shields.io/badge/Lean-4-blue)](https://leanprover.github.io/)
[![Mathlib4](https://img.shields.io/badge/Mathlib-4-green)](https://leanprover-community.github.io/mathlib4_docs/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Zenodo](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.19117400-blue)](https://doi.org/10.5281/zenodo.19117400)

**G6 LLC · Newark, New Jersey · 2026**  
Pablo Nogueira Grossi — ORCID: [0009-0000-6496-2186](https://orcid.org/0009-0000-6496-2186)

---

## What This Repository Is

AXLE is the formal verification companion to **The Mini-Beast** (Principia Orthogona Book 3) and the broader **Principia Orthogona** series. It formalizes, in Lean 4 + Mathlib4, every claim made in the three proofs of the Collatz conjecture presented within the **Generative Transition Contact Dynamics (GTCT)** framework.

---

## Mathematical Honesty Statement

> **The proofs in this repository are rigorous *within the GTCT axiomatic framework*.**  
> Whether GTCT constitutes a complete, conservative extension of ZFC mathematics is the open question of Volume VI.

What this means concretely:

| Claim | Status |
|-------|--------|
| Contact manifold setup, $H_0$, vector field equations | ✅ Standard differential geometry |
| Fold at $q=1$: $(q-1)^2(q+2)=0$ iff $c=3$ | ✅ Proved from calculus |
| Uniqueness of $c=3$ for integer fold | ✅ Proved (Theorem 1.6) |
| Hailstone bound $H(n) \leq 33^{1/3} n$ | ⚠️ **Empirically false** (see note below) |
| Crystal law $g^6 = 33$ | 🔵 GTCT Axiom 4 — asserted, not derived |
| Orthogonal stepping $\langle Pv,v\rangle = 0$ | 🔵 GTCT Axiom 5 — proved for specific $P$ in $D_6$ rep |
| Collatz map = Poincaré return map of $X_H$ | 🔵 Definitional embedding, not derived |
| Full Collatz convergence | 🔴 Open — depends on GTCT completeness |

### ⚠️ Hailstone Bound Note

The bound $H(n) \leq 33^{1/3} \cdot n \approx 3.21\,n$ is **false as a universal bound**. Counterexample: $n = 27$ reaches a maximum of $9232 \approx 342 \times 27$, far exceeding $3.21 \times 27 \approx 86.7$. The bound holds in the GTCT sense only after the trajectory has entered the basin of the limit cycle (post-fold). The text acknowledges this is "loose in practice" but the universal quantifier $\forall n \in \mathbb{N}^+$ is too strong.

---

## Repository Structure

```
axle/
├── lean/
│   ├── GTCT/
│   │   ├── Axioms.lean          # The 5 GTCT axioms as Lean declarations
│   │   ├── CrystalLaw.lean      # g^6 = 33 and the 33 constraints
│   │   ├── OrthogonalStepping.lean  # <Pv,v> = 0 for D_6 advance matrix
│   │   └── NilpotencyBound.lean # ε* = 1/3, C^3 = 0
│   ├── ContactGeometry/
│   │   ├── Manifold.lean        # Contact manifold (M, α), Darboux coords
│   │   ├── Hamiltonian.lean     # H_0 and H definitions, vector field
│   │   ├── FoldLemma.lean       # V(q) = q³−3q, fold at q=1
│   │   └── UniquenessC3.lean    # Theorem: c=3 iff fold at integer q=1
│   └── Collatz/
│       ├── Map.lean             # Collatz map definition
│       ├── Embedding.lean       # Informal embedding n ↦ q~n (sorry'd)
│       ├── Proof1_OperatorChain.lean
│       ├── Proof2_Hamiltonian.lean
│       ├── Proof3_PhaseResonance.lean
│       ├── HailstoneBound.lean  # Bound within GTCT (with caveats)
│       └── MainTheorem.lean     # Assembles all three proofs
├── python/
│   ├── collatz_check.py         # Verify hailstone bound empirically
│   ├── fold_analysis.py         # Plot V_c(q) for various c
│   └── phase_field.py           # D_6 phase advance matrix visualization
├── docs/
│   ├── FORMALIZATION_NOTES.md   # Detailed mathematical commentary
│   ├── SORRY_LEDGER.md          # Every sorry, why it's there, path to proof
│   ├── AXIOMS.md                # GTCT axioms in plain English + math
│   └── OPEN_QUESTIONS.md        # What Vol. VI needs to resolve
├── lakefile.toml
├── lake-manifest.json
└── README.md
```

---

## The Five GTCT Axioms

| # | Name | Statement |
|---|------|-----------|
| 1 | Operator Sequence | Every generative transition is $G = U \circ F \circ K \circ C$ |
| 2 | Critical Curvature | Fold occurs iff $|\kappa| = \kappa^* = 1/\text{foc}(x)$ |
| 3 | Contact Normal Form | Dynamics near limit cycle reduce to the dm³ normal form |
| 4 | Crystal Law | $g^6 = 33$ after six macro-applications of $G$ |
| 5 | Orthogonal Stepping | $\langle Pv, v \rangle = 0$ for the $D_6$ advance matrix $P$ |

---

## The Three Proofs (within GTCT)

### Proof 1: Discrete Operator-Chain Mapping
Embeds $n \in \mathbb{N}^+$ as a unit vector $\Delta(n) \in \mathbb{R}^{12}$ (regular rep of $D_6$). The composite operator $G^6$ saturates all 33 orthogonality constraints, forcing the unique fixed-point vector $v_{x^*}$ corresponding to the trivial cycle $\{1,2,4\}$.

### Proof 2: Contact-Hamiltonian Dynamics  
The Poincaré return map of $X_H$ on $\{z=0\}$ is identified with $T$. The unique hyperbolic limit cycle at $E=-2$ with $\mu_{\max}=-2$ attracts all trajectories exponentially. The pre-fold crystal scaling gives effective factor $33^{1/3}$.

### Proof 3: Phase-Field Resonance Locking  
The trivial cycle $\{1,2,4\}$ is the unique wavenumber-6 eigenmode of $P^6$ satisfying orthogonal stepping. The orthogenetic bias drives all phase vectors to $v_{\text{hex}}$ in finite steps.

---

## Sorry Ledger Summary

The AXLE Lean 4 files contain **9 honest sorrys** as documented in `docs/SORRY_LEDGER.md`. Each sorry corresponds to a specific mathematical gap:

1. The embedding $q \sim n$ (informal normalization)
2. That the Poincaré return map equals $T$ exactly
3. Crystal law $g^6 = 33$ (Axiom 4 — awaiting Vol. I derivation)
4. Transverse Lyapunov exponent $\mu_{\max} = -2$ (numerical, not symbolic)
5. Finite termination of the operator chain
6. That the 33 constraints are independent
7. Completeness of the $D_6$ representation
8. Hailstone bound universality (see note above)
9. GTCT ↔ ZFC conservativity

---

## Quick Start

```bash
# Install Lean 4 and Lake
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh

# Clone and build
git clone https://github.com/totogt/axle.git
cd axle
lake update
lake build
```

---

## Citation

```bibtex
@misc{grossi2026minibeast,
  author       = {Pablo Nogueira Grossi},
  title        = {The Mini-Beast: A Pilot for ESL Students, STEM Teachers,
                  and Everyone Who Suspects the Universe Runs on One Equation},
  publisher    = {G6 LLC},
  address      = {Newark, New Jersey},
  year         = {2026},
  doi          = {10.5281/zenodo.19117400},
  isbn         = {979-8-9954416-6-3},
  note         = {Principia Orthogona Book 3. MSC 2020: 37C10, 37C75, 53D10, 92C20, 91B55, 53Z99}
}
```

---

## Contact

Pablo Nogueira Grossi · [PabloGrossi@hotmail.com](mailto:PabloGrossi@hotmail.com)  
G6 LLC · Newark, New Jersey · 2026

---

## Supplement: Collatz as Corollary of Crystal Geometry

*Grossi (2026), Zenodo [10.5281/zenodo.19378742](https://doi.org/10.5281/zenodo.19378742)*

This supplement introduces the precise bridge between the continuous dm³ framework and the discrete Collatz map. Eight quantitative bridges are **fully verified** (`python/bridges.py`):

| Bridge | Claim | Status |
|--------|-------|--------|
| B1 | 33 = 3 × 11 = 3 × (phase_dim − 1) | ✅ |
| B2 | 6 = 2 × 3 = hex period = trivial cycle G-steps | ✅ |
| B3 | Geometric mean of T*(n)/n = **3/4** for c=3 | ✅ |
| B4 | Geometric mean of T*(n)/n = **5/4** for c=5 (expanding) | ✅ |
| B5 | c=3 is the unique odd integer with geometric mean < 1 | ✅ |
| B6 | log(3/4) < 0 ↔ μ_max = -2 in normalised units | ✅ |
| B7 | τ·ε₀ = 2/3 (AXLE verified constant) | ✅ |
| B8 | Arithmetic mean ≈ 1; geometric mean = 3/4 (distinction matters) | ✅ |

### AXLE Target 5: What remains

Three precise technical gaps (identified in the supplement):

1. **Smoothness gap**: dm³ requires C² flows; define "discrete dm³ membership" without smoothness. Candidate: use V(n) = log(n) as discrete Lyapunov function.
2. **Lyapunov gap**: V = (r−1)² is pointwise monotone; V_disc = log(n) decreases only on geometric average (log(3/4) < 0 per shortcut step). Formalise average descent.
3. **Category gap**: Extend dm³ to a category dm³_ext including discrete systems. This is the "higher-order logic" of the supplement.

See `lean/Collatz/DiscreteDM3Bridge.lean` for the Lean 4 formalisation of the bridges and gap targets.
