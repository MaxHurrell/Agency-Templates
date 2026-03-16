# 7thsense — Master Brief v3
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
**First client:** Team24 (insurance broker, Kommetjie) — site live, feedback implemented, awaiting payment confirmation

---

## 2. LIVE DEMOS

| Client | Niche | URL | Status |
|--------|-------|-----|--------|
| Dr. Sonday Dentistry | Dental | dentist-pi-eight.vercel.app | ✅ Live |
| Team24 | Insurance Broker | team24-nine.vercel.app | ✅ Live — first potential client |

---

## 3. FULL INFRASTRUCTURE

### GitHub Repos
- `MaxHurrell/Agency-Templates` — master templates, skills, system files
- `MaxHurrell/client-sites` — individual client demos

### Vercel
- Each client gets own Vercel project with unique URL
- Automated via `deploy-client.sh` using VERCEL_TOKEN
- Deploy command: `cd ~/client-sites && ./deploy-client.sh [client-name]`

### Local Machine (MacBook Air M4)
- Claude Code v2.1.76
- Two terminal tab workflow:
  - Tab 1: Building tab — executes builds, deploys
  - Tab 2: Strategic council tab — strategy, planning, QA oversight

### API Keys (all in ~/.zshrc)
- GEMINI_API_KEY — Gemini image generation ($300 free credit, expires June 14 2026)
- VERCEL_TOKEN — Vercel deployments (rotate regularly, never expose in output)
- ANTHROPIC_API_KEY — Claude API

### MCP Servers Connected
- 21st.dev Magic MCP — premium UI components
- Firecrawl MCP — web scraping, brand extraction

---

## 4. THE BUILD SYSTEM (fully upgraded March 16)

### New Build Pipeline (mandatory for every build)
```
1. Fill niche config (~10 mins)
   cp ~/agency-templates/7thsense-system/niche-config-template.json ./[client]-config.json
   
2. Validate config (instant)
   bash ~/agency-templates/7thsense-system/scripts/validate-niche-config.sh ./[client]-config.json

3. Build from config (15-20 mins)
   Claude Code reads config + all skills + builds site

4. QA check (instant)
   bash ~/agency-templates/7thsense-system/scripts/qa-pre-deploy.sh ./index.html ./[client]-config.json

5. Deploy (2 mins)
   ./deploy-client.sh [client-name]
   curl confirm 200
```

### System Files Location
```
~/agency-templates/7thsense-system/
├── niche-config-template.json    # Blank config — copy for every new build
├── BUILD-PROCESS.md              # Step-by-step build workflow
├── examples/
│   ├── niche-config-dentist.json
│   └── niche-config-insurance.json
├── scripts/
│   ├── validate-niche-config.sh  # Pre-build validator
│   └── qa-pre-deploy.sh          # Pre-deploy QA (207 lines, 7 categories)
└── components/
    └── hero-overlay.css          # Mandatory hero text contrast component
```

### Hero Overlay Component (mandatory on every desktop hero)
```css
.hero {
  background: linear-gradient(
    to right,
    rgba(0,0,0,0.75) 0%,
    rgba(0,0,0,0.75) 45%,
    rgba(0,0,0,0.20) 100%
  ), url('hero.png') center/cover no-repeat;
}
.hero h1, .hero-sub { text-shadow: 0 2px 8px rgba(0,0,0,0.5); }
```

---

## 5. SKILLS INSTALLED (~115+ in ~/.claude/skills/)

### Custom 7thsense Skills (5)
- `7thsense-systems-architect` — technical blueprint before any build
- `7thsense-visual-system` — CSS variables, font decisions, 4-step colour extraction
- `7thsense-copy-architect` — conversion copy, 6-word headlines, SA market rules
- `7thsense-image-agent` — image sourcing priority: Firecrawl → Gemini → Unsplash
- `7thsense-niche-intelligence` — niche research, design decisions document, uniqueness guarantee

### Skill Reading Order (every new build)
1. 7thsense-niche-intelligence — research + design decisions document FIRST
2. 7thsense-systems-architect — technical blueprint
3. 7thsense-visual-system — design tokens before code
4. 7thsense-copy-architect — copy before layout
5. 7thsense-image-agent — images before final build
6. ui-ux-pro-max — international UX standards
7. bencium-innovative-ux-designer — distinctive design
8. page-cro — conversion pass
9. seo-technical — SEO pass

### Agents Installed (11 in ~/.claude/agents/)
business-growth, c-level, engineering, engineering-team, finance, marketing, personas, product, project-management, ra-qm-team

### Strategic Council Activation
For strategy sessions, open Tab 2 and run:
```
Activate the c-level, business-growth, and marketing agent personas. Read ~/.claude/agents/c-level.md, ~/.claude/agents/business-growth.md, ~/.claude/agents/marketing.md. Act as unified strategic council for 7thsense.
```

---

## 6. CLAUDE.md OPERATING CONTRACT

Location: `~/.claude/CLAUDE.md` (global) and `~/agency-templates/CLAUDE.md` (GitHub)

