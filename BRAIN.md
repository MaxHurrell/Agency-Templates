# 7thsense BRAIN.md
*Last updated: March 19, 2026 (Day 4)*
*Read this before anything else. Every agent reads this. Update at the end of every session.*
*Source of truth: MASTER_BRIEF.md + session transcripts + CLAUDE.md. Never written from memory.*

---

## WHAT WE ARE BUILDING

**Agency:** 7thsense
**Owner:** Max Hurrell (maxhurrellsa@gmail.com)
**Location:** Cape Town, South Africa
**What we sell:** A customer acquisition system for service businesses — not websites. The website is the entry point. The full system includes: conversion-optimised website, Google Reviews growth automation, missed call text-back, AI chat widget, WhatsApp automation suite, and monthly reporting.
**Model:** Find service businesses provably losing money online → quantify the loss → build demo proactively → show proof + math → close → retain with ongoing system
**Status:** V1 COMPLETE. V2 IN PROGRESS. First outreach SENT (Werner Joubert — awaiting response). Automated prospect pipeline built. 26 custom skills installed. Mobile terminal access working.
**System version:** V1 COMPLETE → V2 in progress (automated pipeline, expanded niches)
**Revenue target:** R10-15K/month within 90 days. 5 demos/week → 1 client/week → R50K/month in 5-6 months
**Outreach team:** Tristan handles WhatsApp/email/LinkedIn/Instagram outreach. Max handles builds and strategy.
**WhatsApp:** +27791613001
**Full strategy:** See ~/agency-templates/7thsense-system/STRATEGY-V1.md

---

## CURRENT SCORES

| Metric | Score | Source |
|--------|-------|--------|
| System score | 9.6/10 | V1 complete, pipeline automated, 26 custom skills |
| Days completed | 4 | Day 1: Mar 16, Day 2: Mar 17, Day 3: Mar 18, Day 4: Mar 19 |
| V1 status | COMPLETE | Locked components proven, Gemini working, 7 demos live |
| V2 status | IN PROGRESS | Automated pipeline, expanded scoring, niche expansion |
| First outreach | SENT | Werner Joubert — Tristan sent, awaiting response |
| Pipeline | AUTOMATED | prospect-pipeline.sh — one command, full scored CSV |
| Mobile access | WORKING | Tailscale + Termius (Mac IP: 100.124.236.67) |
| Dashboard | v5 live | dashboard-two-chi-28.vercel.app — Jarvis intelligence terminal |
| ElevenLabs | Configured ($5/mo) | Jarvis voice (ID: wDsJlOXPqcvIUKdLXjDs) |
| Skills | 26 custom + 90+ supporting | See SKILLS INSTALLED section |

**V1 is COMPLETE.** V2 is in progress — automated prospect pipeline built, 25-point scoring, AI message generation, CSV output for Tristan.

**Remaining gaps to 10/10:**
- No analytics on demo sites (-0.15)
- No Make.com automation wired yet (-0.1)
- Invoice template not yet created (-0.1)
- Zoho email not set up yet (-0.05)

---

## LIVE DEMOS

