# 7thsense — Master Brief v4
## AI Website Agency System — Full Context Document
*Last updated: March 16, 2026*
*Purpose: Paste this into any new Claude chat to instantly resume with full context*

---

## HOW TO USE THIS DOCUMENT

Paste this entire document as your first message in any new chat:
*"This is the full context for my AI agency 7thsense. Read everything before we continue. We are currently working on: [describe what you need]."*

---

## 1. WHO WE ARE

**Agency:** 7thsense
**Owner:** Max Hurrell (maxhurrellsa@gmail.com)
**Location:** Cape Town, South Africa
**Model:** Find service businesses with poor/no websites → build demo proactively → show demo → sell full site → retain with ongoing services
**Status:** Pipeline fully built. System hardened with locked components. Ready to send demos once visual QA confirmed.

---

## 2. LIVE DEMOS

| Client | Niche | URL | Status |
|--------|-------|-----|--------|
| Dr. Sonday Dentistry | Dental | drsonday.vercel.app | ✅ Live — undergoing final visual QA |
| Team24 | Insurance Broker | team24insurance.vercel.app | ✅ Live — first potential client, awaiting payment |

*Old auto-generated aliases (dentist-pi-eight.vercel.app, team24-nine.vercel.app) still resolve but not used in client-facing comms.*

---

## 3. FULL INFRASTRUCTURE

### GitHub Repos
- `MaxHurrell/Agency-Templates` — master templates, skills, system files, outreach docs, packages
- `MaxHurrell/client-sites` — individual client demos

### Vercel
- Each client gets own Vercel project with unique URL
- Automated via `deploy-client.sh` using VERCEL_TOKEN
- Deploy command: `cd ~/client-sites && ./deploy-client.sh [client-name]`

### Local Machine (MacBook Air M4)
- Claude Code v2.1.76
- Two terminal tab workflow:
  - Tab 1 (Pipeline): Strategic council, agents, planning
  - Tab 2 (Execution): Builds, deploys, fixes

### API Keys (all in ~/.zshrc)
- GEMINI_API_KEY — Gemini image generation ($300 free credit, expires June 14 2026) ⚠️ Image generation endpoints currently returning 404 — needs diagnostic
- VERCEL_TOKEN — Vercel deployments (rotate regularly, never expose in output)
- ANTHROPIC_API_KEY — Claude API

### MCP Servers Connected
- 21st.dev Magic MCP — premium UI components
- Firecrawl MCP — web scraping, brand extraction

---

## 4. THE BUILD SYSTEM

### Mandatory Skill Reading Order (every new build)
1. `7thsense-locked-components` ← MUST BE FIRST — defines locked modules that never change
2. `7thsense-niche-intelligence` — research + design decisions document
3. `7thsense-systems-architect` — technical blueprint
4. `7thsense-visual-system` — design tokens before code
5. `7thsense-copy-architect` — copy before layout
6. `7thsense-image-agent` — images before final build
7. `ui-ux-pro-max` — international UX standards
8. `page-cro` — conversion pass
9. `seo-technical` — SEO pass

### Build Pipeline (mandatory for every new site)
```
1. Fill niche config (~10 mins)
   cp ~/agency-templates/7thsense-system/niche-config-template.json ./[client]-config.json

2. Validate config (instant)
   bash ~/agency-templates/7thsense-system/scripts/validate-niche-config.sh

3. Build from config (15-20 mins)
   Claude Code reads skills in order above + builds site

4. QA check (instant)
   bash ~/agency-templates/7thsense-system/scripts/qa-pre-deploy.sh

5. VISUAL PRE-SEND CHECKLIST (manual — Max on phone)
   See ~/agency-templates/7thsense-system/VISUAL-PRE-SEND-CHECKLIST.md

6. Deploy (2 mins)
   ./deploy-client.sh [client-name]
   curl confirm 200
```

