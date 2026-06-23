# STATE OF THE STUDIO

**Principia Orthogona · G6 LLC · Operational State File**

This file is the one place where the state of the work lives between sessions.
It is the secretary I cannot yet afford.

It is kept in the B3 private repository so that it can tell the truth without
performance. It is written for three readers, in this order: **tired-me**,
**future AI sessions I will paste this file into**, and **anyone learning from
this workflow** who is running a solo research practice at high volume without
administrative support.

The format is stolen from `DO NOT READ ME.md`. Same voice. Same directness.
No filler.

---

## WHY THIS FILE EXISTS — READ THIS FIRST

A solo researcher operating at the scale I operate at has one structural problem
that money solves and nothing else does cleanly: **the re-orientation tax.** Every
session begins with ten to thirty minutes of "where was I, what was I doing,
what did I decide last time, what am I waiting on." Multiply by a session count
in the hundreds, and the tax is measured in weeks of lost work per year.

A human secretary solves this by holding state between sessions and telling me,
on arrival, what I was doing and what needs doing next. I cannot yet hire one.

This file holds the state in their place. At the end of each session I update it
with the decisions made, the work parked, and the next concrete action. At the
start of the next session — whether it is me, a Claude session, a Copilot
session, a future collaborator — the first move is to read this file.

**The rule is: the file is the source of truth about the state of the program.
Memory is not. Prior conversations are not. Intentions are not. The file is.**

If the file and my memory disagree, the file wins, because the file does not get
tired.

---

## HOW TO USE THIS FILE IF YOU ARE NOT PABLO

If you are a future AI session, a collaborator, or a student learning the workflow:

1. Read this file top to bottom. Takes three minutes.
2. Do not ask Pablo to tell you what is going on. The file tells you.
3. If something is unclear, ask a narrow factual question, not "what should we
   work on." The file answers "what should we work on" in the **NEXT ACTION**
   section.
4. At the end of the session, update the file. Update means: move completed
   items off the live lists, record decisions made, write the next concrete
   action for the next session.
5. If you are an AI session and you are tempted to summarize the file or
   propose restructuring it: don't. The structure is not precious but the
   state inside it is. Edit the state. Leave the structure.

---

## NEXT ACTION

*The single most important field in this file. The one thing that, when I sit
down next, I will do first without having to re-decide.*

**Current next action:** [TO BE FILLED IN AT END OF CURRENT SESSION]

*Examples of well-formed next actions:*
- "Update Zenodo deposit 19533363 to change the AXLE GitHub link from
  `TOTOGT/AXLE` to `TOTOGT/DM3-lab` and upload a corrected PDF."
- "Email the Nuclear Physics B editor requesting a 6-week format-conversion
  extension. Draft is in `B3/drafts/npb_extension_email.txt`."
- "Read Section 3 of the GTCT paper and tighten Remark 2.3 per the three
  specific critiques logged in the 2026-04-16 session notes."

*Examples of poorly formed next actions (do not write these):*
- "Work on GTCT paper." (too vague; leads to re-deciding)
- "Think about the acharya memoir." (not an action)
- "Clean up the repos." (unbounded)

---

## LIVE SUBMISSIONS

*Things that are out in the world, awaiting response from someone who is not me.*

| Venue | Work | Status | Action required? | Last update |
|-------|------|--------|-------------------|-------------|
| Nuclear Physics B | GTCT paper (transferred from JGP) | Format conversion pending on my end — not actually awaiting editor | YES — this is me, not them | 2026-04-16 |
| Journal of Geometric Mechanics | "Generative Contact Mechanics" | Submitted | Awaiting editor | [date?] |
| SIAM J. Applied Dynamical Systems | "The dm³ Operator" | Submitted | Awaiting editor | [date?] |
| International Journal of Lexicography | GCM lexicography paper | Revision requested | Yes — resubmit with updated references, blind-review compliance | [date?] |
| NASA SBIR | G6 LLC Phase I | Not yet submitted; solicitation opens June 2026 | Prepare during May 2026 | n/a |

