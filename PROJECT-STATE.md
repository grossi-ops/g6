# Book 3: The Mini-Beast — Project State
**G6 LLC · Pablo Nogueira Grossi · Updated: 2026-04-12**

---

## Operator Chain
```
G = U ∘ F ∘ K ∘ C
C = Compression  (blue       #4a9eff)
K = Threshold    (red-orange #e05a3a)
F = Fold         (green      #50c878)
U = Unfolding    (violet     #c084fc)
G = Conclusion   (amber      #f59e0b)
Nirvana          (ice-cyan   #67e8f9)
```

---

## Repo Architecture (Three Public Repos + One Private)

| Repo | URL | Purpose | Key files |
|------|-----|---------|-----------|
| TOTOGT/DM3-lab | totogt.github.io/DM3-lab/ | **Main live site** — chapters, portal, course | course-16weeks, chapters-diagram, Sportal, impa-portal, trilogy-sale, ch-*, sim-*, spectral-*, wigner-fractal, Lean proofs, LaTeX |
| TOTOGT/AXLE | totogt.github.io/AXLE/ | Formal verification hub | Lean proofs, mappings, scripts, simulations, portal mirror |
| TOTOGT/book3-starter | totogt.github.io/book3-starter/ | GitHub Classroom template | Students fork; minimal starter (assignments/, resources/) |
| g6-LLC/B3 | private | Draft/staging | All source files before publication |

**Primary upload target: TOTOGT/DM3-lab** (chapters go here; all relative nav links resolve at this root).

### Nav Link Resolution (all relative, all resolve in DM3-lab root)
| Link | File location | Status |
|------|--------------|--------|
| Sportal.html | DM3-lab root | ✓ capital S — fixed in all chapters |
| impa-portal.html | DM3-lab, book3-starter, AXLE | ✓ |
| course-16weeks.html | DM3-lab root | ✓ |
| chapters-diagram.html | DM3-lab root | ✓ |
| trilogy-sale.html | DM3-lab root | ✓ |

---

## Chapter Status — ALL 0–13 COMPLETE ✓

Actual filenames confirmed from g6-LLC/B3 repo listing (2026-04-12):

| Ch | File (B3 repo) | Title (inferred) | Operator | CEFR | B3 repo | book3-starter live |
|----|----------------|-----------------|----------|------|---------|-------------------|
| 00 | ch00-introduction.html | Introduction | — | A2 | ✓ | ⬆ needs upload |
| 1  | ch1-seed.html | The Seed | C | B1 | ✓ | ⬆ needs upload |
| 2  | ch2-allostatic.html | Allostatic Load | C→K | B1 | ✓ | ⬆ needs upload |
| 3  | ch3-circadian.html | Circadian Rhythm | K | B1 | ✓ | ✓ LIVE |
| 4  | ch4-neural.html | Neural Oscillations | K | B1 | ✓ | ✓ LIVE |
| 5  | ch5-immune.html | Immune Adaptation | K→F | B1→B2 | ✓ | ⬆ needs upload |
| 6  | ch6-resonant.html | Resonance (Falsifiability) | F | B2 | ✓ | ⬆ needs upload |
| 7  | ch7-crystalline.html | Crystalline Structure | F | B2→C1 | ✓ | ⬆ needs upload |
| 8  | ch8-axiomatic.html | Axiomatic Foundations | F→U | C1 | ✓ | ⬆ needs upload |
| 9  | ch9-phi.html | φ — Subcritical Approach | F→U | C1→D1 | ✓ | ⬆ needs upload |
| 10 | ch10-lyapunov.html | Lyapunov Stability | U | D1 | ✓ | ⬆ needs upload |
| 11 | ch11-spectral.html | Spectral Radius | U | D1→D2 | ✓ | ⬆ needs upload |
| 12 | ch12-conclusion.html | Fixed Point / Conclusion | G | D1→D2 | ✓ | ⬆ needs upload |
| 13 | ch13-revision.html | Nirvana Machine / Annealing | — | D2 | ✓ | ⬆ needs upload |

**Special / bonus chapters also in B3:**

| File | Notes |
|------|-------|
| ch-e-gtct.html / chE-gtct.html | GTCT sample chapter |
| chPI-recurrence.html | π / recurrence bonus |
| chW-wigner.html | Wigner sample (free) |
| ch01-cajueiro.html | Alternate ch1 (cajueiro) |
| ch01-dm3-framework.html | DM3 framework variant |
| ch02-biological.html | Biological reading variant |
| ch02-reading.html | Reading variant |
| ch03-plasma.html | Plasma variant |
| ch03-sources.html | Sources variant |
| ch04-markets.html | Markets application |
| ch04-milestone1.html | Milestone 1 checkpoint |
| ch05-oscillations.html | Oscillations variant |
| ch06-argument.html | Argument structure variant |
| ch06-pedagogy.html | Pedagogy variant |
| spectral-radius.html / spectral-radius-v2.html | Standalone spectral demos |
| wigner-fractal.html | Wigner fractal demo |
| living-book.html | Living book meta-page |

