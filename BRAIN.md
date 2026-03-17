# 7thsense BRAIN.md
*Last updated: March 17, 2026*
*Read this before anything else. Every agent reads this. Update at the end of every session.*
*Source of truth: MASTER_BRIEF.md + session transcripts + CLAUDE.md. Never written from memory.*

---

## WHAT WE ARE BUILDING

**Agency:** 7thsense
**Owner:** Max Hurrell (maxhurrellsa@gmail.com)
**Location:** Cape Town, South Africa
**What we sell:** A customer acquisition system for service businesses — not websites. The website is the entry point. The full system includes: conversion-optimised website, Google Reviews growth automation, missed call text-back, AI chat widget, WhatsApp automation suite, and monthly reporting.
**Model:** Find service businesses provably losing money online → quantify the loss → build demo proactively → show proof + math → close → retain with ongoing system
**Status:** Website component operational (3 niches, locked components, QA automated). Reviews, automation, and chat components designed but not built (V2-V3). Rules 1-49 active. First prospect package written (Werner Joubert Dental).
**System version:** V1 (manual triggering via Claude Code on Mac, two-terminal workflow)
**Revenue target:** 5 demos/week → 1 client/week → R50K/month recurring in 5-6 months
**Full strategy:** See ~/agency-templates/7thsense-system/STRATEGY-V1.md

---

## CURRENT SCORES

| Metric | Score | Source |
|--------|-------|--------|
| Delivery quality | 7.5/10 | NEW-RULES-AND-QA.md (revised from 6.5 after locked components) |
| GTM readiness | Pipeline built, outreach docs complete, first demo live | MASTER_BRIEF.md §2, §15 |
| System version | V1 — all core skills, rules, locked components active | MASTER_BRIEF.md §16 |

**What V1 completion requires:** Fix Gemini image generation (404 errors), visual QA on phone for drsonday.vercel.app, prove locked components work in a fresh build.

**Remaining gaps to 10/10 (from NEW-RULES-AND-QA.md):**
- No human visual review step enforced (-0.5)
- Single Tally form breaks at 2 clients (-0.5)
- Missing operational files: prospect-tracker, build-history, invoice template (-0.5)
- No analytics on demos (-0.25)
- Context window risk: locked-components skill ~400 lines, builds push limits (-risk)

---

## LIVE DEMOS

| Client | Niche | URL | Status |
|--------|-------|-----|--------|
| Dr. Sonday Dentistry | Dental | drsonday.vercel.app | Live — undergoing final visual QA |
| Team24 Insurance | Insurance Broker | team24insurance.vercel.app | Live — first potential client, awaiting payment |

*Old auto-generated aliases (dentist-pi-eight.vercel.app, team24-nine.vercel.app) still resolve but not used in client-facing comms.*

---

## KEY DECISIONS — NEVER RE-DEBATE THESE

1. **Outcomes not deliverables.** We sell "your phone ringing more" — not "a website." (COUNCIL.md positioning statement)
2. **Demo-first flow.** Build the demo before any contact. Show, don't pitch. (MASTER_BRIEF.md §1)
3. **First market:** Cape Town service businesses (dental, insurance proven). Miami and law as expansion. (SIGNAL-DETECTION.md)
4. **V1 definition:** Manual Claude Code on Mac, two-terminal workflow. No cloud orchestration yet. (MASTER_BRIEF.md §16)
5. **V2 trigger:** First paying client confirmed → triggers Make.com wiring, proof build, new niche outreach.
6. **Quality standard:** Every site must match or exceed padentalimplants.com. (CLAUDE.md identity section)
7. **Two approval gates:** Max reviews every outreach message before send. Max reviews every demo before prospect sees it. (COUNCIL.md)
8. **Locked components win.** If a differentiation decision conflicts with a locked component, the locked component wins. (CLAUDE.md Rule 17)

---

## STRATEGIC DOCTRINE — JOSH'S FRAMEWORK