| Client | Niche | URL | Status |
|--------|-------|-----|--------|
| Dr. Sonday Dentistry | Dental | drsonday.vercel.app | Live |
| Werner Joubert Dental | Dental | werner-joubert.vercel.app | Live — first prospect, outreach SENT |
| Miami Beach Laser & Aesthetics | Aesthetics | miami-beach-laser.vercel.app | Live — US demo |
| The Lions' Den, Attorneys at Law | Law | lions-den-alpha.vercel.app | Live — US demo |
| Property deCoded | Real Estate | property-decoded.vercel.app | Live — friend demo |
| 7thsense Agency Website | Agency | 7thsense-website.vercel.app | Live — public-facing site |
| 7thsense Dashboard | Internal | dashboard-two-chi-28.vercel.app | Live — Jarvis HUD |
| Objection Handler | Internal | objection-handler-rho.vercel.app | Live — Max + Tristan tool |

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
**Price:** R5,000. Pay nothing until you've seen the finished demo.
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
- `7thsense-strategic-intelligence` — **NEW** master orchestration (Josh framework, 25-point scoring, offer selection, quality gates)
- `7thsense-prospect-qualifier` — **NEW** pre-qualification (GREEN/AMBER/RED routing, domain intelligence, GBP scoring)
- `7thsense-opportunity-scanner` — ranked prospect lists with financial impact (updated with pre-qual pass)
- `7thsense-signal-detection` — problem signal hierarchy and detection methods
- `7thsense-roi-calculator` — monthly cost of problem, break-even, 12-month ROI
- `7thsense-offer-architect` — personalised outcome-framed offers per prospect
- `7thsense-hormozi-offer` — $100M Offers framework applied to 7thsense
- `7thsense-undeniable-offer` — zero-risk, results-based, mathematically impossible to refuse

### Operations Skills (Day 3-4)
- `7thsense-lead-enricher` — auto-find phone, email, WhatsApp, social for any prospect
- `7thsense-debugger` — full-spectrum debug check on any 7thsense site
- `7thsense-self-healing` — auto-detect and fix errors in sites
- `7thsense-webapp-tester` — end-to-end functional testing
- `7thsense-researcher` — deep research for prospects, niches, competitors
- `7thsense-cost-reducer` — optimise Claude Code token usage
- `7thsense-superpowers` — orchestrate multiple skills for end-to-end tasks

### Quality Skills
- `ui-ux-pro-max` — international UX standards (read before font selection)
- `7thsense-visual-design` — brand design critique and visual quality evaluation
- `page-cro` — conversion pass before commit
- `seo-technical` — SEO pass before commit

### System Scripts (~/agency-templates/7thsense-system/scripts/)
- `prospect-pipeline.sh` — **MASTER** automated pipeline (Maps search → score → CSV)
- `qualify-prospect.sh` — domain/technical pre-qualification (GREEN/AMBER/RED)
- `enrich-lead.sh` — contact enrichment (phone, email, social, Google Places)
- `enrich-batch.sh` — batch enrichment for lead lists
- `detect-google-ads.sh` — Google Ads tag detection on websites
- `detect-meta-ads.sh` — Facebook Pixel/Meta tag detection
- `mine-negative-reviews.sh` — pain language mining from Google reviews
- `check-instagram.sh` — Instagram presence detection
- `check-hiring.sh` — Indeed.co.za job board monitoring
- `check-domain-age.sh` — whois domain age and expiry
- `check-social-activity.sh` — social media presence scan
- `qa-pre-deploy.sh` — pre-deployment quality checks
- `validate-niche-config.sh` — niche config validation

### System Documents
- `~/agency-templates/7thsense-system/PROSPECTING-V2.md` — full council output, signal upgrade, scoring model
- `~/agency-templates/7thsense-system/STRATEGY-V2-INNOVATIONS.md` — GBP playbook, automation stack
- `~/agency-templates/7thsense-system/DEPLOYMENT-PROCESS.md` — 54-step go-live checklist
- `~/agency-templates/7thsense-system/DOMAIN-PLAYBOOK.md` — 8 domain scenarios
- `~/agency-templates/7thsense-system/SEO-TRANSITION-PROTOCOL.md` — domain migration
- `~/agency-templates/7thsense-system/CURRENT-STATUS.md` — live system status
- `~/agency-templates/tasks/lessons.md` — operational lessons learned

### Total skills installed: 26 custom 7thsense + 90+ supporting (marketing, SEO, GEO, design, engineering)

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

### Mobile Access
- **Tailscale** — VPN mesh network, Mac IP: 100.124.236.67
- **Termius** — SSH client on iPhone, full terminal access to Mac
- Can run any script, deploy sites, manage pipeline from phone