### System Files Location
```
~/agency-templates/7thsense-system/
├── niche-config-template.json
├── BUILD-PROCESS.md
├── PACKAGES.md
├── GO-LIVE-CHECKLIST.md
├── CONTRACT-TEMPLATE.md
├── VISUAL-PRE-SEND-CHECKLIST.md
├── examples/
│   ├── niche-config-dentist.json
│   └── niche-config-insurance.json
├── scripts/
│   ├── validate-niche-config.sh
│   └── qa-pre-deploy.sh (294+ lines, 7 categories + 6 locked component checks)
└── components/
    └── hero-overlay.css

~/agency-templates/outreach/
├── whatsapp-first-touch.md
├── email-first-touch.md
├── follow-up-sequence.md
└── client-handoff.md

~/agency-templates/skills-backup/
└── (all 6 custom skills backed up)
```

---

## 5. THE TWO-LAYER SYSTEM

### Layer 1 — Locked Components (never vary)
These are solved problems. Structure, behaviour, and implementation never change. Only content changes (text, numbers, images, colours from client).

Locked components (defined in `7thsense-locked-components` skill):
1. **Hero section** — image + directional gradient overlay, text left desktop / centred mobile, one CTA, clickable Google rating badge
2. **Trust strip** — dark brand background, 4 stats, 4-col desktop / 2x2 grid mobile, never wraps
3. **Google badge** — full 272x92 wordmark SVG in brand colours, always linked to Google reviews, only shown if reviews exist
4. **Services section** — image cards (image + name + description), never icon-only, 4-col desktop
5. **Team section** — photo + name + role + description, only shown if real photos exist, never AI faces
6. **Reviews section** — real verbatim quotes, two-letter avatars, HTML entity stars, Google wordmark, only shown if reviews exist
7. **Review cards** — stars as HTML entities, italic text, two-letter avatar, Google G source badge
8. **Floating bar** — 2 buttons max (Call + WhatsApp), mobile only, 48px tap targets
9. **Tally form** — iframe embed, source param always set, never custom forms
10. **Navigation** — transparent→solid on scroll, logo left, links centre, phone right, hamburger mobile
11. **Footer** — dark charcoal never brand primary, 3-column desktop
12. **Schema markup** — LocalBusiness JSON-LD, verified data only
13. **Medical aids** — pill/badge format, all accepted aids listed (SA-specific)
14. **WhatsApp button** — always #25D366, mobile number only, wa.me format
15. **Favicon** — branded SVG with initials, never emoji

### Layer 2 — Flexible Design Tokens (vary between builds)
Font choice, border radius, section order, card style, divider style, CTA shape, animation direction, brand colour palette.

---

## 6. CLAUDE.md OPERATING CONTRACT

Location: `~/.claude/CLAUDE.md` (global) and `~/agency-templates/CLAUDE.md` (GitHub)

### 26 Hard Rules (never violate)
1. Never use brand colour as full section background outside the hero
2. Never use Playfair Display or ornate serif fonts
3. Never include WhatsApp for a landline number
4. Never commit invented statistics or unverified claims
5. Never have more than one primary CTA above fold on mobile
6. Never commit without running pre-commit QA checklist
7. Never use Unsplash or any stock photo library — image pipeline: Firecrawl → Gemini → cropped fallback
8. Never use niche default colours without first trying Firecrawl CSS AND Gemini Vision extraction
9. Never use lorem ipsum — always realistic dummy content
10. Never skip the pre-build checklist
11. Never expose API keys or tokens in any output or command echo
12. Design uniqueness: niche research must drive structural decisions
13. Image generation: every image specifically prompted for exact section
14. Image extraction: always attempt Firecrawl first, flag if JavaScript-rendered
15. Hero text contrast: directional gradient overlay on desktop, text-shadow on all hero elements
16. Contact form: every site must use master Tally contact form component — set &source= parameter
17. Locked components read first — they define structure that never changes
18. Google badge: full 272x92 wordmark SVG — never plain text "Google"
19. Stars: HTML entities only — never SVG stars
20. Review text: real verbatim Google quotes only — never placeholder text
21. Review avatars: two-letter initials always (CB, FR, SB) — never single letter
22. Hero rating: must be clickable anchor tag linking to Google reviews
23. Trust bar stats: numbers/values only — never location names as stats
24. Favicon: branded SVG with initials — never emoji
25. Data verification: cross-check all contact details against Google Maps before deploying
26. Image files: verify all local src= paths exist as actual files before deploying