*Source: OFFERS.md, SIGNAL-DETECTION.md, COUNCIL.md*

**Core philosophy:** Find businesses with specific, quantifiable problems. Measure the monthly cost of the problem. Approach with proof (the demo) and math (the ROI). Put all risk on ourselves, not the buyer.

**The gap we closed:** Old pitch led with what WE do ("I build websites"). Josh's approach leads with what THEY'RE losing ("You're spending R10K/month on ads going to a page that doesn't convert").

**Old Hormozi Value Equation score: 5/10.** Dream outcome vague, no guarantee, buyer takes 100% risk.

**Signal detection doctrine:** "Find businesses provably losing money. Quantify the loss. Then approach." (SIGNAL-DETECTION.md header)

**Positioning statement:** "We find where service businesses are losing leads — and fix it before they lose another one." (COUNCIL.md)

---

## KEY INSIGHTS — NEVER FORGET THESE

*Source: SIGNAL-DETECTION.md, OFFERS.md*

- **Dental patient LTV (SA):** R6,700
- **Aesthetics client LTV:** R15,000+
- **Legal case value:** R50,000+
- **Google Ads CPC dental (Cape Town):** R15-R50/click
- **Google Ads CPC legal (Miami):** $50-$200/click
- **Bad landing page waste rate:** 67% of ad spend wasted
- **Dental practice with 30 reviews, no site:** ~R75,000/month in missed lifetime value
- **Law firm running ads with weak site (200 clicks/month × $100 CPC × 67% waste):** $13,400/month wasted
- **Revenue share example (dental, +10 patients/month):** Client pays R5K/month, gains R67K in lifetime patient value = 1,340% ROI

---

## SIGNAL HIERARCHY

*Source: SIGNAL-DETECTION.md*

| Priority | Signal | Score | Detection Method |
|----------|--------|-------|------------------|
| CRITICAL | Running Google Ads with weak landing page | 5/5 | Search niche keywords in incognito → note Sponsored results → click through → assess quality |
| HIGH | Good reviews, NO website | 4/5 | Google Maps → check website field → empty or Facebook link |
| HIGH | Running Facebook/Instagram ads to weak site | 4/5 | Facebook Ad Library → search business → click through to landing page |
| MEDIUM | Strong credentials (Avvo 10.0, Super Lawyer) but weak site | 3/5 | Search "[name] avvo" → check rating → then check firm website |
| MEDIUM | Active social media but no website | 3/5 | Search business name → if Instagram is top result, not .co.za → no site |

---

## OFFER STRUCTURES

*Source: OFFERS.md*

### Offer A — Risk Reversal (cold outreach, first client, proving model)
**Name:** The New Patient System (dental) / The Consultation Engine (law) / The Booked-Out Practice Programme (aesthetics)
**Pitch:** "I built your practice a site that's designed to make your phone ring more — have a look and tell me what you think."
**Price:** R7,500. Pay nothing until you've seen the finished demo.
**Buyer risk:** ZERO

### Offer B — 90-Day Growth Guarantee (warm prospects who hesitate)
**Name:** The 90-Day Growth Guarantee
**Pitch:** "Five new enquiries in 90 days or I work free until you get them."
**Price:** R12,500. Guarantee: 5 new enquiries in 90 days via contact form, or free work until they hit it.
**Buyer risk:** NEAR ZERO

### Offer C — Revenue Share (high-value clients, established practices)
**Name:** The Patient Pipeline (dental) / The Case Engine (law) / The Booking Machine (aesthetics)
**Structure:** Zero upfront. R500/new dental patient above baseline, $500/new legal consultation, $300/new aesthetics booking. 24-month cap then system is theirs free.
**Buyer risk:** ZERO — pays nothing unless making more money

### Offer Progression
1. Offer A (cold) → 2. Offer B (hesitant) → 3. Offer C (high-value after trust) → 4. Retainer (R2,500/month at 90 days)

