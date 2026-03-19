# 7thsense Prospecting V2 — Council Output
## Strategic Intelligence Upgrade — 2026-03-19

---

## Q1 — SIGNAL INTELLIGENCE UPGRADE
### Top 10 New Signals We Are NOT Currently Detecting

| Rank | Signal | Predictive Value | How to Detect | Why It Matters |
|------|--------|-----------------|---------------|----------------|
| 1 | **Google Ads → weak landing page** | 10/10 | Search "[niche] [city]" in incognito, click "Sponsored" results, assess landing page. Cross-ref Google Ads Transparency Center (adstransparency.google.com). | They are ALREADY PAYING for traffic. Every bounce is rands burned. This is the single highest-value signal. They believe in paying for leads — they just need the conversion layer. |
| 2 | **Facebook/Meta Ads → no website** | 9/10 | facebook.com/ads/library — search business name. Check where ads direct traffic (Instagram DMs, weak page, Facebook profile). | Same logic as Google Ads. They're spending money on eyeballs that have nowhere to convert. |
| 3 | **Negative reviews mentioning access friction** | 9/10 | Search "[business] reviews" on Google. Filter for 1-3 star reviews containing: "couldn't book", "hard to find", "no answer", "website down", "couldn't get through", "no online booking". | These are PATIENTS telling the practice they lost them. The pain is documented by the customer themselves. Practice owners read these and feel it. |
| 4 | **Job postings (hiring receptionist/office manager)** | 8/10 | Search Indeed.co.za, PNet, LinkedIn Jobs: "[business name]" OR "[niche] [area]". Hiring a receptionist = growing practice = budget available = values operations. | Hiring signals two things: they have money, and they're scaling. A practice investing in staff is psychologically primed to invest in systems. |
| 5 | **Recently opened / new practitioner joined** | 8/10 | Google Maps → filter "recently opened". Check GBP post history for "welcome Dr [Name]" or "now offering [new service]". LinkedIn for "[niche] [city]" with "started new position" in last 90 days. | New practices need patients NOW. New associates need to fill their chairs. Urgency is real and time-bound. |
| 6 | **Competitor launched new site** | 7/10 | Firecrawl the top 5 competitors in the prospect's area. If any competitor has a modern, conversion-optimised site and the prospect doesn't — the gap is visible to every patient. | Competitive pressure creates urgency they can feel. "Your competitor down the road just launched this" is a wake-up call. |
| 7 | **Active Instagram, no website link in bio** | 7/10 | Check prospect's Instagram profile. If bio link is missing, goes to a Linktree, or goes to a Facebook page — no website. They're investing time in content but have no conversion endpoint. | They already value marketing. They're doing the hard part (creating content) but missing the easy part (somewhere to send people). Easiest objection to overcome. |
| 8 | **Seasonal timing** | 7/10 | Calendar-based: Dental peaks before school holidays (March, June, Sep, Dec). Aesthetics peaks before summer (Sep-Nov) and wedding season (Oct-Mar). Law has no strong seasonality but tax/financial year end drives business law. | Timing the outreach to 4-6 weeks BEFORE peak season means the site goes live right when they need it most. "Your busiest quarter starts in 6 weeks" creates natural urgency. |
| 9 | **Domain expiring within 90 days** | 6/10 | `whois [domain]` — check expiry date. Domains expiring within 90 days = either they forgot, or they're considering letting it go. Either way, it's an opening. | Domain expiry is a concrete, date-stamped problem. "Your domain expires on [date]" is inarguable. |
| 10 | **Google Business Profile posts stopped** | 6/10 | Check GBP listing for "Updates" tab. If last post was 6+ months ago — they tried digital marketing and stopped. They know they should be doing it but don't have bandwidth. | They've already been sold on digital. Something blocked them (time, cost, complexity). We remove the blocker. |

### Signal Detection Priority Matrix

```
TIER 1 — BUILD DEMO IMMEDIATELY (Score 5):
  - Running ads + weak/no landing page
  - Negative reviews citing access problems + weak/no site

TIER 2 — BUILD DEMO THIS WEEK (Score 4):
  - Strong reviews + no website
  - Active Instagram + no website link
  - Recently opened / new practitioner
  - Hiring staff (receptionist/office manager)

TIER 3 — ADD TO PIPELINE (Score 3):
  - Competitor just upgraded + prospect hasn't
  - Seasonal peak approaching + weak site
  - Domain expiring soon
  - GBP posts stopped (tried and gave up)
```

