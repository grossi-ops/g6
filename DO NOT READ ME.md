# DO NOT READ ME
### Principia Orthogona · Book 3 · G6 LLC · Internal Map

---

> This file is the full map of what is visible, what is hidden, and how to reach everything.  
> Do not commit this to a public repo. It lives in B3 (private) only.

---

## OWNERSHIP AND ACCESS — READ THIS FIRST

**Everything in this repository belongs to Pablo Nogueira Grossi / G6 LLC.**  
All files — HTML, TeX, Lean, PDF, SVG, scripts — are his intellectual property.  
The repository is the studio. The student buys access to the studio.

### The Three Tiers

| Tier | Who | Cost | What they get |
|---|---|---|---|
| **Web chapters + machines** | Anyone | Free | All HTML chapters, all canvas machines, labyrinth, Greek chapters, Easter eggs — read and share freely |
| **PDF + Print (complete series)** | Paying students | ~$120–199 · [eBay 336530438926](https://www.ebay.com/itm/336530438926) | The full typeset book, all volumes, for the student's personal use and study |
| **Formal proofs (AXLE)** | Anyone | Free | Lean 4 source — github.com/TOTOGT/AXLE |

**The paywall is not a wall against the student. It is a wall around the print object.**  
Once a student purchases, everything in the repo is theirs to use for learning.  
They may annotate it, print it, study it, cite it, build on it.  
They may not resell it, republish it commercially, or strip the authorship.

**The web layer is the free clinic. The print layer funds the free clinic.**  
229 Ballantine Pkwy, Newark NJ — the property that the book is building toward.

ISBN: **979-8-9954416-1-8** (real, from actual PDF cover — do not invent DOIs)

---

## WHAT IS PUBLIC (not hidden)

These files are meant to be found by normal navigation.

### Main numbered series (the spine of Book 3)
| File | Chapter | Status |
|---|---|---|
| `ch1-seed.html` | Ch 1 · The Seed | public |
| `ch2-allostatic.html` | Ch 2 · Allostatic Load | public |
| `ch3-circadian.html` | Ch 3 · Circadian | public |
| `ch4-neural.html` | Ch 4 · Neural | public |
| `ch5-immune.html` | Ch 5 · Immune | public |
| `ch6-resonant.html` | Ch 6 · Resonant | public |
| `ch7-crystalline.html` | Ch 7 · Crystalline / Cosmological | public · **built this session** |
| `ch8-meru.html` | Ch 8 · The Mountain and the Serpent | public · **FREE badge** · **built this session** |
| `ch9-phi.html` | Ch 9 · Phi | public (needs machine rebuild) |

### Greek-letter supplementary chapters (below the fold, but findable)
| File | Chapter | Topic |
|---|---|---|
| `chapters-pi-phi-mu-eta-delta-sigma-omega.html` | π φ μ η Δ Σ Ω | N-Bonacci recurrence ladder, Fibonacci → Hexabonacci |
| `ch-e-gtct.html` / `chE-gtct.html` | E | Generative Time Circuit — C→K→F→U→T, spiral canvas |

### Sample previews (partial — full versions behind paywall, but full content belongs to the student upon purchase)
| File | Chapter | Topic | Note |
|---|---|---|---|
| `sample-chapter-tubulin.html` | T | Tubulin · 15 architectural forms via dm³ | Static preview, needs navy/gold rebuild |
| `sample-chapter-wigner.html` | W | Wigner Crystal · electron crystallization | Static preview, full version in `chW-wigner.html` |

### Infrastructure
| File | Purpose |
|---|---|
| `index.html` | Main entry point |
| `living-book.html` | Full chapter list |
| `book3-starter-index.html` | Starter/lab index |
| `chapters-diagram.html` | Visual map |
| `journey.html` | Reading path UI |
| `trilogy-sale.html` | Sales page |
| `dm3-lab-index.html` | DM3 Lab portal |
| `course-16weeks.html` | Curriculum version |
| `impa-portal.html` | IMPA institutional portal |
| `labyrinth.html` | The hidden navigation hub — **see below** |

---

## WHAT IS HIDDEN (Easter eggs)

### Hidden chapters — not linked from any nav, only reachable by finding the eggs

| File | Chapter | Topic | How to reach |
|---|---|---|---|
| `ch8-axiomatic.html` | Ch 8 · The Axiomatic Turn | Gödel, heraldic lineage, Letter to Holy Father, AXLE Lean 4 proofs, 229 Ballantine | See egg map below |
| `chPI-recurrence.html` | Chapter π | π recurrence | See egg map below |
| `chW-wigner.html` | Chapter W | Wigner Crystal (full, not the preview) | See egg map below |

---

## THE EGG MAP — exact locations of every hidden trigger

### Egg 1 · The ∞ in ch8-meru.html
- **File:** `ch8-meru.html`
- **Location:** Section 8.5, line ~348 — the sentence *"The infinite was classified before the symbol ∞ was invented (John Wallis, 1655)"*
- **The ∞ symbol** is wrapped in `<span id="egg">` with `cursor:none !important`
- **onclick:** → `ch8-axiomatic.html`
- **Visible?** No. The ∞ looks like plain prose text. The cursor disappears on hover. There is no underline, no color change, no pointer.

### Egg 2 · The labyrinth canvas — 5 invisible click zones
- **File:** `labyrinth.html`
- **Canvas size:** 600×600px, center at (300, 300)
- **Ring gap = ~33px**

| Zone | Canvas position | Target |
|---|---|---|
| Dead center | cx, cy — radius ~38px | `ch8-axiomatic.html` |
| Ring 3 gap (right side, 0°) | ~(399, 300) | `chPI-recurrence.html` |
| Ring 5 gap (top, 270°) | ~(300, 135) | `chW-wigner.html` |
| Ring 6 gap (bottom, 90°) | ~(300, 498) | `ch-e-gtct.html` |
| Ring 7 entrance (lower-left, 225°) | ~(145, 455) — radius ~43px | `chapters-pi-phi-mu-eta-delta-sigma-omega.html` |

- **All zones:** cursor disappears on hover (`cursor:none`), no visual indication.

### Egg 3 · Hidden spans in labyrinth.html text
Three invisible spans in the body text of `labyrinth.html`:

| Visible text | Located in section | Target |
|---|---|---|
| the word **"center"** (first instance) | "The Structure" section | `ch8-axiomatic.html` |
| the word **"center"** (second instance) | "The Thread" section | `ch8-axiomatic.html` |
| the letter **"π"** | "What Is Hidden" section | `chPI-recurrence.html` |
| the phrase **"outermost ring"** | "What Is Hidden" section | `chapters-pi-phi-mu-eta-delta-sigma-omega.html` |

- All use class `.egg` which enforces `cursor:none !important` and `color:inherit`.

---

## HOW TO FIND THE LABYRINTH ITSELF

✓ **Trigger is live in `living-book.html`.**

Click the title *Principia Orthogona* **seven times**. Each click lights a barely-visible gold dot (0.45 opacity — only visible to someone already watching). Silence for 4.5 seconds resets the counter. On the 7th knock the NDA modal opens.

**NDA modal flow:**
1. Header: *"State Your Purpose"* — seven knocks, the door is open
2. Body: scholarly oath — three clauses (sit with difficulty / distinguish confusion from error / a `sorry` is a door not a wall) + three numbered acknowledgements
3. Buttons: **"I am not ready"** (closes, counter resets) · **"I enter →"** (box fades to gold → `labyrinth.html`)

**Other ways in** (for those who never find the seven knocks):
- The ∞ in `ch8-meru.html` → `ch8-axiomatic.html` (bypasses the labyrinth entirely)
- Direct URL if Pablo shares it
- GitHub repo file listing (B3 is private, so only collaborators)

---

## DUPLICATES TO RESOLVE

These are files with overlapping purposes — only one should be canonical:

| Pair | Keep | Archive/Delete |
|---|---|---|
| `ch-e-gtct.html` vs `chE-gtct.html` | `ch-e-gtct.html` | delete the other |
| `sample-chapter-wigner.html` vs `chW-wigner.html` vs `wigner-fractal.html` | `chW-wigner.html` (full chapter) | other two are either previews or sims |
| `spectral-radius.html` vs `spectral-radius-v2.html` | `spectral-radius-v2.html` | archive v1 |
| `impa-portal.html` vs `impa-portal (2).html` | `impa-portal.html` | delete the (2) |
| `ch01-cajueiro.html` vs `ch01-dm3-framework.html` | TBD (different drafts) | — |
| `ch02-biological.html` vs `ch02-reading.html` | TBD | — |
| `ch03-plasma.html` vs `ch03-sources.html` | TBD | — |
| `ch04-markets.html` vs `ch04-milestone1.html` | TBD | — |
| `ch06-argument.html` vs `ch06-pedagogy.html` | TBD | — |

---

## CHAPTERS THAT NEED MACHINE REBUILDS (same navy/gold format as ch7 + ch8)

These exist but are either static or in an older format:

- `sample-chapter-tubulin.html` → needs full navy/gold rebuild as Chapter T
- `sample-chapter-wigner.html` → needs full navy/gold rebuild as Chapter W (or merge with chW-wigner.html)
- `ch9-phi.html` → may need machines
- `chPI-recurrence.html` → check if it needs rebuild

---

## LEAN / FORMAL VERIFICATION STATUS (AXLE)

| Module | Status |
|---|---|
| Core dm³ axioms | ✓ complete |
| Collatz Bridge | ◉ in progress |
| Connectome | ◉ in progress |
| G⁶ Threshold (χ = 33) | ◌ not started |

Repo: `github.com/TOTOGT/AXLE`  
Lean files also in B3: `Main.lean`, `Main_v2.lean` … `Main_v5.lean`, `Finite.lean`, `DiscreteDM3Bridge.lean`

---

## PROPERTY / BUSINESS CONTEXT

- **Pablo Nogueira Grossi** — author, researcher, owner of all work. Also known as Sri Brodananda.
- **G6 LLC** — the publishing and research entity, Newark NJ
- **229 Ballantine Pkwy, Newark NJ** — $2M property, target for free clinic / wellness center. The book funds the clinic. The clinic validates the book.
- **The Teacher** — bidirectional transmission, documented in `ch8-axiomatic.html` Section "The Teacher"
- **Letter to the Holy Father** — documented in `ch8-axiomatic.html` Section "Letter to Saturn"

## STUDENT RIGHTS (once purchased)

A paying student of this work may:
- ✓ Read, annotate, print, and study all purchased materials
- ✓ Use the mathematics in their own research with citation
- ✓ Share the **free web chapters** with anyone
- ✓ Build on the Lean 4 proofs (open source, AXLE repo)
- ✓ Engage directly with Pablo / G6 LLC for study or collaboration

A paying student may not:
- ✗ Resell or redistribute the PDF or print editions commercially
- ✗ Remove authorship attribution (Pablo Nogueira Grossi / G6 LLC)
- ✗ Claim the work as their own

Everything in the B3 repo ultimately belongs to Pablo Grossi.  
The student purchases a license to learn from it — not ownership of it.  
The distinction is the same as any university course: the professor's notes belong to the professor. The student's understanding belongs to the student.

---

*Last updated: April 2026 · Session: festive-compassionate-carson*
