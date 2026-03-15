# 7thsense — Master Brief v2
## AI Website Agency System — Full Context Document
*Last updated: March 15, 2026*
*Purpose: Paste this into any new Claude chat to instantly resume the full system with zero context loss*

---

## HOW TO USE THIS DOCUMENT

Paste this entire document as your first message in any new chat with:
*"This is the full context for my AI agency 7thsense. Read everything before we continue. We are currently working on: [describe what you need]."*

---

## 1. WHO WE ARE

**Agency name:** 7thsense
**Owner:** Max Hurrell
**Email:** maxhurrellsa@gmail.com
**Location:** Cape Town, South Africa
**Goal:** Semi-autonomous AI-powered website agency generating revenue within 3 weeks

**The business model:**
1. Find service businesses with good Google reviews but poor or no websites
2. Build a demo website proactively (without being asked)
3. Contact them and show them the demo
4. If they like it, sell the full site (R7,500–R18,500)
5. Deliver the final site (refined version of the demo)
6. Retain them with ongoing services (WhatsApp automation, chatbot, reviews, missed call capture, analytics)

**First goal:** One paying client before next Claude subscription renewal (~3 weeks from March 15)

---

## 2. CORE PRINCIPLES

- Businesses don't care about AI — they care about more calls, leads, bookings, revenue
- Demos sell themselves — the contrast between their current site and ours closes the deal
- Mobile-first always — 80-90% of target market views on mobile
- Templates over custom — build once, deploy many times
- Brand colours come from the CLIENT's existing brand, never assumed by niche
- Real information only — reviews, ratings, contact details, services must all be real and verifiable. Stock photos are the only acceptable placeholder.
- Low friction — solutions that plug into existing workflows
- Bounded autonomy — agents improve things within defined objectives, human approval on all client-facing actions
- WhatsApp is the primary communication channel in SA — every site must have direct WhatsApp integration

---

## 3. SYSTEM ARCHITECTURE

### Current State (V1 — Live Today)
```
Max
  → Claude chat (strategy, design, code generation)
    → Claude Code in Terminal (executes on MacBook Air M4)
      → GitHub repo: MaxHurrell/Agency-Templates (templates)
      → GitHub repo: MaxHurrell/client-sites (client demos)
        → Vercel (auto-deploys on every push)
          → Live URLs per client
```

### V2 (Target: Tuesday/Wednesday)
- Claude Code runs longer autonomous loops without babysitting
- Make.com wired to handle form submissions → email notifications
- Tally.so forms live on all demo sites
- Unique Vercel project per client demo
- Master brief in GitHub

### V3 (Target: ~4 weeks)
- Railway (~$5/mo) hosts orchestration loop in cloud
- Agents run autonomously in background while Mac is off
- Milestone summaries surfaced to Max
- Full agent system running without manual triggering

### V4 (Target: ~6 weeks)
- Custom dashboard at dashboard.7thsense.app
- Individual agent chat interfaces
- Morning briefing agent (Vapi.ai for voice)

---

## 4. AGENT SYSTEM

### The 8 Agents

**Scout Agent**
- Finds and scores potential targets via Google Maps
- Scoring (100pts total):
  - 4.0+ rating, 20+ reviews = 25pts
  - Poor/outdated website = 25pts
  - NO website = 35pts (scores higher — easier pitch, no ego attachment)
  - Service business type = 20pts
  - Missing lead capture = 20pts
  - Weak Maps presence = 10pts
- Thresholds: 70-100 = hot, 40-69 = warm, below 40 = skip

**Research Agent**
- Scrapes target business using Firecrawl
- Extracts: name, phone, WhatsApp, email, address, hours, services, reviews, brand colours
- For no-website businesses: uses Google Maps + reviews + competitor sites

**Outreach Agent**
- Drafts personalised outreach using cold-email + copywriting skills
- Two pitch paths:
  - Bad site: "Here's what your site could look like" — side by side
  - No site: "Here's what you're missing every day" — demo + lost leads calculation
- Requires Approval Gate 1 before sending

**Demo Builder Agent**
- Builds conversion-focused demo websites
- Uses: ui-ux-pro-max, page-cro, copywriting, bencium-innovative-ux-designer, 21st.dev MCP, Firecrawl
- Quality benchmark: padentalimplants.com
- Must read reference site before building each niche
- Output: Multi-page HTML site deployed to Vercel