---

## Q2 — PROSPECTING CHANNELS UPGRADE
### Top 5 New Channels (Ranked by Signal-to-Noise Ratio)

| Rank | Channel | S/N Ratio | How to Access | Expected Yield | Implementation |
|------|---------|-----------|---------------|----------------|----------------|
| 1 | **Google Ads Transparency Center** | 9/10 | adstransparency.google.com — search by business name or browse by topic/region. Free, no login required. | Every business found here is ACTIVELY SPENDING MONEY on ads. Cross-reference with Firecrawl site quality check = instant CRITICAL signal. | `curl` the transparency page or manual browse. Script: search "[niche] cape town", extract advertiser names, Firecrawl their sites, score. |
| 2 | **Facebook Ad Library** | 8/10 | facebook.com/ads/library — search by business name, filter by region (South Africa), filter by active ads. Free, no login required. | Same as above — active ad spend = proven budget. Check where ads send traffic. If it's Instagram DMs or a weak page = HIGH signal. | Manual check per prospect. Can batch-search a list of business names. |
| 3 | **Job Boards (Indeed.co.za + PNet)** | 7/10 | Search: "receptionist" + "[city/area]" + "[niche]". Or search the practice name directly. | Hiring = growing = budget available. A practice that just posted for a receptionist is investing in growth RIGHT NOW. | Script: weekly search for "[niche] receptionist [city]" on Indeed RSS feed. Flag any business that overlaps with our prospect list. |
| 4 | **HPCSA Register + Dental Board SA** | 7/10 | hpcsa.co.za — public practitioner register. Search by practice type + province. Cross-reference with Google Maps to find practices with registered practitioners but no/weak websites. | Official, verified list of every registered dental practice, doctor, physio etc. in SA. Zero noise — every result is a potential prospect. | Scrape or manual search the register. Cross-ref each name against Google Maps listing quality. |
| 5 | **Hellopeter** | 6/10 | hellopeter.com — search business name or browse by category. South Africa's main review/complaint platform. | Businesses with complaints about "hard to reach", "no response", "website doesn't work" are advertising their own pain publicly. | Search "[niche] [city]" on Hellopeter. Filter for complaints mentioning access/booking/website issues. These are pre-qualified prospects. |

### Channels We Should NOT Prioritise (Low S/N)
- **Gumtree/Facebook Marketplace** — too noisy, mostly service-seekers not businesses
- **Domain registration records** — new .co.za registrations are mostly speculators, not practices
- **Local Facebook groups** — time-intensive to monitor, low yield

---

## Q3 — UPDATED SCORING MODEL
### Complete Prospect Scoring Matrix (Updated from V1)

**Current model scores 1-10 on website quality. New model scores 1-25 across 5 dimensions.**

| Dimension | Weight | 1 (Low) | 3 (Medium) | 5 (High) |
|-----------|--------|---------|------------|----------|
| **PAIN** | Core | Minor site gaps | Weak site, no form, poor mobile | Running ads to broken page OR no site + strong reviews |
| **URGENCY** | Core | No time pressure | Seasonal peak in 8+ weeks, GBP posts stopped | Active ad spend wasting daily, domain expiring, competitor just launched, hiring staff |
| **ACCESSIBILITY** | Core | Corporate/franchise, gatekeeper | Front desk, owner reachable | Owner-operated, WhatsApp/mobile visible, responds on social |
| **CONVERTIBILITY** | Core | Good existing site | Mediocre site, needs ROI argument | No site at all OR terrible site — demo is obviously better |
| **BUDGET SIGNAL** | NEW | No revenue signals | Stable practice, some indicators | Running ads, hiring staff, multiple practitioners, premium services listed |

### New Dimension: BUDGET SIGNAL (1-5)
This is the missing predictor. A practice can have a terrible website but no money. These indicators separate "needs help" from "can pay for help":

| Score | Signal | Detection |
|-------|--------|-----------|
| 5 | Running Google/Meta ads (proven ad budget) | Ads Transparency Center + Ad Library |
| 5 | Multiple practitioners listed (high-revenue practice) | Google Maps listing, website team page |
| 4 | Hiring staff (investing in growth) | Indeed, PNet, LinkedIn Jobs |
| 4 | Premium services listed (implants, orthodontics, cosmetic) | Firecrawl service page, Google Maps services |
| 3 | Recently renovated/new equipment (CEREC, BIOLASE, etc.) | Website mentions, Google Maps photos |
| 3 | Active on social media (investing time in marketing) | Instagram/Facebook activity check |
| 2 | Solo practitioner, basic services | Limited signals |
| 1 | No online signals of revenue/growth | Nothing found |