### 15 Hard Rules (never violate)
1. Never use brand colour as full section background outside the hero
2. Never use Playfair Display or ornate serif fonts
3. Never include WhatsApp for a landline number
4. Never commit invented statistics or unverified claims
5. Never have more than one primary CTA above fold on mobile
6. Never commit without running pre-commit QA checklist
7. Never use Unsplash without checking for real client images first via Firecrawl
8. Never use niche default colours without first trying Firecrawl CSS AND Gemini Vision extraction
9. Never use lorem ipsum — always realistic dummy content
10. Never skip the pre-build checklist
11. Never expose API keys or tokens in any output or command echo
12. Design uniqueness: niche research must drive structural decisions, never copy previous build layout
13. Image generation: every image specifically prompted for exact section — never generic "lounge" or unrelated scene
14. Image extraction: always attempt Firecrawl first, flag if JavaScript-rendered, fall back to Gemini with precise prompts
15. Hero text contrast: directional gradient overlay on desktop, text-shadow on all hero elements, use hero-overlay.css component

### Build Checklist (mandatory before coding)
- [ ] Fill niche config JSON
- [ ] Run validate-niche-config.sh
- [ ] Read all 9 skills in order
- [ ] Produce Design Decisions Document
- [ ] Extract brand colours via 4-step cascade

### Pre-Commit QA (mandatory before every commit)
- [ ] Run qa-pre-deploy.sh — zero errors required
- [ ] Colour rules pass
- [ ] Typography rules pass
- [ ] Mobile rules pass
- [ ] Content verified — zero invented facts
- [ ] Spacing rules pass
- [ ] Technical rules pass
- [ ] Hero overlay component applied
- [ ] Curl confirm 200 after deploy

---

## 7. DESIGN RULES

### Colour Usage
- Brand primary: hero background, buttons, badges, accents, icons ONLY
- All content sections: white, cream, or light grey backgrounds
- Footer: dark charcoal — never brand primary
- WhatsApp button: always #25D366

### Typography
- Approved fonts: DM Sans, Syne, Outfit, Plus Jakarta Sans, Urbanist, Satoshi, Cabinet Grotesk, General Sans
- BANNED: Playfair Display, all ornate serifs
- Max 2 font families per site

### Mobile
- Floating bar: max 2 buttons
- WhatsApp only if mobile number confirmed
- One CTA above fold only
- All tap targets min 48px

### Spacing
- Desktop sections: max 96px padding
- Mobile sections: max 64px padding
- Zero dead space between sections
- Hero content within 60px of navbar desktop, 40px mobile

### Images
Priority: Firecrawl real images → Gemini API generated → Unsplash last resort
- Gemini prompts must include: niche + specific service + SA/Cape Town context + brand colour mood
- Hero: practice/business environment, never a random lounge
- Services: show the actual service being performed
- Team: professional headshots, SA-specific context