**QA Agent**
- Checks: mobile layout, load speed, all CTAs, no placeholder text, real links working, form submission, WhatsApp links

**Closer Agent**
- Two modes:
  1. LIVE MODE — drafts real follow-up messages for actual prospects
  2. TRAINING MODE — role-plays difficult prospect, coaches Max on objection handling
- Key objections: "price too high", "already have a website", "send info I'll think about it", "too busy"
- Uses sales-enable + mktg-psych (Cialdini) skills

**Delivery Agent**
- Refines demo into final site after sale
- Connects real domain, wires Tally.so forms, adds analytics, runs full SEO pass
- Target: under 2 hours from sale to live site
- Requires Approval Gate 2

**Retention Agent**
- Upsells ongoing services post-delivery
- WhatsApp automation, missed call SMS, review generation, analytics reporting
- Uses Make.com for automation

**Summary Agent**
- Weekly report: leads, demos sent, conversions, revenue, pipeline
- Eventually feeds morning voice briefing via Vapi.ai

### Two Approval Gates (non-negotiable)
- Gate 1: Before any outreach goes to a client
- Gate 2: Before any demo is shown to a client

---

## 5. TOOL STACK

### Live and Connected
| Tool | Purpose | Cost |
|------|---------|------|
| Claude Pro | Strategy, architecture, code | $20/mo |
| Claude Code | Executes on Mac, manages files, pushes to GitHub | Included |
| GitHub — Agency-Templates | Master niche templates | Free |
| GitHub — client-sites | Individual client demos | Free |
| Vercel (7sense.vercel.app) | Auto-deployment, live URLs | Free |
| Anthropic API | Powers agents programmatically | ~$0.01/run |
| Make.com | Automation glue | Free tier |
| Tally.so | Client lead capture forms | Free |
| 21st.dev Magic MCP | Premium UI components | Free tier |
| Firecrawl MCP | Deep website scraping, brand extraction | Free tier |

### Coming Soon
| Tool | Purpose | Cost |
|------|---------|------|
| Railway | Cloud orchestration V3 | ~$5/mo |
| Vapi.ai | Voice morning briefing | ~$0.05/min |
| Nano Banana | AI image generation | TBD |

### Skills Installed (~110+ in ~/.claude/skills/)
**Design:** ui-ux-pro-max, ui-styling, design, design-system, brand, banner-design, bencium-innovative-ux-designer, bencium-controlled-ux-designer
**Marketing/CRO:** page-cro, signup-cro, form-cro, popup-cro, copywriting, copy-edit, cold-email, email-seq, social, ad-creative, paid-ads, mktg-psych, mktg-ideas, ab-test, analytics-tracking, referral, churn-prevent, pricing, competitor, launch, sales-enable, revops, onboard, free-tool
**SEO:** seo-audit, seo-content, seo-geo, seo-schema, seo-technical, seo-images, seo-page, seo-plan, seo-programmatic, seo-sitemap, seo-competitor-pages, seo-hreflang, geo-audit, geo-citability, geo-crawlers, geo-schema, geo-technical, geo-content
**Market audit suite:** market-audit, market-copy, market-emails, market-social, market-ads, market-funnel, market-competitors, market-landing, market-launch, market-proposal, market-report, market-seo, market-brand

### Agents Installed (11 in ~/.claude/agents/)
business-growth, c-level, engineering, engineering-team, finance, marketing, personas, product, project-management, ra-qm-team, CLAUDE.md

---

## 6. GITHUB REPO STRUCTURE

```
MaxHurrell/Agency-Templates/     ← master niche templates
├── index.html                    ← redirects to dentist demo
├── dentist/
│   └── dr-sonday-demo-v3-mobile-first.html
├── [future niches]/
└── MASTER_BRIEF.md

MaxHurrell/client-sites/         ← one folder per client
├── client-index.md               ← tracks all clients, status, URLs
└── [client-name]/
    └── index.html
```

---

## 7. TEMPLATE LIBRARY