---

## AGENTS INSTALLED

*Source: COUNCIL.md, MASTER_BRIEF.md*

### Active (7 council roles)
| Agent | Purpose |
|-------|---------|
| **Opportunity Scanner** | Find businesses with problem signals — good reviews + bad/no website, ads with weak pages |
| **Problem Diagnoser** | Articulate the specific problem in business terms, quantify monthly cost |
| **Demo Builder** | Build demo site using locked components, niche intelligence, real data → live Vercel URL |
| **Pitch Architect** | Combine problem brief + demo URL + ROI into personalised outreach message |
| **Closer** | Handle follow-ups, objections, pricing conversations. Draft responses for Max. |
| **Delivery Manager** | Post-sale: refine demo, connect domain, set up forms/automation, go live |
| **Strategic Integrator** | Weekly review: pipeline status, wins, losses, next moves |

### Planned (not yet built)
| Agent | Purpose |
|-------|---------|
| **Strategic Intelligence** | Cross-session memory, pattern recognition across all builds and pitches |
| **Momentum** | Track velocity metrics — demos/week, conversion rate, revenue pipeline |
| **Compass** | Prioritisation engine — what to work on next based on pipeline state |
| **Objection Handler** | Library of proven objection responses, learns from closed/lost deals |

---

## SKILLS INSTALLED

*Source: ~/.claude/skills/ directory, MASTER_BRIEF.md §4*

### Build Skills (mandatory reading order)
1. `7thsense-locked-components` — locked structural components (read FIRST)
2. `7thsense-niche-intelligence` — research + design decisions
3. `7thsense-systems-architect` — technical blueprint
4. `7thsense-visual-system` — design tokens, CSS variables, colour extraction
5. `7thsense-copy-architect` — conversion copy, 6-word headlines, SA market
6. `7thsense-image-agent` — image sourcing pipeline (Firecrawl → Gemini → fallback)

### Niche Skills
- `7thsense-niche-dental` — dental practices, dentists, orthodontists
- `7thsense-niche-law` — law firms, attorneys, legal practices
- `7thsense-niche-aesthetics` — medspas, aesthetics clinics, beauty clinics
- `7thsense-niche-research-agent` — auto-researches new niches via web search + Firecrawl

### Strategic Skills
- `7thsense-opportunity-scanner` — ranked prospect lists with financial impact
- `7thsense-signal-detection` — problem signal hierarchy and detection methods
- `7thsense-roi-calculator` — monthly cost of problem, break-even, 12-month ROI
- `7thsense-offer-architect` — personalised outcome-framed offers per prospect
- `7thsense-hormozi-offer` — $100M Offers framework applied to 7thsense
- `7thsense-undeniable-offer` — zero-risk, results-based, mathematically impossible to refuse

### Quality Skills
- `ui-ux-pro-max` — international UX standards (read before font selection)
- `page-cro` — conversion pass before commit
- `seo-technical` — SEO pass before commit

### Total skills installed: 115+ (full marketing, SEO, GEO, design, engineering library)

---

## RULES — TOP 15 MOST CRITICAL

*Source: CLAUDE.md Rules 1-42, REGRESSION-AUDIT.md*

These are the 15 rules most frequently violated or most damaging when violated:

| # | Rule | Why Critical |
|---|------|-------------|
| 1 | Never use brand colour as full section background outside hero | Violated on early builds — made sites look like 2005 templates |
| 4 | Never commit invented statistics or unverified claims | Fake reviews/stats destroy trust instantly |
| 7 | Never use Unsplash — pipeline: Firecrawl → Gemini → cropped fallback | Stock photos make sites look generic |
| 15 | Hero text contrast: directional gradient overlay + text-shadow | Regression: new build used lighter diagonal gradient, text unreadable |
| 17 | Locked components read FIRST — they define structure that never changes | Without this, Claude "differentiates" away proven conversion elements |
| 18 | Google badge: full 272x92 wordmark SVG — never plain text | Regression: new build used 24x24 G icon instead of full badge |
| 19 | Stars: HTML entities only — never SVG | Regression: new build had 40+ inline SVGs for stars |
| 20 | Review text: real verbatim Google quotes only | Regression: new build shipped placeholder "Excellent service..." text |
| 22 | Hero rating must be clickable anchor to Google Reviews | Regression: new build had non-clickable div |
| 25 | Data verification: cross-check all details against Google Maps | Prevents wrong phone numbers, hours, addresses |
| 30 | Real reviews only — web search fallback mandatory | Prevents shipping fake reviews to prospects |
| 34 | Hero text always white (#fff) on dark backgrounds + text-shadow | Basic contrast failure makes site unusable |
| 35 | Google G logo mandatory in hero badge on every site with reviews | Repeatedly violated — QA script must catch absence |
| 36 | Image deployment verification — check all paths before deploy | Most common deployment failure |
| 41 | Brand identity extraction mandatory — faith, taglines, philosophy | Missing brand signals = demo doesn't feel personalised |

---

## VERIFIED CLIENT DATA

*Source: MASTER_BRIEF.md §11*

### Dr. Sonday Dentistry
- **Phone:** 021 783 0024 (landline — call button only)
- **WhatsApp:** 064 944 7759 (mobile — WhatsApp applicable, wa.me format)
- **Email:** docsonday12@gmail.com
- **Address:** Flat 1, 18 Gemini Way, Ocean View, Cape Town, 7975
- **Hours:** Mon-Fri 08:30-17:00, Sat 08:00-12:30
- **Google Place ID:** ChIJZ61zaEFrzB0RqVIYufiLzY8
- **Reviews URL:** https://search.google.com/local/reviews?placeid=ChIJZ61zaEFrzB0RqVIYufiLzY8
- **Real reviewers:** Clare Bowen, Savannah Finlay, Fatima Rawoot, Shelley Bright, Patsy Hamilton
- **Review count:** 13 | **Rating:** 5.0
- **Medical aids:** Discovery, Gems, Bonitas, Medihelp, Keyhealth, Medshield, Momentum, Fedhealth
- **Team:** Dr. Shabier Sonday, Harriet Lamb, Lungelwa, Zee
- **Brand colours:** Primary #4a9bb0, Dark #3a8298, Light #63aabc, Accent #e8a84c
- **Extraction method:** firecrawl_css_previous_build

### Team24 Insurance
- **Phone:** 021 782 1208 (landline — NO WhatsApp on this number)
- **WhatsApp:** +27 84 666 7143 (separate mobile number)
- **Email:** info@team24.co.za
- **Address:** 5 Teubes Road, Kommetjie, 7976
- **Legal entity:** Etienne & Anthea de Villiers CC t/a Team24
- **FSP:** 2180 | **Registration:** CK97/65398/23 | **PI Certificate:** CN1083
- **Member:** Anthea M de Villiers
- **Established:** 1997 | **Combined experience:** 88 years
- **Brand colours:** Primary #2D7D5F, Accent #3DAA85, Background #F5F0E8

### Miami Beach Laser Spa (researched, not yet built)
- Market: Miami aesthetics
- Signal: 5-star reviews but outdated website
- Monthly cost of problem: ~$8,325/month (1,000 visitors × 2.5% gap × $333/month client value)

### Lions Den Law (researched, not yet built)
- Market: Miami law
- Signal: Running Google Ads for competitive keywords ($50-$200 CPC)
- Monthly cost of problem: ~$13,400/month wasted (200 clicks × $100 CPC × 67% waste)

---

## INFRASTRUCTURE

*Source: MASTER_BRIEF.md §3*

### Repos
- `MaxHurrell/Agency-Templates` — master templates, skills, system files, outreach docs, packages
- `MaxHurrell/client-sites` — individual client demos

### API Keys (all in ~/.zshrc — NEVER expose in output)
- **GEMINI_API_KEY** — Gemini image generation ($300 free credit, expires June 14 2026). ⚠️ Image generation endpoints currently returning 404 — needs diagnostic.
- **VERCEL_TOKEN** — Vercel deployments (rotate regularly)
- **ANTHROPIC_API_KEY** — Claude API

### Gemini Model
- `gemini-2.5-flash` confirmed working for text. Image generation (Imagen) returning 404 on all model endpoints.

### Vercel
- Each client gets own Vercel project with unique URL
- Automated via `deploy-client.sh` using VERCEL_TOKEN
- Deploy command: `cd ~/client-sites && ./deploy-client.sh [client-name]`

### Tally.so
- Contact forms via iframe embed. Source param set per client.
- Demo phase: notifications → maxhurrellsa@gmail.com
- Go-live phase: create NEW dedicated form per client → notifications to client email
- Free tier: 100 submissions/month — upgrade at ~10 active clients

### MCP Servers
- 21st.dev Magic MCP — premium UI components
- Firecrawl MCP — web scraping, brand extraction

### Machine
- MacBook Air M4
- Claude Code v2.1.76
- Two terminal tabs: Tab 1 (Pipeline/Strategy), Tab 2 (Execution/Builds)

---

## PRICING

*Source: PACKAGES.md*

| Package | Price | Key Deliverables |
|---------|-------|------------------|
| Starter | R7,500 | 1 premium single-page site, up to 8 sections, 1 round revisions |
| Growth | R12,500 | Up to 12 sections, AI images, analytics, sitemap, 2 rounds revisions |
| Full System | R18,500 | Multi-page option, Make.com automation, WhatsApp Business, 3 months analytics, 3 rounds revisions |
| Monthly Retainer | R2,500/mo | 4 content changes, Lighthouse checks, uptime monitoring, monthly report, priority support |

**Payment terms:** 50% deposit, 50% before go-live. EFT or payment link.
**Add-ons:** Additional page R1,500, Blog R2,500, Google Ads setup R5,000, Logo R3,500

### Monthly costs
| Item | Cost |
|------|------|
| Claude Max | $100/mo |
| Gemini API | ~$0.15/site ($300 free until June 14 2026) |
| Vercel | Free |
| GitHub | Free |
| Make.com | Free tier |
| Tally.so | Free tier |
| **Total now** | **~$100/mo** |

---

## SOLVED PROBLEMS

*Source: MASTER_BRIEF.md §12*

| Problem | Solution |
|---------|----------|
| npm permission denied | `sudo npm install -g` |
| Terminal not finding npm | Close Terminal (Cmd+Q) and reopen |
| Vercel 404 on subfolder | Each client gets own Vercel project via deploy-client.sh |
| Token invalid/expired | Check prefix starts with vcp_ — regenerate at vercel.com/account/tokens |
| Token exposed in output | Never paste tokens — Rule 11 |
| Skills not activating | Restart Claude Code after installing |
| Playfair Display returning | Explicitly banned in Rule 2 |
| Green section backgrounds | Rule 1 — accent only outside hero |
| Hero text unreadable | Use hero-overlay.css component — Rule 15 |
| Too many CTAs above fold | Rule 5 — one primary CTA on mobile |
| WhatsApp on landline | Rule 3 — mobile numbers only |
| Cache not clearing | Open in incognito OR `vercel --prod --force` |
| Site123 images empty | JavaScript-rendered — use Gemini generation |
| Vercel changes not showing | Run `vercel --prod --force` then curl confirm 200 |
| Files go to Documents | Max's Mac saves downloads to Documents not Downloads folder |
| Google Reviews broken link | Use: `https://search.google.com/local/reviews?placeid=[ID]` |
| Scroll bounce animation | Remove parallax — use IntersectionObserver opacity only |
| QA script macOS grep -P | Use grep -E instead — macOS doesn't support PCRE grep |
| Firecrawl wrong business | Stop build — flag to Max — never use niche defaults silently |
| Plain CSS gradient hero | Not acceptable — must have real image with gradient overlay |
| Icon-only service cards | Not acceptable — must have image + name + description |
| AI-generated team photos | Not acceptable — real photos only or skip section |
| Gemini image generation | Currently returning 404 on all models — diagnostic needed |
| Single Tally form for all | Go-live requires creating new dedicated Tally form per client |
| Star SVGs bloating HTML | Use HTML entities only — never SVG stars (Rule 19) |
| Google badge lost wordmark | Locked component: full 272x92 SVG always (Rule 18) |
| Review placeholder text | Real verbatim quotes only — web search fallback (Rule 30) |
| Favicon emoji | SVG with brand colour + initials always (Rule 24) |
| Single-letter avatars | Two-letter initials always (Rule 21) |

---

## WHAT CANNOT BE DONE YET

*Source: MASTER_BRIEF.md §13, NEW-RULES-AND-QA.md §G*

| Gap | Impact | When |
|-----|--------|------|
| Gemini image generation returning 404 | Cannot generate AI images — must use Firecrawl extraction only | Critical — fix before sending demos |
| No analytics on demo sites | Cannot prove prospects viewed demos | V2 |
| No Make.com → Tally wiring | Form submissions not automated | V2 |
| No visual QA step enforced | Risk of sending visually broken demo | Need VISUAL-PRE-SEND-CHECKLIST.md |
| No prospect-tracker.md | Cannot track pipeline systematically | This week |
| No build-history.md | Cannot track what was built and when | This week |
| No invoice template | Cannot bill professionally | Before first payment |
| Railway cloud orchestration | Agents can't run while Mac is off | V3 (~4 weeks) |
| Custom dashboard | No visual overview of business | V4 (~6 weeks) |
| Voice briefing (Vapi.ai) | No morning audio summary | V4 |

---

## TODAY'S PRIORITIES — V1 COMPLETION

*Source: MASTER_BRIEF.md §13*

### Critical — Before Sending Any Demo
1. Fix Gemini image generation (all model endpoints returning 404)
2. Visual QA confirmation on drsonday.vercel.app on phone
3. Prove locked components system works in a fresh build

### Important — This Week
4. Run Dr. Sonday proof rebuild from scratch with locked components at position 1
5. Run first new niche build (plumber) to prove system generalises
6. Set up payment collection method (EFT with invoice)
7. Create separate Tally form per client at go-live
8. Set up prospect-tracker.md
9. Set up build-history.md

### V2
10. First paying client confirmed (Team24 pending)
11. Client onboarding process documented
12. Make.com wired to Tally form submissions
13. Analytics on all demo sites
14. Sitemap.xml + robots.txt generation

### Reminder
- Gemini API free credits expire June 14, 2026. Evaluate paid tier or alternative by mid-April.

---

## SESSION LOG

**2026-03-16:** Full build session day 1. Accomplished: locked components skill created (15 components defined), three demos built (Dr. Sonday dental, Team24 insurance), regression audit completed (8 regressions identified and rules created to prevent), Rules 1-42 established across sessions, strategic upgrade to Josh framework (outcome-framed offers, signal detection playbook, undeniable offer structures), 6 new strategic skills installed (opportunity-scanner, signal-detection, roi-calculator, offer-architect, hormozi-offer, undeniable-offer), niche research agent created, council restructured from 9 to 7 roles, QA script expanded to 294+ lines with 7 categories + 6 locked component checks, MASTER_BRIEF updated to v4, all outreach documents written, PACKAGES.md with full pricing, scored system at 7.5/10.

**2026-03-17:** BRAIN.md created — comprehensive cross-agent memory layer. Rule 43 added. V1 completion session in progress.