### Google Reviews
- Always use real Google SVG logo (G:#4285F4, o:#EA4335, o:#FBBC05, g:#4285F4, l:#34A853, e:#EA4335)
- Never plain text "Google"
- Link format: https://search.google.com/local/reviews?placeid=[REAL_PLACE_ID]

---

## 8. CLIENT FEEDBACK INTERPRETATION RULES

When receiving client feedback:
1. Interpret intent not just literal request — scan entire site for all related instances
2. Scan before changing — read full file first
3. Consistency check — apply change everywhere it logically applies
4. Never break what works — copy changes only touch text, never CSS/HTML structure
5. Report all changes including ones not explicitly requested

---

## 9. NICHE DIFFERENTIATION SYSTEM

### 8 Differentiation Levers
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

### CTA Text by Niche
- Dental: "Book Appointment"
- Insurance: "Get a Free Quote"
- Plumbing: "Call Now" or "Get Emergency Help"
- Legal: "Free Consultation"
- Medical: "Book Appointment"
- Beauty: "Book Now"
- Cleaning: "Get a Free Quote"

---

## 10. PRICING

| Package | Price |
|---------|-------|
| Starter site | R7,500 |
| Growth site | R12,500 |
| Full system | R18,500 |
| Monthly retainer | R2,500/mo |

---

## 11. VERIFIED CLIENT DATA

### Dr. Sonday Dentistry
- Phone: 021 783 0024
- WhatsApp: 064 944 7759 (mobile — WhatsApp applicable)
- Email: docsonday12@gmail.com
- Address: Flat 1, 18 Gemini Way, Ocean View, Cape Town, 7975
- Hours: Mon-Fri 08:30-17:00, Sat 08:00-12:30
- Google Place ID: ChIJZ61zaEFrzB0RqVIYufiLzY8
- Reviews URL: https://search.google.com/local/reviews?placeid=ChIJZ61zaEFrzB0RqVIYufiLzY8
- Real reviews: Clare Bowen, Savannah Finlay, Fatima Rawoot, Shelley Bright, Patsy Hamilton
- Medical aids: Discovery, Gems, Bonitas, Medihelp, Keyhealth, Medshield, Momentum, Fedhealth
- Team: Dr. Shabier Sonday, Harriet Lamb, Lungelwa, Zee

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
| Green section backgrounds | Rule 1 in CLAUDE.md — accent only outside hero |
| Hero text unreadable | Use hero-overlay.css component — rule 15 |
| Too many CTAs above fold | Rule 5 — one primary CTA on mobile |
| WhatsApp on landline | Rule 3 — mobile numbers only |
| Cache not clearing | Open in private/incognito tab OR force deploy with --force flag |
| Site123 images empty | JavaScript-rendered — Firecrawl can't extract, use Gemini generation |
| Vercel changes not showing | Run `vercel --prod --force` then curl confirm 200 |
| Files go to Documents | Max's downloads save to Documents not Downloads folder |
| Google Reviews broken link | Use: https://search.google.com/local/reviews?placeid=[ID] |
| Dr. Sonday Place ID | ChIJZ61zaEFrzB0RqVIYufiLzY8 |
| Scroll bounce animation | Remove parallax — use IntersectionObserver opacity only |
| 4 buttons above fold | Max 2 in floating bar + 1 in hero on mobile |

---

## 13. IMMEDIATE TO-DO LIST

### 🔴 Critical — Fix Before More Demos
- [ ] Wire Tally.so contact forms — demos currently have non-functional forms
- [ ] Fix Google rating accuracy — dentist shows 5.0/47 reviews, real count is 13
- [ ] AI image SA diversity — Gemini defaults to Western imagery, need explicit SA context in all prompts
- [ ] Verify all review counts match real Google data before any demo goes live

### 🟡 Important — This Week
- [ ] Test full new build pipeline on plumber niche (first fully system-governed build)
- [ ] Add Google Analytics/PostHog to all demo sites
- [ ] Add sitemap.xml and robots.txt generation to build process
- [ ] Add unique meta descriptions verified per site
- [ ] Performance check — Lighthouse 90+ mobile before deploy
- [ ] Build GP/Medical template
- [ ] Wire Make.com to handle form submissions

### 🟢 Next Phase — V2
- [ ] Unique Vercel project automation fully tested
- [ ] Client onboarding process documented
- [ ] Outreach message templates written
- [ ] First paying client confirmed (Team24 pending)
- [ ] Railway cloud deployment setup
- [ ] Nano Banana integration for automated image generation

### 🔵 Ongoing
- [ ] Update master brief after every major session
- [ ] Commit all skill updates to GitHub
- [ ] Rotate Vercel token regularly
- [ ] Keep client-index.md updated with all demos

---

## 14. MONTHLY COSTS

| Item | Cost |
|------|------|
| Claude Max | $100/mo |
| Gemini API | ~$0.15/site ($300 free until June 14 2026) |
| Vercel | Free |
| GitHub | Free |
| Make.com | Free tier |
| Tally.so | Free |
| Railway (V3) | ~$5/mo |
| **Total now** | **~$100/mo** |

---

## 15. ROADMAP

### V1 (Current)
- Manual triggering via Claude Code on Mac
- Two terminal workflow — build + strategy
- All core skills and rules active

### V2 (Target: This Week)
- Make.com + Tally.so fully wired
- Unique Vercel URL per client automated
- Full offer defined and outreach ready
- First paying client

### V3 (Target: ~4 weeks)
- Railway cloud orchestration
- Agents run while Mac is off
- Milestone summaries to Max

### V4 (Target: ~6 weeks)
- Custom dashboard
- Voice morning briefing (Vapi.ai)
- Full separation of agent roles

---

## 16. WHATSAPP AS LEAD NURTURE

Every demo site has WhatsApp integration. This enables:
- Instant first contact, no form friction
- Auto-reply for after hours
- Make.com follow-up sequences
- Appointment reminders
- Post-appointment review requests
- Missed call → auto WhatsApp response

**Sales framing:** "Your website now has a WhatsApp button. Every person who clicks it is a warm lead. We can set up automated follow-ups, appointment reminders, and review requests — all on WhatsApp automatically. That's the difference between a website and a customer capture system."

---

## 17. STARTING A NEW SESSION

### For building:
Open Claude Code, navigate to project directory, paste relevant command.

### For strategy:
Open second Terminal tab (Cmd+T), type `claude`, activate strategic council:
```
Activate the c-level, business-growth, and marketing agent personas. Read ~/.claude/agents/c-level.md, ~/.claude/agents/business-growth.md, ~/.claude/agents/marketing.md. Act as unified strategic council for 7thsense.
```

### For a new client build:
```
Read CLAUDE.md. Read skills in order: 7thsense-niche-intelligence, 7thsense-systems-architect, 7thsense-visual-system, 7thsense-copy-architect, 7thsense-image-agent, ui-ux-pro-max, page-cro, seo-technical.

Fill niche config: cp ~/agency-templates/7thsense-system/niche-config-template.json ./[client]-config.json
Validate: bash ~/agency-templates/7thsense-system/scripts/validate-niche-config.sh ./[client]-config.json
Then build.
```