---

## Other Key Files in B3 Repo

### HTML / Portal
| File | Purpose |
|------|---------|
| index.html | Book 3 landing page |
| impa-portal.html / impa-portal (2).html | AXLE payment portal |
| course-16weeks.html | 16-week ESL course schedule |
| chapters-diagram.html | Visual chapter map |
| book3-starter-index.html | book3-starter index variant |
| dm3-lab-index.html | DM3 lab index |
| trilogy-sale.html | Trilogy sales page |
| sample-chapter-tubulin.html | Free sample T |
| sample-chapter-wigner.html | Free sample W |
| chapters-pi-phi-mu-eta-delta-sigma-omega.html | Greek letter chapters |

### Lean 4 (AXLE formal verification)
| File | Notes |
|------|-------|
| Main.lean | Main Lean 4 proof |
| Main_v2.lean … Main_v5.lean | Revision iterations |
| Main_v3_corrected.lean | Corrected v3 |
| DiscreteDM3Bridge.lean | DM3 bridge proof |
| Finite.lean | Finite structure proof |
| AXLE_Issue12.lean | **Issue #12** — κ-Lipschitz helical attractor (kappa_lipschitz + eps_rem_quadratic_bound) — superseded by HelicalAttractor.lean |
| HelicalAttractor.lean | **Issue #12 (active)** — unified helical attractor + Collatz bridge; `oddPart_odd` proved; `eps_rem_quadratic_bound` proved; `kappa_lipschitz` proved; 2 honest sorrys + 1 explicit axiom |
| AXLE_CollatzEmbedding.lean | **Issue #13** — Collatz–helical attractor embedding; honest dependency graph; `oddPart_odd` proved; `longitudinal_advance_log` (renamed); `basin_hyp` explicit axiom; `collatz_iteration_bound` signature |

#### AXLE Issue Tracker (Lean)
| Issue | File | Status | Remaining sorrys |
|-------|------|--------|-----------------|
| #5 | Main_v4.lean | ✓ Closed in v5 | 0 |
| #6 | Main_v5.lean | ✓ Closed — zero sorry | 0 |
| #12 | AXLE_Issue12.lean | 🟡 Superseded by HelicalAttractor.lean | — |
| #12 | **HelicalAttractor.lean** | 🟡 In progress | 3 (see below) |
| #13 | AXLE_CollatzEmbedding.lean | 🟡 In progress | 1 sorry + 1 explicit axiom + 1 intentional signature-sorry |

**HelicalAttractor.lean** — current sorry map (3 total):

| Sorry | Location | Why honest |
|-------|----------|-----------|
| `solution_r_spec` | §3 | Needs Picard–Lindelöf ODE existence + variation of constants |
| `inward_basin_uniform` | §5 | Needs z(t) bootstrap (comparison ODE) + Gronwall inequality |
| `oddPart_odd` | §7 | Routine 2-adic divisibility; low priority |

**Proved (no sorry) in HelicalAttractor.lean:**
- `eps_rem_quadratic_bound` — filled with comparison + abs-bound chain (C₀ = 1 + e^Rz)
- `kappa_lipschitz` — clean: C₀ uniform before orbit, no structural sorry
- `v2_dvd` — 2^v₂(n) ∣ n via Nat.findGreatest_spec
- `epsOf_in_basin` — coding point always inside the inward basin [-δ(z₀), 0]
- `longitudinal_advance_core` — zOf n + macroReturnTime_approx n = log(3·oddPart n)
- `longitudinal_advance_exact` — zOf n + macroReturnTime n = log(collatzMacro n) (trivial)
- `macroReturnTime_approx_diff` — exact vs. approx differ by log(1 + 1/(3·oddPart n))
- `collatzEmbedding (i) + (ii)` — both parts proved; (ii) closed by exact macroReturnTime

**Key design (new):** `macroReturnTime n := log(collatzMacro n) − log(n)` makes the longitudinal advance exact by definition, closing `collatzEmbedding (ii)` without any sorry. The user's formula `log 3 − v₂(n)·log 2` is `macroReturnTime_approx`; the gap `log(1 + 1/(3·oddPart n)) → 0` is bounded in `macroReturnTime_approx_diff`.

**Next steps:**
1. Prove `inward_basin_uniform` via Mathlib Gronwall (MeasureTheory.Interval.Gronwall)
2. Prove `oddPart_odd` by induction on v2 (closes last routine sorry)
3. Iterate `collatzEmbedding` to build the full Collatz descent chain on the attractor
4. Handle the cycle Γ = {1,2,4} as fixed/periodic points on the helix