### Scoring Thresholds (Updated)
| Total (out of 25) | Priority | Action |
|--------------------|----------|--------|
| 20-25 | **PRIORITY** | Build demo immediately. Max does personal outreach. |
| 15-19 | **HIGH** | Build demo this week. Outreach from Max or Tristan. |
| 10-14 | **MEDIUM** | Pipeline. Build when capacity allows. |
| Below 10 | **PASS** | Not worth pursuing now. Revisit if signals change. |

### Example Re-Score: Werner Joubert Dental
| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Pain | 4 | 5.0 stars, services page 500 error, no form, no phone on mobile |
| Urgency | 2 | Steady practice, no acute trigger detected |
| Accessibility | 5 | Owner-operated, phone + email verified, solo decision maker |
| Convertibility | 4 | Current site objectively terrible — demo clearly better |
| Budget Signal | 3 | Uses CEREC + BIOLASE (premium equipment), solo practitioner |
| **TOTAL** | **18** | **HIGH — demo built, outreach in progress** |

---

## Q4 — NICHE EXPANSION MAP
### Top 5 Niches Beyond Dental (Cape Town)

| Rank | Niche | Deal Value | Accessibility | Site Gap | Volume | Likelihood to Pay | Total /25 |
|------|-------|-----------|---------------|----------|--------|-------------------|-----------|
| 1 | **Aesthetics / MedSpa** | 5 | 4 | 5 | 4 | 5 | **23** |
| 2 | **Physiotherapy** | 3 | 5 | 5 | 5 | 4 | **22** |
| 3 | **Veterinary** | 3 | 4 | 5 | 4 | 4 | **20** |
| 4 | **Law (personal injury, family, immigration)** | 5 | 3 | 4 | 3 | 4 | **19** |
| 5 | **Optometry** | 3 | 4 | 4 | 4 | 3 | **18** |

### Why These, Specifically

**1. Aesthetics / MedSpa (Score 23)**
- Deal value is HIGH — average client spends R3,000-R8,000/year, recurring
- Sites are almost universally terrible — most are Instagram-only or template garbage
- Owner-operated or small team — decision maker reachable
- Extremely image-conscious — a premium demo creates immediate desire
- Already spending on marketing (Instagram content, influencers) — have budget
- Cape Town has 100+ medspas/aesthetics clinics
- **Niche skill exists:** `7thsense-niche-aesthetics`

**2. Physiotherapy (Score 22)**
- MASSIVE volume in Cape Town — 300+ practices across all suburbs
- Almost all have terrible websites or none at all — biggest gap in healthcare
- Solo practitioners or small groups — owner picks up the phone
- Medical aid payments mean stable revenue — they can afford R5-9K
- Referral-dependent currently — website would be new patient channel
- **Niche skill needed:** build before targeting

**3. Veterinary (Score 20)**
- High emotional spending — pet owners pay premium for perceived quality
- Strong Google presence (people search "vet near me" in emergencies)
- Most vet sites are 2015-era WordPress templates
- Small teams, owner-vets make decisions quickly
- 80+ vet practices in Cape Town metro
- **Niche skill needed:** build before targeting

**4. Law (Score 19)**
- Highest deal value per client (R15,000-R100,000+ per case)
- BUT decision makers are harder to reach — firms have gatekeepers
- Site quality varies widely — some are good, many are generic
- Smaller firm count in Cape Town vs dental/physio
- **Niche skill exists:** `7thsense-niche-law`

**5. Optometry (Score 18)**
- Consistent volume — 150+ practices across Cape Town
- Almost all have generic sites or are listed under a chain brand
- Independent optometrists are accessible decision makers
- Moderate deal value — frame around lifetime patient value
- **Niche skill needed:** build before targeting

---

## Q5 — AUTOMATION BLUEPRINT

### What Gets Automated