### Conditional Module Rules
- **Team section**: only include if real team photos exist from Firecrawl or client-provided. Never AI faces.
- **Reviews section + Google badge**: only include if business has real Google reviews. Never empty/placeholder cards.
- **Hero Google rating badge**: only include if reviews exist.
- **Firecrawl wrong business**: if Firecrawl returns a different business name — STOP. Flag to Max. Never use niche defaults without explicit Max approval.

---

## 7. DESIGN RULES

### Colour Usage
- Brand primary: hero background, buttons, badges, accents, icons ONLY
- All content sections: white, cream, or light grey backgrounds
- Footer: dark charcoal — never brand primary
- WhatsApp button: always #25D366
- Trust strip: dark variant of brand primary

### Typography
- Approved fonts: DM Sans, Syne, Outfit, Plus Jakarta Sans, Urbanist, Satoshi, Cabinet Grotesk, General Sans
- BANNED: Playfair Display, all ornate serifs
- Max 2 font families per site

### Mobile
- Floating bar: max 2 buttons
- WhatsApp only if mobile number confirmed
- One CTA above fold only
- All tap targets min 48px

### Images
Priority: Firecrawl real images → audit gaps → Gemini generation (locked brief) → cropped fallback → never Unsplash
- Hero: real background image always — plain CSS gradient is not acceptable
- Services: image card structure always — never icon-only
- Team: real photos only — skip section if none available
- Icons: Lucide (UI) → Simple Icons (brand) → Phosphor → Gemini only for custom illustrative

### Google Reviews Display
- Always use full 272x92 Google wordmark SVG in brand colours
- Always link to real Google reviews page in new tab
- Stars as HTML entities only
- Real verbatim review quotes only
- Two-letter avatars only
- If no reviews exist — omit all review components entirely

---

## 8. CLIENT FEEDBACK INTERPRETATION RULES

1. Interpret intent not just literal request — scan entire site for all related instances
2. Scan before changing — read full file first
3. Consistency check — apply change everywhere it logically applies
4. Never break what works — copy changes only touch text, never CSS/HTML structure
5. Report all changes including ones not explicitly requested

---

## 9. NICHE DIFFERENTIATION SYSTEM

### 8 Differentiation Levers (flexible layer only)
No two consecutive builds may share the same value on more than 2 of these 8:
1. Heading font
2. Hero layout
3. Border radius
4. Card style
5. Section order
6. Divider style
7. Accent pattern
8. CTA shape + text

### Niche Emotional Registers
- Dental: safe, comfortable, cared for, trust in expertise
- Insurance: secure, protected, understood, trusted
- Legal: confident, protected, authoritative
- Plumbing: relieved, urgent problem solved, reliable, local
- Medical/GP: reassured, caring, professional, accessible
- Beauty/Salon: excited, pampered, aspirational
- Cleaning: fresh, organised, stress-free

---

## 10. PRICING

| Package | Price |
|---------|-------|
| Starter site | R7,500 |
| Growth site | R12,500 |
| Full system | R18,500 |
| Monthly retainer | R2,500/mo |

Full deliverables defined in: `~/agency-templates/7thsense-system/PACKAGES.md`

---

## 11. VERIFIED CLIENT DATA