### Design Rules (apply to ALL niches)
- Brand colours from CLIENT's existing brand — never assumed
- Mobile-first — design mobile first, scale to desktop
- Real Unsplash photography (contextually relevant)
- SVG icons only — absolutely no emojis as icons
- Google Reviews: real Google logo, links to actual reviews page
- WhatsApp: use `whatsapp://` protocol on mobile
- Contact form: Tally.so embed, sends to client email, success state
- Floating mobile bottom bar: two buttons max (Call = navy, WhatsApp = green)
- Hamburger menu: clean minimal slide-in, reference padentalimplants.com style
- About page: in both desktop nav and mobile menu
- Font: modern, clean, premium — NO Playfair Display, NO serif ornate fonts
- SEO: meta titles, descriptions, local schema, alt text, canonical tags
- Quality benchmark: padentalimplants.com
- Real info only: all reviews, ratings, contact details must be verified real data

### Niche Intelligence Approach
For each new niche Claude Code must:
1. Identify niche automatically from business type
2. Research best converting websites globally in that niche
3. Extract design patterns, copy style, trust signals, CTA approach
4. Build in that image — not generic, not dentist-for-a-landscaper
5. Apply niche-specific trust signals (dentist = qualifications, plumber = emergency response, lawyer = case wins)

### Current Templates
**Dentist (SA market)**
- File: `~/agency-templates/dentist/dr-sonday-demo-v3-mobile-first.html`
- URL: `7sense.vercel.app`
- Status: Active development — being refined
- Real Google Reviews URL: `https://search.google.com/local/reviews?placeid=ChIJZ61zaEFrzB0RqVIYufiLzY8`
- Known issues being fixed: heading font, mobile menu, mobile CTA bar

### Next Templates to Build
1. GP / Medical practice
2. Plumber / Trades
3. Lawyer / Legal
4. Beauty / Salon
5. Cleaning services

---

## 8. CLIENT DEMO → FINAL SITE PIPELINE

```
Demo exists on Vercel (unique URL per client)
  → Client pays
    → Delivery Agent:
      1. Swap placeholders for real content
      2. Replace stock photos with client's real photos
      3. Connect real domain (client buys ~R150-200/yr)
      4. Wire Tally.so form → client's email
      5. Add Google Analytics / PostHog
      6. Full SEO pass (local schema, meta, page speed)
      7. QA check
      8. Go live
Target: under 2 hours from sale to live
Demo time target: 5-15 minutes (template population, not from scratch)
```

---

## 9. UPSELL SERVICES

| Service | How it works | Integration |
|---------|-------------|-------------|
| WhatsApp automation | Auto-reply, nurture sequences, appointment reminders | WhatsApp Business + Make.com |
| Missed call SMS | Someone calls, no answer → auto WhatsApp sent | Twilio + Make.com |
| Review generation | Post-appointment WhatsApp asking for Google review | Make.com automation |
| Chatbot | Answers questions, captures leads 24/7 | Tidio/Crisp embed |
| Monthly analytics | Visitor counts, form submissions, lead reports | PostHog + Summary Agent |
| Google Maps optimisation | Improve local ranking | Manual + tools |

**Key sales framing:** "Your website now has a WhatsApp button. Every person who clicks it is a warm lead. We can set up an automated system that follows up with every single one of them, reminds them about appointments, and asks for reviews — all on WhatsApp, all automatically. That's the difference between a website and a customer capture system."

---

## 10. PRICING STRATEGY

| Package | What's included | Price |
|---------|----------------|-------|
| Starter site | 3-page site, contact form, mobile optimised | R7,500 (~$400) |
| Growth site | Starter + chatbot + Google review system | R12,500 (~$650) |
| Full system | Growth + missed call + analytics + monthly report | R18,500 (~$1000) |
| Monthly retainer | Updates, reporting, optimisation, WhatsApp automation | R2,500/mo |

---

## 11. SCOUT SCORING — SPECIAL CASES

### Business with NO website (scores HIGHER)
- No website = 35pts vs 25pts for bad website
- Pitch: "Here's what you're missing" not "Here's an upgrade"
- Research: Google Maps + reviews + 2-3 competitors
- Easier close: no defensiveness, purely an opportunity conversation

---

## 12. HOSTING & DOMAIN STRATEGY

**Demo phase:**
- Hosted on 7thsense Vercel account
- Each client gets unique Vercel project: `[clientname]-demo.vercel.app`
- Free, no client action needed

**After sale:**
- Client buys domain (~R150-200/yr from Domains.co.za)
- Point to Vercel (5 min setup)
- Vercel hosts free
- Client owns domain, 7thsense manages hosting