### Machine
- MacBook Air M4
- Claude Code (latest)
- Two terminal tabs: Tab 1 (Pipeline/Strategy), Tab 2 (Execution/Builds)

### Monthly Costs
| Item | Cost |
|------|------|
| Claude Max | $100/mo |
| ElevenLabs Starter | $5/mo |
| Gemini API | ~$0.15/site ($300 free until June 14 2026) |
| Vercel | Free |
| GitHub | Free |
| Make.com | Free tier |
| Tally.so | Free tier |
| Tailscale | Free tier |
| **Total now** | **~$105/mo** |

---

## PRICING

*Source: PACKAGES.md*

| Package | Price | Key Deliverables |
|---------|-------|------------------|
| Starter | R5,000 | Full website build, mobile-optimised, SEO-ready, live on your domain, contact form |
| Growth | R9,000 | Everything in Starter + GBP optimisation, Google Reviews automation, monthly dashboard, GA4, speed optimisation, priority support |
| Monthly Retainer | R2,500/mo | Monthly updates, uptime monitoring, monthly report, priority support, content changes |

**Payment terms:** 50% deposit, 50% before go-live. EFT or payment link.
**Add-ons:** Additional page R1,500, Blog R2,500, Google Ads setup R5,000, Logo R3,500

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
| ~~Gemini image generation~~ | ~~FIXED~~ — gemini-2.5-flash-image working | ✅ DONE |
| ~~Mobile access~~ | ~~FIXED~~ — Tailscale + Termius working | ✅ DONE |
| ~~Dashboard~~ | ~~FIXED~~ — Jarvis v5 live | ✅ DONE |
| No analytics on demo sites | Cannot prove prospects viewed demos | V2 |
| No Make.com → Tally wiring | Form submissions not automated | V2 |
| No invoice template | Cannot bill professionally | Before first payment |
| Zoho email not set up | No professional email addresses | This week |
| Ad detection relies on pixel proxies | Need real Ads Transparency/Ad Library integration | Prospecting upgrade session |
| Railway cloud orchestration | Agents can't run while Mac is off | V3 (~4 weeks) |

---

## OUTSTANDING TO-DO LIST

### Priority 1 — Makes Money
1. Werner Joubert follow-up if no response by 20 March
2. Run pipeline on aesthetics: `zsh prospect-pipeline.sh "aesthetics clinic" "Cape Town" --count 20`
3. Dental & Orthodontic Clinic (577 reviews, no website) — investigate and build demo
4. Build 2-3 more dental prospect demos from pipeline output

### Priority 2 — Prospecting System Upgrade (dedicated session)
5. Fix scoring model — businesses without detectable ad data should not be penalised
6. Research APIs: SerpAPI, Apify, PhantomBuster, Apollo.io, Hunter.io
7. Fix ad detection to use real sources (Ads Transparency, Ad Library) not just pixel proxies
8. Build smarter scoring fallback when ad data unavailable
9. Identify free vs paid tools for lead intelligence

### Priority 3 — System
10. Zoho email setup: hello@7thsense.co.za and max@7thsense.co.za
11. Agency name decision — register domain once decided
12. Boris Cherny CLAUDE.md principles merge
13. Dashboard Ideas tab
14. System tightening — audit skills, under 80 target
15. Score-prospect.sh upgrade to full 25-point model
16. Invoice template creation

### Priority 4 — Innovation Lab (separate chat)
17. YouTube transcripts for master council upgrade ($100M Offers/Leads, Greg Isenberg, Dan Martell)
18. AI ads innovation session
19. Chatly investigation for pitch decks
20. Manus brief — find problems worth solving
21. OpenClaw investigation

### Reminders
- Gemini API free credits expire June 14, 2026. Evaluate paid tier by mid-April.
- Music chapter closed — no follow-ups needed
- All future primary build sessions in AI Web Agency Claude Project
- Use generate-context.sh to create handover prompt when switching chats