### Dr. Sonday Dentistry
- Phone: 021 783 0024 (landline — call button only)
- WhatsApp: 064 944 7759 (mobile — WhatsApp applicable, wa.me format)
- Email: docsonday12@gmail.com
- Address: Flat 1, 18 Gemini Way, Ocean View, Cape Town, 7975
- Hours: Mon-Fri 08:30-17:00, Sat 08:00-12:30
- Google Place ID: ChIJZ61zaEFrzB0RqVIYufiLzY8
- Reviews URL: https://search.google.com/local/reviews?placeid=ChIJZ61zaEFrzB0RqVIYufiLzY8
- Real reviews: Clare Bowen, Savannah Finlay, Fatima Rawoot, Shelley Bright, Patsy Hamilton
- Review count: 13 | Rating: 5.0
- Medical aids: Discovery, Gems, Bonitas, Medihelp, Keyhealth, Medshield, Momentum, Fedhealth
- Team: Dr. Shabier Sonday, Harriet Lamb, Lungelwa, Zee
- Brand colours: Primary #4a9bb0, Dark #3a8298, Light #63aabc, Accent #e8a84c
- Extraction method: firecrawl_css_previous_build

### Team24 Insurance
- Phone: 021 782 1208 (landline — no WhatsApp on this number)
- WhatsApp: +27 84 666 7143 (separate mobile number)
- Email: info@team24.co.za
- Address: 5 Teubes Road, Kommetjie, 7976
- Legal entity: Etienne & Anthea de Villiers CC t/a Team24
- FSP: 2180, Registration: CK97/65398/23, PI Certificate: CN1083
- Member: Anthea M de Villiers
- Established: 1997, Combined experience: 88 years
- Brand colours: Primary #2D7D5F, Accent #3DAA85, Background #F5F0E8

---

## 12. SOLVED PROBLEMS (never re-solve)

| Problem | Solution |
|---------|----------|
| npm permission denied | `sudo npm install -g` |
| Terminal not finding npm | Close Terminal (Cmd+Q) and reopen |
| Vercel 404 on subfolder | Each client gets own Vercel project via deploy-client.sh |
| Token invalid/expired | Check prefix starts with vcp_ — regenerate at vercel.com/account/tokens |
| Token exposed in output | Never paste tokens here — rule 11 in CLAUDE.md |
| Skills not activating | Restart Claude Code after installing |
| Playfair Display returning | Explicitly banned in CLAUDE.md rule 2 |
| Green section backgrounds | Rule 1 — accent only outside hero |
| Hero text unreadable | Use hero-overlay.css component — rule 15 |
| Too many CTAs above fold | Rule 5 — one primary CTA on mobile |
| WhatsApp on landline | Rule 3 — mobile numbers only |
| Cache not clearing | Open in incognito OR vercel --prod --force |
| Site123 images empty | JavaScript-rendered — use Gemini generation |
| Vercel changes not showing | Run `vercel --prod --force` then curl confirm 200 |
| Files go to Documents | Max's downloads save to Documents not Downloads folder |
| Google Reviews broken link | Use: https://search.google.com/local/reviews?placeid=[ID] |
| Scroll bounce animation | Remove parallax — use IntersectionObserver opacity only |
| QA script macOS grep -P | Use grep -E instead — macOS doesn't support PCRE grep |
| Firecrawl wrong business | Stop build — flag to Max — never use niche defaults silently |
| Plain CSS gradient hero | Not acceptable — must have real image with gradient overlay |
| Icon-only service cards | Not acceptable — must have image + name + description |
| AI-generated team photos | Not acceptable — real photos only or skip section |
| Gemini image generation | Currently returning 404 on all models — diagnostic needed |
| Single Tally form for all | Go-live requires creating new dedicated Tally form per client |
| Star SVGs bloating HTML | Use HTML entities only — never SVG stars |

---

## 13. CURRENT TO-DO LIST

### 🔴 Critical — Before Sending Any Demo
- [ ] Fix Gemini image generation (all model endpoints returning 404)
- [ ] Visual QA confirmation on drsonday.vercel.app on phone
- [ ] Prove locked components system works in a fresh build

### 🟡 Important — This Week
- [ ] Run Dr. Sonday proof rebuild from scratch with locked components at position 1
- [ ] Run first new niche build (plumber) to prove system generalises
- [ ] Set up payment collection method (EFT with invoice recommended for now)
- [ ] Create separate Tally form per client at go-live
- [ ] Set up prospect-tracker.md
- [ ] Set up build-history.md