| Task | Status | Tool | Script Needed |
|------|--------|------|---------------|
| Google Maps scanning (extract top 20 listings) | **BUILD** | Google Maps API + bash | `scan-maps.sh "[niche]" "[city]"` |
| Website quality scoring (per listing) | **BUILD** | Firecrawl + bash | `score-site.sh [domain]` |
| Ad spend detection (Google) | **MANUAL** | Google Ads Transparency Center | Manual check — no API available |
| Ad spend detection (Meta) | **MANUAL** | Facebook Ad Library | Manual check — no reliable API |
| Contact enrichment | **EXISTS** | `enrich-lead.sh` | Already built |
| Domain/technical qualification | **EXISTS** | `qualify-prospect.sh` | Already built |
| Google Places data (rating, reviews, Place ID) | **EXISTS** | Google Maps API | Built into `enrich-lead.sh` |
| Prospect scoring (5 dimensions) | **BUILD** | bash | `score-prospect.sh [domain] "[name]"` |
| Weekly pipeline scan (new listings) | **BUILD** | cron + bash | `weekly-scan.sh` → runs Monday 7am |
| Seasonal urgency flags | **BUILD** | date check in scoring | Built into `score-prospect.sh` |

### What Stays Human (Tristan)

| Task | Why Human |
|------|-----------|
| Choosing who to contact first | Requires judgment about timing, relationship, energy |
| Writing personalised first message | Must reference specific insight about THEIR business |
| WhatsApp conversation | Real-time adaptation, reading tone, knowing when to push/pull |
| Checking Instagram/Facebook for activity signals | Requires qualitative judgment (are they actually active?) |
| Reviewing negative reviews for pain language | Needs interpretation, not just keyword matching |
| Deciding when to follow up vs let it rest | Relationship management |

### New Scripts to Build (Priority Order)

```
1. scan-maps.sh "[niche]" "[city]" "[suburb]"
   → Uses Google Maps API to extract top 20 listings (4.0+ rating)
   → For each: name, rating, review_count, website, phone, place_id
   → Outputs TSV for easy Sheet import

2. score-site.sh [domain]
   → Firecrawl scrape → check: mobile viewport, forms, tel: links,
     WhatsApp links, chat widgets, page speed, SSL, meta tags
   → Output: site quality score 1-10 with breakdown

3. score-prospect.sh [domain] "[name]"
   → Combines qualify-prospect + enrich-lead + site scoring
   → Adds budget signal detection (premium services, multiple practitioners)
   → Outputs full 25-point score with dimension breakdown
   → Flags PRIORITY / HIGH / MEDIUM / PASS

4. weekly-scan.sh
   → Runs scan-maps for each target niche+area combo
   → Diffs against previous week's scan (new listings, changed ratings)
   → Outputs "NEW THIS WEEK" report
   → Cron: every Monday 7am SAST
```

---

## Q6 — THE HORMOZI LENS

### Who Is the Starving Crowd?

**Generic answer (wrong):** "Service businesses with bad websites"

**Specific answer (right):** A solo or small-group dental/aesthetics/physio practice owner in Cape Town's Northern or Southern Suburbs who:
- Has 20+ Google reviews (4.0+ stars) — word of mouth is working
- Has NO website or a visibly broken/outdated one — the conversion layer is missing
- Is owner-operated or the owner is the lead practitioner — they answer their own phone
- Has been in practice 3+ years — established revenue, can afford R5-9K without blinking
- Is NOT part of a franchise or corporate chain — they make their own decisions
- Shows at least one growth signal: hiring, new equipment, expanded hours, running ads, active on Instagram

**This person is starving because:** They are doing the hard work (great service, earning reviews, maybe even running ads) but the easy part (a website that converts) is the thing they haven't done. They know they should. They just haven't gotten around to it, or they got burned by a developer once, or their nephew said he'd do it and never did.

### Value Equation Applied

```
Dream Outcome: Full waiting room. New patients every week without chasing them.
  → MAXIMISE: frame everything around patients, not pages

Perceived Likelihood: VERY HIGH
  → We show them a demo built with THEIR data, THEIR reviews, THEIR brand
  → It's not theoretical — they can see it working
  → MAXIMISE: demo is the proof

Time Delay: NEAR ZERO
  → Demo in 24 hours. Live in 5 days. First new patient within 30 days.
  → MINIMISE: speed is our structural advantage over every other agency

Effort & Sacrifice: ZERO
  → We handle domain, DNS, hosting, content, images, go-live
  → They approve. That's it. They do nothing technical.
  → MINIMISE: "you do literally nothing except say yes"
```

### How This Changes Who We Target