---

## SESSION LOG

**2026-03-16:** Full build session day 1. Accomplished: locked components skill created (15 components defined), three demos built (Dr. Sonday dental, Team24 insurance), regression audit completed (8 regressions identified and rules created to prevent), Rules 1-42 established across sessions, strategic upgrade to Josh framework (outcome-framed offers, signal detection playbook, undeniable offer structures), 6 new strategic skills installed (opportunity-scanner, signal-detection, roi-calculator, offer-architect, hormozi-offer, undeniable-offer), niche research agent created, council restructured from 9 to 7 roles, QA script expanded to 294+ lines with 7 categories + 6 locked component checks, MASTER_BRIEF updated to v4, all outreach documents written, PACKAGES.md with full pricing, scored system at 7.5/10.

**2026-03-17 (Day 2 — full session):** BRAIN.md created — comprehensive cross-agent memory layer. Rules 43-50 added across session. Skills audit: 23 redundant skills removed. Visual polish pass on all 3 existing sites (peach palette Miami Beach, gradient balance, bible verse Lions Den, mobile hero niche colours). STRATEGY-V1.md written (5,155 words — full business model, client profile, pricing logic, growth model). First Josh-level prospect package written (Werner Joubert Dental, Bellville). Google Maps API key configured and Place IDs auto-retrieved for all sites. Werner Joubert Dental proof build completed — first fully system-built demo. Real logo downloaded, real doctor photo, real Place ID auto-retrieved (ChIJV9t8n75QzB0R-3svvo5aMUI), 6 real reviews, 8 Gemini-generated service images, hero image generated. QA passed 0 errors. Tally placeholder form ID corrected. Site live at werner-joubert.vercel.app. Gemini image generation confirmed working (gemini-2.5-flash-image model) — resolves long-standing 404 issue. Tools confirmed: WiserReview ($9-19/mo) recommended for reviews automation, GoHighLevel ($97/mo) as all-in-one at 5+ clients. Strategic Intelligence skill created (342 lines, 8 sections — Josh framework orchestration, 25-point scoring matrix, offer selection logic, quality gates). Prospect pre-qualification system built (qualify-prospect.sh — GREEN/AMBER/RED routing, domain intelligence, GBP scoring). Werner Joubert qualified GREEN — ready for outreach. Property deCoded real estate demo built (property-decoded.vercel.app — real logo, 6 agent photos, 4.6 stars, 95 reviews). 7thsense Operations Jarvis Dashboard v3 building — HUD animation, voice briefing, 8-stage pipeline, arc reactor. Innovation Lab Claude Project recommended. Tailscale + Termius remote access solution identified. Google Reviews URL fix across all sites (Rule 22 hardened). Google Maps embed added to all sites (Rule 50, Locked Component 16). DEPLOYMENT-PROCESS.md written (54-step go-live checklist, client handoff template). DOMAIN-PLAYBOOK.md written (8 scenarios, 731 lines). STRATEGY-V2-INNOVATIONS.md written (GBP playbook, automation stack, revised 3-tier packages). SEO-TRANSITION-PROTOCOL.md written (domain migration, 301 redirects, 30/60/90 monitoring). V1 declared COMPLETE. System score: 9.4/10. Jarvis Dashboard v5 built and deployed — ElevenLabs voice integrated (ID: wDsJlOXPqcvIUKdLXjDs), DM Mono/DM Sans fonts, intelligence terminal aesthetic, 5 tabs, mobile-first. Font size fix applied. Innovation lab directory created. Tomorrow to-do list finalised: Werner Joubert outreach, Tailscale/Termius, ElevenLabs testing, AI ads innovation session, validation deck for agencies.