### 🟢 Next Phase — V2
- [ ] First paying client confirmed (Team24 pending)
- [ ] Client onboarding process documented
- [ ] Make.com wired to Tally form submissions
- [ ] Analytics component on all demo sites
- [ ] Sitemap.xml + robots.txt generation
- [ ] Railway cloud deployment setup

### 🔵 Ongoing
- [ ] Update MASTER_BRIEF after every major session
- [ ] Commit all skill updates to GitHub
- [ ] Rotate Vercel token regularly
- [ ] Keep client-index.md updated

### 📅 Reminder
- Gemini API free credits expire June 14, 2026. Evaluate paid tier or alternative by mid-April.

---

## 14. MONTHLY COSTS

| Item | Cost |
|------|------|
| Claude Max | $100/mo |
| Gemini API | ~$0.15/site ($300 free until June 14 2026) |
| Vercel | Free |
| GitHub | Free |
| Make.com | Free tier |
| Tally.so | Free (100 submissions/mo — upgrade needed at ~10 active clients) |
| Railway (V3) | ~$5/mo |
| **Total now** | **~$100/mo** |

---

## 15. BUSINESS WRAPPER DOCUMENTS

All built and committed to `~/agency-templates/`:

| Document | Location | Purpose |
|----------|----------|---------|
| WhatsApp first touch | outreach/whatsapp-first-touch.md | 2 variants (has site / no site) |
| Email first touch | outreach/email-first-touch.md | 2 variants with subject lines |
| Follow-up sequence | outreach/follow-up-sequence.md | Day 1, 3, 7, 14 cadence |
| Client handoff email | outreach/client-handoff.md | Sent when site goes live |
| Packages | 7thsense-system/PACKAGES.md | Full deliverables all tiers |
| Go-live checklist | 7thsense-system/GO-LIVE-CHECKLIST.md | Domain → DNS → live |
| Contract template | 7thsense-system/CONTRACT-TEMPLATE.md | One-page SA agreement |
| Visual pre-send checklist | 7thsense-system/VISUAL-PRE-SEND-CHECKLIST.md | 10-point phone check |

### Tally Form Notification Flow
| Phase | Notifications go to | Why |
|-------|---------------------|-----|
| Demo (pre-payment) | maxhurrellsa@gmail.com | Leads on demos are sales signals for Max |
| Go-live (post-payment) | Client's email only | Handoff moment — client owns lead flow |
| Go-live process | Create NEW dedicated Tally form per client | Prevents cross-contamination between clients |

---

## 16. ROADMAP

### V1 (Current)
- Manual triggering via Claude Code on Mac
- Two terminal workflow — build + strategy
- All core skills, rules, and locked components active
- Business wrapper documents complete

### V2 (Target: This Week)
- First paying client
- Make.com + Tally.so fully wired
- Proof build confirming locked components work
- Outreach started on new niches

### V3 (Target: ~4 weeks)
- Railway cloud orchestration
- Agents run while Mac is off
- Milestone summaries to Max

### V4 (Target: ~6 weeks)
- Custom dashboard
- Voice morning briefing (Vapi.ai)
- Full separation of agent roles

---

## 17. STARTING A NEW SESSION

### For strategy (Tab 1 — Pipeline):
```
Activate agents: c-level, business-growth, marketing, engineering, product, project-management
Read skills: 7thsense-niche-intelligence, 7thsense-systems-architect, 7thsense-visual-system, 7thsense-copy-architect, 7thsense-image-agent, page-cro, seo-technical, ui-ux-pro-max
```

### For a new client build (Tab 2 — Execution):
```
Read CLAUDE.md. Read skills in order: 7thsense-locked-components, 7thsense-niche-intelligence, 7thsense-systems-architect, 7thsense-visual-system, 7thsense-copy-architect, 7thsense-image-agent, ui-ux-pro-max, page-cro, seo-technical.

Fill niche config: cp ~/agency-templates/7thsense-system/niche-config-template.json ./[client]-config.json
Validate: bash ~/agency-templates/7thsense-system/scripts/validate-niche-config.sh
Then build.
```