**Issue #13 — AXLE_CollatzEmbedding.lean — Collatz–helical attractor embedding**

Honest dependency graph (all gaps named and typed):

| Name | Status | Notes |
|------|--------|-------|
| `oddPart_odd` | ✓ PROVED | Standalone; padicValNat maximality |
| `longitudinal_advance_log` | ✓ PROVED | Definitionally true (Design A); renamed from `longitudinal_advance_exact` to expose the log identity |
| `z_growth_lower_bound` | 🟡 1 sorry | Comparison-ODE, sub-goal (a); independent of `solution_r_spec` |
| `basin_hyp` | ⚠️ explicit axiom | Sub-goals (b)+(c): Gronwall + z-bootstrap; moved from hidden sorry in `inward_basin_uniform` |
| `inward_basin_uniform` | ✓ from axiom | Proved from `basin_hyp`; no additional sorry |
| `collatzEmbedding` | ✓ from axiom | Proved; `basin_hyp` visible at callsite |
| `collatz_iteration_bound` | 📋 signature only | What is needed beyond one-step embedding to claim Collatz progress; intentional sorry |

**Issue #13 next steps (in order of leverage):**
1. Fill `z_growth_lower_bound` sorry: comparison-ODE from `ż = 1 − e^{−z}`, independent of `solution_r_spec`. Key: `e^{−z} ≤ ½` for `z ≥ log 2` → `ż ≥ ½` → integrate.
2. Discharge `basin_hyp`: apply Gronwall to Duhamel formula (from `solution_r_spec` in AXLE_Issue12) using `z_growth_lower_bound` + `eps_rem_quadratic_bound`. Closes sub-goals (b)+(c).
3. At that point: zero hidden sorrys; one ODE-existence axiom (`solution_r_spec`) and the honest boundary at `collatz_iteration_bound`.

**Design note — Design A vs Design B:**
`macroReturnTime n := log(collatzMacro n) − log n` (Design A). This makes `longitudinal_advance_log` definitionally true. The cleanness of Design A is also the admission that the embedding theorem, at the longitudinal level, is a definition not a result. The non-trivial content is the κ-contraction (from `basin_hyp`).

**Scope note:**
The file proves: one Collatz step = one return time. The Collatz conjecture is about iteration. What is missing is `collatz_iteration_bound` — bounding how `τ(nₖ)` sums along the orbit, which is outside the current file and its sorrys.

### LaTeX (source manuscripts)
| File | Notes |
|------|-------|
| MASTER.tex | Master document |
| master_book.tex … master_book_FINAL_v2.tex | Book master iterations |
| main.tex … main-4.tex / main_fixed.tex | Main manuscript versions |
| Monster13.tex / MonsterPaper_GROSSI2026*.tex | Monster paper |
| Fractal_Time_Crystals*.tex | Fractal time crystals paper |
| book2_outline.tex / book2_preface_ch1.tex | Book 2 materials |
| completePrincipia.tex / principia_vol2.tex | Principia volumes |
| formalizations_Book2.tex | Book 2 formalizations |
| g6_scale_invariance.tex | Scale invariance paper |
| minibeast_gtct_chapter_E.tex | GTCT chapter E source |
| chapter 09 mars.tex / chapter_eight_things.tex | Chapter sources |
| vol2_section2.tex / vol2_section3.tex | Vol 2 sections |

### PDFs (compiled / distributed)
```
mini_beast.pdf, mini_beast_complete.pdf
mini_beast_ch2.pdf, mini_beast_ch3.pdf, mini_beast_ch6.pdf
Book3_VolIII_MiniBeast_eBook-combined copy-combined copy.pdf
Binder2.pdf
[UUID]-minibeast*.pdf (various compiled versions)
[UUID]-mini_beast_ch6.pdf
[UUID]-minibeast_gtct_chapter_E.pdf
```

### SVG
```
axle_sorry_roadmap.svg
axle_sorry_roadmap 2.svg
```

### Python
```
bridges.py
collatz_c9_2_fourier_v2.py
collatz_c9_2_sampling_option1.py
```

### Manifests / READMEs
```
FILES_MANIFEST.txt   (updated 2 hours ago)
README-CHAPTERS.txt  (updated 2 hours ago)
README.md            (initial commit)
README 2.md
```

### Ops folder
```
grossi-ops/          (updated 3 minutes ago — same time as ch13 upload)
```

---

## Files to Upload to TOTOGT/DM3-lab (primary target)

Local files ready — upload these 7 (pass code audit ✓):
```
ch5-immune.html       ← nav fixed: ch6-resonant, Sportal.html
ch9-phi.html          ← nav fixed: ch8-axiomatic, Sportal.html
ch10-lyapunov.html    ← nav fixed: Sportal.html
ch11-spectral.html    ← nav fixed: Sportal.html
ch12-conclusion.html  ← nav fixed: Sportal.html
ch13-revision.html    ← nav fixed: Sportal.html
```