**2026-03-18 (Day 3):** Jarvis Dashboard v5 deployed (dashboard-two-chi-28.vercel.app). ElevenLabs Jarvis voice integrated (ID: wDsJlOXPqcvIUKdLXjDs, Starter plan $5/mo). Agency website built and deployed (7thsense-website.vercel.app) — dark navy + teal brand, DM Sans/DM Mono, hero/problem/how-it-works/pricing/contact sections. Pricing updated: Starter R5,000, Growth R9,000, Retainer R2,500/mo. Demo section later removed (no client permission to show). Objection handler built and deployed (objection-handler-rho.vercel.app) — Anthropic API integration, niche/tone pills, 8 quick-load objections, WhatsApp-style reply bubble, session history. 20 dental leads scraped, scored, enriched and sent to Tristan in CSV. Werner Joubert outreach sent by Tristan — first ever agency outreach. Tailscale + Termius set up — full mobile terminal access working (Mac IP: 100.124.236.67). Context generator built (generate-context.sh — paste into new chat for continuity). lessons.md and CURRENT-STATUS.md created. Council session: 90-day revenue plan, honest assessment, skill upgrade recommendations. Tristan briefing document written and sent. Lead enrichment system built: enrich-lead.sh (single lead), enrich-batch.sh (batch with 10 dental leads pre-loaded), 7thsense-lead-enricher skill created. Werner Joubert enriched: phone +27219143884, email reception@joubertdental.co.za, Facebook found. WhatsApp number confirmed for agency: +27791613001.

**2026-03-19 (Day 4):** 26 custom 7thsense skills installed (6 new: debugger, self-healing, webapp-tester, researcher, cost-reducer, superpowers). Prospecting V2 council session completed — PROSPECTING-V2.md saved with full strategic analysis: top 10 new signals ranked by predictive value, top 5 new prospecting channels, updated 25-point scoring model with Budget Signal dimension, niche expansion map (aesthetics #1 at 23/25, physio #2, vet #3, law #4, optometry #5), automation blueprint, Hormozi lens applied, 3 quick wins identified. Automated prospect pipeline built: prospect-pipeline.sh master script — one command searches Google Maps, runs 7 signal detection sub-scripts, scores on 25-point matrix, outputs MD report + CSV for Tristan. 8 signal detection scripts built: detect-google-ads.sh (checks site source for AW- conversion tags, remarketing, GTM), detect-meta-ads.sh (Facebook Pixel, Meta SDK detection), mine-negative-reviews.sh (Google Places API + pain keyword filter), check-instagram.sh (profile detection, bio website check), check-hiring.sh (Indeed.co.za scraping), check-domain-age.sh (whois parsing, expiry urgency), check-social-activity.sh (Facebook/Instagram/LinkedIn/Twitter/YouTube/TikTok presence scan). Pipeline v2 upgraded with: Place Details API 2-step lookup, 4-step website verification chain (master CSV → API → domain patterns → curl HEAD), confidence scoring (HIGH/MEDIUM/LOW), Hellopeter complaint detection, pain language mining with SA-specific phrases, master-leads.csv as single source of truth, 5-dimension scoring (D1 Website Quality, D2 Visibility Gap, D3 Budget Signals, D4 Pain Signals, D5 Urgency Signals), routing at 20-25 CRITICAL, 15-19 HIGH, 10-14 MEDIUM, below 10 PASS. Pipeline tested on "dentist Bellville Cape Town" — found 5 businesses, 4 with NO website (critical opportunity). Key finding: Dental & Orthodontic Clinic has 577 reviews, 4.8 stars, ZERO web presence. Agency website hero updated: "Right now, someone searched for you, saw your site, and left." Objection handler redesigned to Linear-inspired light theme (Figtree + Syne fonts). Data accuracy failure identified and fixed: multi-source verification prevents false "no website" readings. Boris Cherny CLAUDE.md principles identified — integration pending. Prospecting system upgrade session added to priority list for dedicated iteration on scoring model, API integrations, signal detection.