**Long term:**
- Keep all client sites on 7thsense Vercel account for control
- Only transfer if client specifically requests it

---

## 13. SOLVED PROBLEMS (never re-solve these)

| Problem | Solution |
|---------|----------|
| npm permission denied | Use `sudo npm install -g` |
| Terminal not finding npm after install | Close Terminal fully (Cmd+Q) and reopen |
| Claude Code permission prompts | Already set to allow all Bash(*) in ~/.claude/settings.json |
| Vercel 404 on root URL | index.html at root redirects to demo file |
| file:// URL only works locally | Always use Vercel URL for sharing |
| GitHub Pages makes site searchable | Disabled — Vercel only |
| wa.me WhatsApp creates browser interstitial | Use whatsapp:// protocol on mobile |
| npm cache permissions | Run `sudo chown -R $(whoami) ~/.npm` in regular Terminal |
| Claude Code sudo needs terminal password | Run sudo commands in regular Terminal not Claude Code |
| Ctrl+C vs Cmd+C | Ctrl+C stops processes, Cmd+C is copy |
| API keys visible in chat | Never paste API keys here — type directly in Terminal |
| Skills not activating | Restart Claude Code after installing new skills |
| New skills need fresh session | Type `exit` then `claude` to restart |
| Files go to Documents not Downloads | Max's files save to Documents folder |
| Playfair Display keeps returning | Explicitly tell Claude Code to read ui-ux-pro-max skill first and ban Playfair Display |
| Google Reviews dynamic link error | Use: https://search.google.com/local/reviews?placeid=[PLACE_ID] |
| Dr. Sonday Google Place ID | ChIJZ61zaEFrzB0RqVIYufiLzY8 |

---

## 14. MONTHLY COSTS

| Item | Cost |
|------|------|
| Claude Pro | $20/mo |
| Anthropic API | ~$10-20/mo at scale |
| Vercel | Free |
| GitHub | Free |
| Make.com | Free tier |
| Tally.so | Free |
| Railway (when needed) | ~$5/mo |
| **Total** | **~$35-45/mo** |

---

## 15. VOICE AGENT PLAN (V4)

- Platform: Vapi.ai
- Use: Morning briefing, strategy questions, pipeline updates
- No app build required — uses Vapi.ai interface
- Feeds from: Summary Agent daily report
- Timeline: After V3 stable

---

## 16. AUTONOMOUS ITERATION LOOP

```
Define objective
  → Orchestrator assigns tasks
    → Frontend Agent (layout, mobile)
    → CRO Agent (CTAs, trust signals)
    → Copy Agent (headlines, CTAs)
    → QA Agent (broken elements, mobile)
  → Code updates → Vercel deploys
  → Loop repeats until objective met
  → Surface milestone to Max
```
- V1: Max triggers manually via Claude Code
- V2: Claude Code runs multi-iteration loops on Mac
- V3: Railway runs in cloud background
- Cost per loop: ~$0.20-0.50 API

---

## 17. WHATSAPP AS LEAD NURTURE SYSTEM

WhatsApp is the primary communication channel in SA. Every demo site has a direct WhatsApp link. This enables:
- Instant first contact with no form friction
- WhatsApp Business auto-reply for after hours
- Make.com monitoring incoming messages → follow-up sequences
- Appointment reminders day before
- Post-appointment review requests
- Missed call → automatic WhatsApp response
- Monthly check-in messages to past patients

This is the core upsell that moves clients from one-time payment to monthly retainer.

---

## 18. IMMEDIATE NEXT STEPS

### Active Right Now
- Dentist template font fix (running in Claude Code)
- Mobile menu redesign to match padentalimplants.com
- Mobile CTA bar refinement
- Google Reviews link fix

### Next Session Priorities
1. Review updated dentist site on mobile — compare to padentalimplants.com
2. Set up unique Vercel project per client demo system
3. Lock dentist master template
4. Build GP/Medical template (second niche)
5. Wire Make.com to Tally.so forms
6. Begin building client-index.md tracking system

### First Client Goal
- Target: 1 paying client within 3 weeks
- Profile: 4.2+ Google rating, 20+ reviews, poor or no website, Cape Town area
- Price point: R7,500-R12,500 for first sale