Already in DM3-lab (confirmed from repo listing):
```
✓ ch-e-gtct.html
✓ chapters-pi-phi-mu-eta-delta-sigma-omega.html
✓ course-16weeks.html
✓ chapters-diagram.html
✓ trilogy-sale.html
✓ Sportal.html
✓ impa-portal.html
✓ sample-chapter-tubulin.html
✓ sample-chapter-wigner.html
✓ sim-lyapunov.html
✓ spectral-radius.html / spectral-radius-v2.html
✓ wigner-fractal.html
✓ access-required.html
```

Still need to confirm in DM3-lab (were in g6-LLC/B3):
```
? ch00-introduction.html
? ch1-seed.html
? ch2-allostatic.html
? ch3-circadian.html
? ch4-neural.html
? ch6-resonant.html
? ch7-crystalline.html
? ch8-axiomatic.html
```

---

## Code Audit — All 7 Local Chapters PASS ✓

| Check | Result |
|-------|--------|
| External CDN deps | None — fully self-contained |
| Canvas element IDs | All getElementById() match actual id= attributes |
| JS brace balance | All 7 files balanced |
| Clipboard API | ✓ works on HTTPS (GitHub Pages) |
| requestAnimationFrame | ✓ standard, all browsers |
| localStorage / fetch | Not used — no CORS issues |
| Sportal.html case | ✓ Fixed in all 7 chapters (sed replace) |
| ch6 nav link | ✓ Fixed ch6-falsifiable → ch6-resonant |
| ch8 nav link | ✓ Fixed ch8-pi → ch8-axiomatic |

---

## course-16weeks.html — Study Links (all need href added)

| Week | Correct filename | Fix |
|------|-----------------|-----|
| 1–2 | ch1-seed.html | add href |
| 3 | ch3-circadian.html | ✓ live — add href to span |
| 4 | ch2-allostatic.html | add href |
| 5 | ch4-neural.html | ✓ live — add href to span |
| 6 | ch5-immune.html | add href |
| 7–8 | ch6-resonant.html | add href |
| 9 | ch7-crystalline.html | add href |
| 10 | ch8-axiomatic.html | add href |
| 11 | ch9-phi.html | add href |
| 13 | ch10-lyapunov.html | add href |
| 14 | ch11-spectral.html | add href |
| 15 | ch12-conclusion.html | add href |
| 16 | ch13-revision.html | add href |

**Edit method**: GitHub editor on totogt/book3-starter → Ctrl+H  
Find: `<span class="tag tag-study">Study</span>` near the week's Prompt ID  
Replace: `<a href="chN-name.html" class="tag tag-study">Study</a>`

---

## Paywall Architecture

| Layer | URL | Notes |
|-------|-----|-------|
| Portal | totogt.github.io/AXLE/impa-portal.html | Sent to paying students |
| Chapters | totogt.github.io/book3-starter/chN-*.html | Public URL, not indexed |
| Payment | PayPal + Zelle +1 646-342-3751 | 24hr verification turnaround |
| Pricing | $247 hardcover · $199.99 ebook | — |

---

## Remaining Work (Chapters 14–17)

| Ch | Suggested Theme | Operator | Notes |
|----|----------------|----------|-------|
| 14 | AXLE / Lean 4 intro | U/G | Ties to Main.lean in B3 |
| 15 | Information Theory / Shannon | C | Entropy, compression circle |
| 16 | Renormalisation / Scale | G | Self-similar argument structure |
| 17 | Epilogue / Living Book | G | Book 3 as its own fixed point |

---

## Design System Reference

```
Fonts:     Georgia (body) · Courier New (code/labels/nav)
Gold:      #c9a84c
Nav:       impa-portal.html · chapters-diagram.html · course-16weeks.html · sportal.html · trilogy-sale.html
Footer:    "Chapter N of 17 · Book 3: The Mini-Beast · G = U ∘ F ∘ K ∘ C · © G6 LLC"
Canvas:    requestAnimationFrame · dark bg #07050f or per-operator variant
Prompts:   3 cards per chapter (Prompt X.Y · Prompt X+1.Z · Extension)
Ch nav:    ← chN-prev.html | chN+1-next.html →
```

| Operator | Color | Background |
|----------|-------|-----------|
| C | #4a9eff | #080d14 → #0d1520 |
| K | #e05a3a | #100800 → #1a0e06 |
| F | #50c878 | #0a0f0d → #0d1810 |
| U | #c084fc | #0c0a12 → #130f1e |
| G | #f59e0b | #120d00 → #1c1400 |
| Nirvana | #67e8f9 | #000c10 → #001c26 |