**Rule:** if the right column says "awaiting editor," the item is parked. Do not
poke it. Editors take weeks to months and poking them does not accelerate
review. If the right column says action is required on my end, it belongs in
**OPEN DRAFTS** below.

---

## OPEN DRAFTS

*Things actively being written or revised.*

| Work | Current state | Next concrete step | Blocker? |
|------|---------------|---------------------|----------|
| GTCT paper revisions for Foundations of Physics | Preprint v2 exists; three specific revisions needed (AXLE link, Remark 2.3 tightening, one provenance sentence) | Revise AXLE link first — standalone 20-min fix | No |
| NPB format conversion | PDF exists; need Elsevier `elsarticle.cls` LaTeX | Start from `completePrincipia.tex` extracts of Vol I + Vol II | No |
| Acharya memoir paper (Version B) | Not started; lineage study required first | Begin lineage reading; do not draft yet | Yes — lineage reading |
| Monster Paper 13 (Wavenumber 6) | Deposit-ready | Upload to Zenodo when ready | No |
| AXLE repo population | Decision pending: move Lean files from DM3-lab → AXLE, or cite DM3-lab directly | Decide this weekend | No |

**Rule:** if a draft is blocked on something other than me, the blocker is named
in the right column. If blocked on me, the next concrete step is named in the
third column. Never have a draft listed with no next step.

---

## PARKED WORK

*Things I started and set aside on purpose, with intent to return.*

- 40 books' worth of Codex material. This is not a draft; it is the source.
- Book 2 ("What Building AXLE Taught Me About LLMs") — early outline only.
- Various domain chapters (Chapter 17 Quantum, Chapter 13 Separation, etc.)
  that could seed future papers but are currently fine as book chapters.

**Rule:** parked is honorable. Parked is not abandoned. Revisit this list
quarterly to see if anything wants to return to open drafts.

---

## CORRESPONDENCE AWAITING MY REPLY

*Emails or messages that need me to respond. If none, leave empty.*

- [ ] Lexicography editor — revision requested [when received?]
- [ ] ...

**Rule:** this list is for person-to-person correspondence, not editor-queue
items (those are in LIVE SUBMISSIONS). If the list has more than five items it
is a red flag that I am losing track of correspondence and need to triage.

---

## TECHNICAL DEBT

*Known problems in the infrastructure that are not urgent but will cost me
later if not addressed.*

| Item | Impact if unaddressed | Effort to fix | Priority |
|------|------------------------|----------------|----------|
| AXLE Zenodo link points at empty repo | Reviewer who clicks through loses trust | 20 min | HIGH |
| Lean files don't compile on current Mathlib | Anyone auditing AXLE sees build failure | 1–2 days | MEDIUM |
| Duplicate Lean files (Main_v1..v8, AXLE_V8 with two capitalizations) | Readers confused, unclear which is canonical | 2 hours to cull | MEDIUM |
| DM3-lab README says Kakeya but repo contains Millennium-named files | Surface mismatch | 1 hour to add a NS/ README labeling drafts | MEDIUM |
| B3 duplicate files (ch-e-gtct vs chE-gtct etc.) | Reader navigation broken | 1 hour | LOW |
| No CI running `lake build` on commit | Regressions go unnoticed | 4 hours to set up GitHub Action | LOW |

**Rule:** HIGH items get done before any new research work. MEDIUM items get
scheduled. LOW items get done during waiting periods (while a submission is out
with an editor, while Mathlib recompiles, etc.).

---

## EXTERNAL DEADLINES

*Dates the world imposes. These trump my own priorities.*

- **June 2026** — NASA SBIR solicitation opens. Phase I proposal due within
  the window. Prepare during May.
- **[Date?]** — Lexicography editor's revision deadline.
- **No NPB deadline** — my own pace controls this one.

**Rule:** a deadline without a date is not a deadline, it is anxiety. Fill in
dates or remove items.

