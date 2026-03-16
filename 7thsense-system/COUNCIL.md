# 7thsense Strategic Council — Revised Structure
*Updated: March 16, 2026*
*Doctrine: We sell outcomes, not websites.*

---

## Positioning Statement

**"We find where service businesses are losing leads — and fix it before they lose another one."**

---

## Council Roles (7 active roles, streamlined from 9)

### 1. Opportunity Scanner
**What they do:** Find businesses in a specific niche + city that have the problem signal (good reviews, bad website, or running ads with weak landing pages).
**Skills needed:** 7thsense-opportunity-scanner, web search, Firecrawl
**Output:** Ranked target list with scores, contact details, and key signals
**Existing agent:** Scout Agent in MASTER_BRIEF (upgrade to this)

### 2. Problem Diagnoser
**What they do:** For each hot target, articulate the specific problem in business terms — not "your site is ugly" but "you're losing X leads per month because Y."
**Skills needed:** 7thsense-roi-calculator, Firecrawl (scrape their site), web search
**Output:** Problem brief per target: what's broken, what it costs, what fixing it is worth
**Existing agent:** Research Agent in MASTER_BRIEF (upgrade to this)

### 3. Demo Builder
**What they do:** Build the demo site using the locked components system, niche intelligence, real data.
**Skills needed:** All 7thsense build skills, locked-components, niche skills, image-agent, copy-architect, visual-system
**Output:** Live demo URL on Vercel with all images, reviews, data verified
**Existing agent:** Demo Builder Agent in MASTER_BRIEF (already operational)

### 4. Pitch Architect
**What they do:** Combine the problem brief + demo URL + ROI argument into a personalised outreach message.
**Skills needed:** 7thsense-offer-architect, 7thsense-roi-calculator, cold-email, copywriting
**Output:** Ready-to-send WhatsApp message + email + screenshot, personalised per prospect
**Existing agent:** Outreach Agent in MASTER_BRIEF (upgrade to this)

### 5. Closer
**What they do:** Handle follow-ups, objections, pricing conversations. Draft responses for Max to send.
**Skills needed:** sales-enablement, negotiation, influence-psychology, marketing-psychology
**Output:** Follow-up messages, objection responses, call preparation briefs
**Existing agent:** Closer Agent in MASTER_BRIEF (already defined)

### 6. Delivery Manager
**What they do:** After sale — refine demo, connect domain, set up forms/automation, go live.
**Skills needed:** All build skills + Make.com knowledge + DNS/domain setup
**Output:** Live production site on client's domain
**Existing agent:** Delivery Agent in MASTER_BRIEF (already defined)

### 7. Strategic Integrator
**What they do:** Weekly review — what's working, what's not, where to focus next. Prioritises across all roles.
**Skills needed:** All council awareness, pipeline tracking, honest assessment
**Output:** Weekly brief: pipeline status, wins, losses, next moves
**Existing agent:** Summary Agent in MASTER_BRIEF (upgrade to this)

---

## Dropped Roles (from original 9-role proposal)
- **Market Researcher** — merged into Opportunity Scanner (research happens during scanning)
- **Viability Checker** — merged into Problem Diagnoser (viability = is the problem big enough?)
- **Fulfillment Architect** — merged into Delivery Manager (same function)

---

## Pipeline Flow
```
Scanner → Diagnoser → Builder → Pitch Architect → [MAX APPROVES] → Send
                                                                      ↓
                                              Closer ← Response ← Prospect
                                                ↓
                                          [SALE CLOSES]
                                                ↓
                                        Delivery Manager → Live Site
                                                ↓
                                    Strategic Integrator ← Results
```

---

## Two Approval Gates (unchanged)
1. **Before outreach sends** — Max reviews every message before it goes to a prospect
2. **Before demo goes live** — Max reviews every demo before a prospect sees it