**Stop targeting:**
- Businesses with decent websites (convertibility too low)
- Corporate/franchise practices (can't reach decision maker)
- Practices with no online presence at all (no Google reviews = no trust signal = harder ROI argument)

**Double down on:**
- Practices with 20+ reviews AND no/terrible website (the gap is the opportunity)
- Practices actively running ads to weak pages (the waste is quantifiable)
- Practices where the owner IS the practitioner (fastest decision cycle)

### How This Changes How We Find Them

**Old way:** "Let me scan Google Maps and see who has a bad website"
**New way:** "Let me find who is ALREADY SPENDING MONEY (ads, hiring, equipment) but LOSING MONEY on their web presence — then calculate exactly how much"

The signal hierarchy shifts from:
```
OLD: bad website → check reviews → maybe reach out
NEW: proven budget signal → quantified pain → demo as proof → zero-risk offer
```

---

## Q7 — THIS WEEK'S 3 QUICK WINS

### Quick Win 1: Google Ads Transparency Scan (30 minutes, today)
**What:** Go to adstransparency.google.com. Search "dentist" + "Cape Town". Also search "dental implants Cape Town", "emergency dentist Cape Town". Write down every advertiser name.
**Then:** For each advertiser, open their website on mobile. Score 1-5 (form? phone visible? mobile responsive? fast?). Any advertiser scoring 3 or below = CRITICAL prospect.
**Expected yield:** 3-5 CRITICAL prospects who are burning money right now.
**Output:** Add to prospect sheet with signal tag "ADS_TO_WEAK_PAGE".

### Quick Win 2: Negative Review Mining (45 minutes, today)
**What:** For the top 20 dental practices in Northern Suburbs (from existing Maps data), read their 1-3 star Google reviews. Search for keywords: "website", "book", "couldn't get through", "no answer", "hard to find", "online", "after hours".
**Then:** Any practice with 2+ reviews mentioning access friction = score +2 on Urgency dimension. These patients have already documented the problem for you.
**Why it's fast:** You already have the business list. This is just reading reviews with a specific filter.
**Output:** Updated Urgency scores + specific review quotes to use in outreach ("Your patient Sarah said she couldn't book online — we fix that").

### Quick Win 3: Build `score-prospect.sh` (2 hours, tomorrow)
**What:** Combine `qualify-prospect.sh` + `enrich-lead.sh` + new site quality checks into a single script that outputs the full 25-point score.
**Input:** Domain + business name
**Output:**
```
PROSPECT SCORE: Werner Joubert Dental
═══════════════════════════════════════
Pain:           4/5  (broken services page, no form, no mobile phone)
Urgency:        2/5  (no acute trigger)
Accessibility:  5/5  (owner-operated, phone verified)
Convertibility: 4/5  (demo clearly superior)
Budget Signal:  3/5  (premium equipment, solo practice)
═══════════════════════════════════════
TOTAL:          18/25 — HIGH PRIORITY
ACTION:         Demo built. Outreach in progress.
```
**Why it matters:** Every future prospect gets scored consistently. No more gut feel. Tristan sees the number and knows exactly who to call first.

---

## IMPLEMENTATION TIMELINE

| Day | Action | Owner |
|-----|--------|-------|
| Today (Wed) | Google Ads Transparency scan — find CRITICAL prospects | Max |
| Today (Wed) | Negative review mining — top 20 practices | Max |
| Tomorrow (Thu) | Build `score-prospect.sh` | Max + Claude |
| Friday | Run full score on all existing + new prospects | Max |
| Friday | Tristan gets ranked prospect list with scores | Tristan |
| Next Monday | `weekly-scan.sh` first run — new listings report | Automated |
| Next week | Expand to aesthetics niche (skill exists, ready to go) | Max |

---

## KEY INSIGHT

**The single biggest upgrade is not finding MORE prospects. It's finding prospects with BUDGET SIGNALS.**

A practice with a terrible website but no money is a waste of a demo. A practice with a mediocre website but active Google Ads spend, a hiring post on Indeed, and three CEREC machines is the prospect who pays R9K without blinking.

The budget signal dimension is the missing predictor. Add it to every score. Prioritise by it. Let Tristan focus his time on prospects who have proven they spend money on growth.

---

*Generated by 7thsense Council — Strategic Intelligence, Signal Detection, Opportunity Scanner, ROI Calculator, Hormozi Offer Architecture*
*Date: 2026-03-19*