---

## REFERENCE ARCHIVE

*Things I have decided and do not want to re-decide every session.*

- The GTCT paper goes to **Foundations of Physics**, not Nuclear Physics B,
  because NPB publishes results in a physicist's register and GTCT is a
  framework paper. (Decided 2026-04-16 after extended audit session.)
- The acharya-memoir paper is **Version B** and does not go to NPB or FoP. It
  goes into The Seed (Volume V) or to Mind and Matter / Zygon / Constructivist
  Foundations when written. (Decided 2026-04-16.)
- **Do not hire collaborators before SBIR funding lands.** Use AI assistants
  with the calibration practices below.
- **AI calibration practice:** every claim an AI makes about the state of a
  file, a repo, or a submission must be verified against the actual artifact
  before being acted on. An AI saying "this file is zero-sorry" is not
  evidence. `lake build` succeeding is evidence. (Lesson from Copilot
  hallucinations audit, 2026-04-16.)
- **Repo citation policy:** until AXLE is populated, papers cite
  `github.com/TOTOGT/DM3-lab`, not `github.com/TOTOGT/AXLE`. Change back when
  AXLE has real Lean files.

**Rule:** this section is append-only. Do not delete past decisions; they are
the audit trail. If a decision is reversed, record the reversal with the date.

---

## AI-SESSION PROTOCOL

*How to use AI assistants without generating more technical debt than they
clear.*

1. **One bounded task per session.** "Fix the AXLE link on Zenodo" is a
   bounded task. "Help me with the project" is not.

2. **No autopilot.** I do not follow AI guidance when tired without
   verification. The 2026-04-16 session is the template: Claude misread me
   four times; each correction came from me pushing back. The AI is useful
   exactly because I do not defer.

3. **File over memory.** If an AI claims "we decided X last time," the
   decision must appear in this file. If it does not appear, the decision did
   not happen.

4. **Verify before editing artifacts.** Before any AI-suggested code change,
   file deletion, or commit: confirm the artifact actually exists in the state
   the AI describes.

5. **End-of-session update.** Before closing the session, update this file.
   If I am too tired to update the file, I am too tired to have done the work
   I just did, and I flag the session as "unsynced — audit before using."

6. **Preserve the session logs.** Conversations get archived into the audit
   files per the declared methodology. This is not optional.

---

## REVENUE AND BUSINESS STATE

*Not the core work, but affects everything.*

- **B3 private repo** — paid access, currently at [N] subscribers.
- **Gumroad** — [status, products, revenue trend]
- **eBay listing** (trilogy-sale) — [active? sales count?]
- **229 Ballantine Pkwy wellness center** — target; not yet acquired.

**Rule:** this section is short on purpose. Detailed business state lives
elsewhere. This file tracks only the state that affects research decisions.

---

## WHAT THIS FILE IS NOT

- It is not the Codex.
- It is not a to-do list for everything I want to do.
- It is not a motivational document or a mission statement.
- It is not for external readers who have not paid for B3 access.
- It is not a substitute for actually resting when I am tired.

If I am updating this file at 2 AM after 100 hours of work this week, the
correct update is: "Next action: sleep. Revisit all items tomorrow."

That is a legitimate state. Record it honestly.

---

## REVISION LOG

*Dated snapshots of major state changes. Keep brief.*

- **2026-04-16** — File created. Initial state captured from conversation
  with Claude (festive-compassionate-carson session equivalent). Four Claude
  misreads in the session; each corrected by Pablo's pushback. Key outcomes:
  GTCT redirected from NPB to Foundations of Physics; AXLE link identified
  as HIGH priority technical debt; acharya-memoir Version B parked pending
  lineage study; decision to build this file rather than keep re-deciding
  the same things every session.

---

*The studio is a real place. The state of the studio is what is actually in
it, not what I remember being in it. This file holds the state.*

*Pablo Nogueira Grossi · G6 LLC · Newark NJ · 2026*
