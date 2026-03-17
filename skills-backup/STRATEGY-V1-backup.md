# 7thsense — STRATEGY V1
## The Full Business Model, Client Profile, and Path to Revenue
*Created: March 17, 2026*
*Author: Strategic Intelligence Agent*
*Source of truth: MASTER_BRIEF.md, BRAIN.md, OFFERS.md, SIGNAL-DETECTION.md, PACKAGES.md*
*Rule 43: This document was written from source files, never from memory.*

---

## SECTION 1 — WHAT 7THSENSE ACTUALLY SELLS

### The one-line truth
**7thsense is a customer acquisition system for service businesses.** The website is the entry point — not the product.

### Why this matters
A dentist doesn't need a website. A dentist needs more patients in the chair. A lawyer doesn't need a website. A lawyer needs more consultations booked. The website is the engine — but the system around it is what makes the phone ring.

### The Full System — 6 Components

#### 1. Conversion-Optimised Website
**Problem it solves:** The business is invisible online, or visible but not converting visitors into calls/bookings.
**Monthly value to business:** 3-6 new patients/month × R6,700 LTV = R20,100-R40,200 in lifetime value
**Our cost to deliver:** ~2 hours build time (Claude Code), R0 hosting (Vercel free tier)
**What we charge:** R7,500-R18,500 once-off depending on scope
**Status:** OPERATIONAL — locked components, 3 niches proven, QA automated

#### 2. Google Reviews Growth System
**Problem it solves:** Practice has happy patients but few reviews. Low review count kills trust for new searchers. Competitors with more reviews win the click.
**How it works:** After each patient visit, an automated WhatsApp message goes out: "Hi [Name], thanks for visiting Dr [X] today. If you had a good experience, we'd really appreciate a quick Google review: [link]". Sent 2 hours post-appointment via Make.com webhook.
**Monthly value to business:** Each new review increases Google Maps visibility. 5 reviews/month over 6 months = 30 new reviews. Moving from 13 to 43 reviews increases Maps click-through by ~25%.
**Our cost to deliver:** Make.com free tier (100 operations/month) + WhatsApp Business API (~R200/month for message costs at volume)
**What we charge:** Included in Full System (R18,500) or R1,500/month add-on to lower tiers
**Status:** DESIGNED — needs Make.com + WhatsApp Business API integration (V2)

#### 3. Missed Call Text-Back
**Problem it solves:** Practice misses calls during procedures, lunch, or after hours. The patient calls the next listing. Gone forever.
**How it works:** When a call goes unanswered after 3 rings, an automated WhatsApp fires: "Hi, thanks for calling [Practice Name]. We missed your call — our team will call you back within 30 minutes. Or reply here to book." Uses Twilio or WhatsApp Business API.
**Monthly value to business:** Average dental practice misses 15-30% of calls. At 100 calls/month, that's 15-30 missed. Recovering even 5 = 5 × R6,700 LTV = R33,500 in lifetime value.
**Our cost to deliver:** Twilio/WhatsApp Business API ~R300/month
**What we charge:** R1,000/month add-on
**Status:** NOT BUILT — requires Twilio integration (V3)

#### 4. AI Chat Widget
**Problem it solves:** Visitors land on the site at 10pm with questions. No one answers. They leave.
**How it works:** Embedded chat widget trained on the practice's services, hours, location, and FAQ. Handles: "Do you accept Discovery medical aid?", "Are you open on Saturdays?", "How much do dental implants cost?". Escalates to WhatsApp or email for complex queries.
**Monthly value to business:** Captures after-hours enquiries (estimated 10-20% of all site visitors arrive outside business hours). Even converting 2 extra patients/month = R13,400 LTV.
**Our cost to deliver:** Claude API or open-source LLM, ~R150/month per client
**What we charge:** R1,500/month add-on or included in Premium retainer
**Status:** NOT BUILT — requires Claude API integration or third-party widget (V3)

#### 5. WhatsApp Automation Suite
**Problem it solves:** Patients book but don't show. Patients visit once but don't return. No systematic follow-up exists.
**How it works:**
- Appointment reminders: 24hr + 2hr before appointment
- Post-visit follow-up: "How was your visit?" + review request
- Re-engagement: 6-month checkup reminder for dental, 3-month touch-up reminder for aesthetics
- Birthday message with special offer
**Monthly value to business:** Reduces no-shows by 30-50% (industry data). At 10 no-shows/month reduced to 5, that's 5 recovered appointments × R800 average visit = R4,000/month directly.
**Our cost to deliver:** Make.com + WhatsApp Business API, ~R400/month at scale
**What we charge:** R1,500/month or included in Premium retainer (R3,500/month)
**Status:** NOT BUILT — requires Make.com + WhatsApp Business API (V2-V3)

#### 6. Monthly Reporting & Optimization
**Problem it solves:** Business owner has no idea if their website is working. Can't justify continued investment without data.
**How it works:** Monthly PDF report: visitor count, form submissions, call clicks, Google ranking for key terms, Lighthouse performance score, review count change. Delivered via email on the 1st of each month.
**Monthly value to business:** Visibility into what's working. Ability to make informed decisions. Keeps the retainer feeling valuable.
**Our cost to deliver:** ~30 minutes/month per client (automate with Plausible + script)
**What we charge:** Included in retainer (R2,500/month)
**Status:** PARTIALLY BUILT — Tally tracks form submissions, need Plausible/GA4 integration

### The System Stack Summary

| Component | Status | Revenue Model | Priority |
|-----------|--------|---------------|----------|
| Website | Operational | R7,500-R18,500 once-off | NOW |
| Reviews Growth | Designed | R1,500/mo add-on | V2 |
| Missed Call Text-Back | Not built | R1,000/mo add-on | V3 |
| AI Chat Widget | Not built | R1,500/mo add-on | V3 |
| WhatsApp Automation | Not built | R1,500/mo add-on | V2-V3 |
| Monthly Reporting | Partially built | Included in retainer | V2 |

### Revenue model at maturity (per client)
- Once-off website: R12,500 (average)
- Monthly retainer: R2,500/month (baseline)
- Add-ons: R1,000-R4,500/month additional
- **Total client value year 1:** R12,500 + (R2,500 × 12) = **R42,500**
- **With add-ons:** R12,500 + (R5,000 × 12) = **R72,500**

---

## SECTION 2 — THE PERFECT CLIENT PROFILE

### Dental (Primary Niche — Cape Town)

| Attribute | Ideal | Acceptable | Walk Away |
|-----------|-------|------------|-----------|
| **Size** | Solo dentist or 2-dentist practice | Small group (3-4 dentists) | Large franchise (DecisionPath too long) |
| **Revenue** | R80K-R300K/month | R50K-R80K/month | Under R50K (can't afford us, won't see ROI fast enough) |
| **Google reviews** | 10-50 reviews, 4.0+ stars | 5-10 reviews | 0 reviews (no demand signal) |
| **Current site** | No site OR outdated site (pre-2020) | Basic but functional site | Premium agency site (we can't compete visually) |
| **Decision maker** | Owner-dentist | Practice manager with budget authority | Committee or franchise HQ |
| **Time to decision** | Same week | 2 weeks | "Let me think about it for a month" |
| **Location** | Cape Town Southern Suburbs, Northern Suburbs, CBD | Greater Cape Town | Other provinces (can't do in-person if needed) |

**Pain points ranked:**
1. "I know my website is bad but I don't know where to start"
2. "Patients tell me they couldn't find me online"
3. "My competitor down the road just got a new website"
4. "I'm paying for Google Ads but not getting bookings"
5. "I don't have time to deal with a web designer"

**Easy to close:** Owner-operator who has seen a competitor's new site and feels embarrassed. Already knows they have a problem. The demo is the answer to a question they've been asking.

**Hard to close:** "My nephew is building me a site" or "I've been meaning to get around to it" — no urgency, no pain.

**Good retainer client:** 2+ dentists (enough volume to justify ongoing optimisation), accepts multiple medical aids (broader patient base), actively growing (opening Saturday hours, adding services).

### Aesthetics (Expansion Niche — Miami / Cape Town)

| Attribute | Ideal |
|-----------|-------|
| **Size** | Solo practitioner or boutique medspa (1-3 practitioners) |
| **Revenue** | $30K-$150K/month |
| **Google reviews** | 50+ reviews (aesthetics clients review aggressively) |
| **Current site** | Template site (Wix/Squarespace) that doesn't match their Instagram quality |
| **Decision maker** | Owner-practitioner or practice manager |
| **Location** | Miami Beach, Brickell, Coral Gables (high-competition, high-value) |

**Unique pain:** The gap between their Instagram presence and their website. Patients see beautiful work on Instagram, click to the website, and it looks like a different business.

### Law (Expansion Niche — Miami)

| Attribute | Ideal |
|-----------|-------|
| **Size** | Solo attorney or small firm (2-5 attorneys) |
| **Revenue** | $50K-$300K/month |
| **Google reviews** | 20+ reviews |
| **Current site** | WordPress template from 2015-2018, no clear CTA, weak mobile |
| **Decision maker** | Named partner |
| **Unique pain:** Spending $5K-$20K/month on Google Ads with weak conversion |

### THE IDEAL FIRST CLIENT — RIGHT NOW

**Niche:** Dental
**Location:** Cape Town — Bellville, Durbanville, Northern Suburbs, or Southern Suburbs
**Profile:** Owner-dentist, solo or 2-dentist practice, 10-50 Google reviews at 4.0+ stars, has a website that is either broken or embarrassingly outdated, ideally spending on Google Ads

**Why dental, why Cape Town, why now:**
1. We have a proven dental template (Dr. Sonday) — build time is under 2 hours
2. Dental LTV in SA (R6,700) makes the ROI argument undeniable at R7,500
3. Cape Town is Max's market — he can do in-person meetings if needed
4. The niche skill is the most deeply researched and battle-tested
5. Dental practices have simple decision-making — one dentist says yes, we're in

**First prospect identified:** Werner Joubert Dental, Bellville (prospect package already written)

---

## SECTION 3 — GENIUS SIGNAL DETECTION

### The 8 Signals — Ranked by Actionability

#### Signal 1: Running Google Ads to a Weak Landing Page
**Score: 5/5 CRITICAL — Quantifiable waste**
**Detection:** Search "dentist [area]" in incognito → note Sponsored results → click through → score landing page (form? CTA? mobile? photos? reviews badge?)
**Monthly cost to business:** Spend × 67% waste rate. At R6,000/month spend = R4,020/month wasted.
**Opening line:** "I noticed you're running Google Ads for 'dentist Bellville'. I checked your landing page — I think roughly 60% of those clicks are bouncing because the page doesn't make it easy to book. That's potentially R4,000/month in wasted ad spend."

#### Signal 2: High Reviews, No Website
**Score: 4/5 HIGH — Proof of demand + proof of gap**
**Detection:** Google Maps → "dentist [area]" → check each listing's website field → if empty or links to Facebook = prospect
**Monthly cost:** (Review count × 50 impressions) × 5% CTR × 15% conversion gap × R6,700 LTV
**Opening line:** "Dr [Name], you have [X] five-star reviews — your patients clearly rate you. But when someone Googles you, there's no website. They book somewhere else."

#### Signal 3: High Reviews, Broken/Outdated Website
**Score: 4/5 HIGH — Gap between reputation and presence**
**Detection:** Google Maps → click website link → Firecrawl scrape → check: mobile responsive? Contact form? Load speed? Design age?
**Monthly cost:** Visitors × conversion gap × LTV. At 150 visitors/month and 3% gap = 4.5 missed patients × R6,700 = R30,150/month
**Opening line:** "Your patients love you — [rating] stars from [count] reviews. But your website doesn't reflect that quality. I built what it should look like."

#### Signal 4: Low Review Count Despite Being Established
**Score: 3/5 MEDIUM — Trust deficit**
**Detection:** Google Maps → check listing age (photos dated 3+ years) vs review count. Established practice with <10 reviews = review gap.
**Monthly cost:** Patients choosing competitors with 50+ reviews instead. Hard to quantify but real. Each lost patient = R6,700 LTV.
**Opening line:** "You've been practicing for [X] years but only have [Y] Google reviews. Your competitors have 40-80. Every patient who compares listings picks the one with more reviews. We can fix that."

#### Signal 5: Missed Calls (Estimated from Public Data)
**Score: 3/5 MEDIUM — Hidden revenue leak**
**Detection:** Call the practice at lunch (12:30-13:30) and after hours (17:30). If it rings out or goes to generic voicemail = missed call problem. Also check if Google Maps shows "Hours: Mon-Fri 8-5" (no Saturdays = missing Saturday searchers).
**Monthly cost:** 15-30% of calls missed × 100 calls/month = 15-30 missed × even 10% conversion = 1.5-3 lost patients × R6,700 = R10,050-R20,100/month
**Opening line:** "I called your practice at [time] and it went to voicemail. If that's happening to patients, every missed call is potentially a R6,700 patient who calls the next listing."

#### Signal 6: Active Social Media But No Website
**Score: 3/5 MEDIUM — Engagement without conversion**
**Detection:** Search "[practice name]" → if Instagram/Facebook is top result, not a .co.za → no website. Also check if Instagram bio links to appointment booking.
**Monthly cost:** Social followers who search Google and find nothing. Hard to quantify, but the effort they put into social proves they want to grow.
**Opening line:** "Your Instagram is great — [X] followers, regular posts. But people who search Google for a dentist in [area] can't find you. Here's what they should see."

#### Signal 7: Recently Opened Practice (< 2 Years)
**Score: 2/5 MEDIUM-LOW — Growth mindset, tight budget**
**Detection:** Google Maps → check "Opened in [year]" tag, or few reviews with recent dates. Also check SA dental board registration date.
**Monthly cost:** Every month without a proper online presence is a month of lost establishment. For new practices, the first 100 patients define survival.
**Opening line:** "Congrats on the new practice. The first 6 months are make or break for patient acquisition. I can have your online presence live this week."
**Caution:** New practices may have tight budgets. Offer A (risk reversal) is essential — don't push for Full System.

#### Signal 8: Recent Unresponded Bad Review
**Score: 2/5 LOW — Reputation vulnerability**
**Detection:** Google Maps → sort reviews by "Newest" → if a 1-2 star review from the last 30 days has no owner response = vulnerability.
**Monthly cost:** One bad unresponded review can drop conversion by 10-20%. For a practice getting 200 visitors/month, that's 20-40 lost visitors × conversion rate.
**Opening line:** "I noticed a recent review that hasn't been responded to. I know that's stressful. A professional online presence with a visible 4.8+ rating helps counterbalance it. I built a site that leads with your best reviews."
**Caution:** Sensitive topic. Lead with empathy, not with the problem.

### Detection Workflow (Batch Process)

```
For each target area (e.g., "dentist Durbanville"):
1. Google Search (incognito): note Sponsored results → scrape landing pages → score
2. Google Maps: list all practices → check website field → check review count/rating
3. Firecrawl: scrape each website → JSON extract: form? CTA? mobile? photos?
4. Score each practice 1-10 on landing page quality
5. Calculate monthly cost of problem for top 5 weakest
6. Rank by: signal score × monthly cost × estimated close probability
7. Build demo for #1 ranked prospect
8. Prepare outreach package
```

---

## SECTION 4 — PACKAGING AND PRICING

### Honest Evaluation of Current Packages

| Package | Price | Verdict |
|---------|-------|---------|
| Starter R7,500 | Correctly priced for the Cape Town market. A solo dentist doing R100K/month can justify this — two new patients and it's paid for itself. The demo-first model removes all risk. | KEEP |
| Growth R12,500 | The gap from Starter is R5,000. For that, they get analytics, AI images, sitemap, extra sections, 2 revision rounds. This is where most prospects should land — but the value justification needs work. The guarantee (Offer B) is what makes this tier compelling. | KEEP — bundle with 90-Day Guarantee |
| Full System R18,500 | The jump from Growth is R6,000. Multi-page, Make.com automation, WhatsApp Business, review requests, 3 months analytics. This is strong — but the automation components aren't built yet. Don't sell what we can't deliver. | KEEP — but only sell once automation is live |
| Retainer R2,500/mo | Correctly priced. At 10 clients, that's R25,000/month recurring. The retainer must become the real business — once-off builds are cash flow, retainers are the business. | KEEP — make it stickier |

### Pricing Justifications (One-Line Each)

- **Starter R7,500:** "This costs R7,500 because two new patients (R13,400 in lifetime value) pay for it. Your site will be live within days, not weeks."
- **Growth R12,500:** "This costs R12,500 because it comes with a guarantee: 5 new enquiries in 90 days or I work free until you get them. That's R33,500 in lifetime patient value, guaranteed."
- **Full System R18,500:** "This costs R18,500 because it's not a website — it's a complete patient acquisition system: site, automated review requests, WhatsApp integration, and 3 months of tracked results."
- **Retainer R2,500/mo:** "This costs R2,500/month because it includes 4 content updates, performance monitoring, reporting, and priority support. One recovered patient per month from our ongoing work covers it 2.7x over."

### What Makes the Retainer Sticky

The retainer must include things the client can't easily replace if they leave:
1. **Monthly performance report** — they get used to seeing their numbers
2. **Google review monitoring** — alerts on new reviews, especially negative ones
3. **Quarterly design refresh** — new hero image keeps the site feeling current
4. **Uptime monitoring** — peace of mind they don't have to think about
5. **Priority support** — "just WhatsApp Max" becomes their normal
6. **Accumulated SEO value** — the site gains Google authority over time, which is lost if they switch to a new domain

### Upsell Path (when they say "just the website")

```
Website only (Starter)
  → Month 1: "Here's your first month report — X visitors, Y calls"
  → Month 2: "You've gotten Z form submissions. Want me to set up review requests?"
  → Month 3: "Your reviews went from 13 to 21. Retainer would keep this growing."
  → Month 4-6: Review growth + reporting = retainer justified
  → Month 6+: "Your site is ranking for [keyword]. Let's add missed call text-back."
```

Never sell the full system day one to a cold prospect. Earn the right to upsell by proving results.

### Revenue Share Option (High-Value Clients)

For established practices doing 20+ patients/month:
- Zero upfront build
- R500/new patient above their current monthly baseline
- Verified via form submissions (Tally tracks source)
- 24-month cap, then the system is theirs
- Only offer after trust is established (Offer C in progression)

---

## SECTION 5 — THE PATH TO FIRST REVENUE

### The Single Fastest Path

**Target:** Close Team24 (the existing warm prospect) OR close 1 of 5 new Cape Town dental prospects within 7 days.

**Why Team24 first:** The demo is already built and live. Anthea has seen it. There is no build time required — only closing.

### Exact Steps — This Week

| Day | Action | Owner | Output |
|-----|--------|-------|--------|
| **Today** | Message Anthea (Team24) — direct, warm follow-up | Max | "Hi Anthea, the site is ready and live. Shall we do a 5-min call to walk through it?" |
| **Today** | Verify Werner Joubert Dental on Google Maps | Max (phone) | Confirmed rating, review count, Google Place ID |
| **Today** | Build Werner Joubert demo | Claude Code | Live URL at wernerjoubert.vercel.app |
| **Day 2** | Max sends Werner Joubert WhatsApp (from prospect package) | Max | First touch sent |
| **Day 2** | Identify 4 more Cape Town dental prospects using signal detection | Claude Code | 4 ranked prospects with scores |
| **Day 3** | Build demo #2 for highest-scored prospect | Claude Code | Live URL |
| **Day 3** | Send outreach #2 | Max | Second prospect contacted |
| **Day 4-5** | Build demos #3 and #4 | Claude Code | Two more live demos |
| **Day 5** | Send outreach #3 and #4 | Max | Four prospects contacted |
| **Day 6-7** | Follow-up sequence begins for all contacted | Max | Day 2 follow-ups |

### Realistic Conversion Math

| Metric | Number | Source |
|--------|--------|--------|
| Demos sent | 5 | This week's target |
| Expected reply rate (WhatsApp) | 40-60% | Industry for personalised cold outreach with proof |
| Expected positive interest | 2-3 of 5 | Demo removes most objections |
| Expected to book call | 1-2 of 5 | Some will ghost or delay |
| Expected to close | 1 of 5 | 20% cold close rate with demo-first + risk reversal |
| **Revenue from 1 close** | **R7,500** (Starter) to **R12,500** (Growth) |
| **Time to payment** | 50% on approval = R3,750-R6,250 within 7-10 days |

If Team24 closes independently, that's additional — potentially R7,500-R12,500 within days.

### Tristan's Role

If Tristan (Max's contact/collaborator) is involved in outreach:

**Brief him on:**
1. **Never lead with "we build websites."** Always lead with the problem: "I noticed your site doesn't have a booking form. At R30/click on Google Ads, that's costing you."
2. **Always have the demo URL ready** before contacting anyone. Never pitch without proof.
3. **The only ask is a 5-minute call.** Not a text conversation, not an email chain. A call.
4. **Never mention pricing in the first message.** The demo does the selling. Pricing comes on the call.
5. **If they ask price:** "Two new patients and it pays for itself. Can I call you for 5 minutes to give you the full picture?"

### The Three Most Likely Objections

| Objection | Response | Why This Works |
|-----------|----------|----------------|
| **"I already have a website"** | "You do — and I took a look. Your services page [is broken / doesn't have a booking form / isn't mobile-friendly]. I built what it should look like. Takes 30 seconds to compare." | Acknowledges their site, shows you've done research, redirects to the demo |
| **"How much does this cost?"** | "Two new patients and it pays for itself. But it depends on what you need — can I call you for 5 minutes?" | Frames price as ROI, deflects to a call where you can read their level of interest |
| **"I don't need a new website"** | "That's fair. But can I ask — how many enquiries are you getting through your current site per month? If the answer is less than 5, there might be R30K+ in lifetime patient value sitting on the table." | Pivots from their assumption (I'm fine) to a question that makes them think |

### What "Done" Looks Like

**This week (7 days):**
- Team24 follow-up sent ✓
- Werner Joubert demo built and outreach sent
- 3-4 additional dental prospects identified, demos built, outreach sent
- At least one positive response received
- One call booked

**This month (30 days):**
- First payment received (R3,750-R6,250 deposit)
- First site live on client's domain
- 8-10 total demos sent
- 2-3 clients closed
- Monthly recurring pipeline started (at least 1 retainer conversation)

---

## SECTION 6 — THE GENIUS GROWTH MODEL

### The Flywheel

```
Find prospect with quantifiable problem
        ↓
Build demo using their real data (< 2 hours)
        ↓
Send demo + problem brief → they see proof
        ↓
Close → deliver → site goes live
        ↓
Site generates leads → client sees ROI
        ↓
Client gives testimonial + referral
        ↓
Testimonial becomes proof for next prospect ←──╮
        ↓                                       │
Retainer keeps client active                    │
        ↓                                       │
Monthly report shows continued ROI              │
        ↓                                       │
Client refers colleague in same niche ──────────╯
```

**Each client makes the next one easier because:**
1. We can say "Dr [Name] in [area] saw [X] new enquiries in the first month"
2. We have a live URL to show — "here's what we built for a practice like yours"
3. The niche template is already proven — build time drops with each build
4. Word of mouth in professional communities (dental, legal) is powerful — dentists talk to dentists

### Using Client Results as Proof

After first client launches:
- Track form submissions for 30 days
- Create a one-line result: "Dr Werner Joubert Dental: 8 new patient enquiries in the first month through the new site"
- Add to outreach messages: "We recently launched a site for a Bellville dental practice — they received 8 new enquiries in the first month"
- Screenshot the Tally dashboard as visual proof

### Systems Required at Each Stage

| Clients | Systems Needed | Monthly Revenue |
|---------|----------------|-----------------|
| **1-3** | Manual everything. Max + Claude Code. WhatsApp outreach. EFT payments. | R7,500-R37,500 once-off + R2,500-R7,500/mo retainer |
| **3-5** | Need: invoice template, prospect-tracker.md, build-history.md, dedicated Tally forms per client | R25,000-R62,500 once-off + R7,500-R12,500/mo |
| **5-10** | Need: Make.com automation (form notifications, review requests), CRM (even a spreadsheet), monthly report template | R12,500-R25,000/mo retainer |
| **10-20** | Need: Tristan or VA handling outreach, Max on calls only. Railway cloud for overnight builds. Client dashboard. | R25,000-R50,000/mo retainer |
| **20-30** | Need: Full automation. Vapi for voice briefings. Tristan as full-time sales. Max as strategic only. | R50,000-R75,000/mo retainer |

### When Automation Justifies Its Cost

| Tool | Monthly Cost | Justifies at | What It Replaces |
|------|-------------|-------------|------------------|
| Make.com Pro | R600/month | 3 clients | Manual form notification routing, manual review requests |
| WhatsApp Business API | R200/month base + per message | 3 clients | Manual follow-up messages |
| Plausible Analytics | R70/month | 5 clients | Manual traffic checking via Vercel dashboard |
| Railway | R100/month | 5 clients | Claude Code must run on Max's Mac |
| Tally Pro | R250/month | 10 clients | 100 submission limit on free tier |

**Rule: Don't spend on automation until the manual version is working and the revenue justifies it.**

### The R50K/Month Recurring Picture

| Metric | Value |
|--------|-------|
| Active retainer clients | 20 |
| Average retainer | R2,500/month |
| Monthly recurring | R50,000 |
| New builds per month | 2-3 |
| Once-off revenue per month | R15,000-R37,500 |
| **Total monthly revenue** | **R65,000-R87,500** |
| Monthly costs | ~R5,000 (tools + APIs) |
| **Net monthly** | **R60,000-R82,500** |
| Time to reach | 6-9 months from first client at current trajectory |

### The Single Most Important Metric

**Weekly demos sent.**

Not revenue. Not clients. Not retainers. Demos sent.

Because:
- Demos sent × 20% close rate = clients
- Clients × R10,000 average deal = revenue
- Revenue > costs = business

If Max sends 5 demos/week, that's ~1 new client/week. At ~4 clients/month, the R50K/month retainer target is reachable in 5 months.

**Track every Friday:** How many demos did we send this week?

---

## SECTION 7 — IF THEY DON'T WANT A WEBSITE

### Scenario A: "I already have a website"

**Response:** "Great — mind if I take a quick look? I audit sites for service businesses and I might spot something that's costing you patients."

**Action:** Scrape their site with Firecrawl. Score it on the 10-point scale. If it scores below 6:
- Prepare a 3-bullet audit: "Your site is missing [X], [Y], and [Z]. Based on your traffic, this is likely costing you [number] patients/month."
- Offer: "I can rebuild it for you using your existing content and brand — same data, better conversion. Here's what it would look like: [demo URL]"

**Minimum viable offer:** R5,000 "Landing Page Optimisation" — we rebuild their homepage only as a high-converting landing page while keeping their existing site structure. Gets us in the door.

**Path to full system:** Once the landing page is live and generating more enquiries than their old homepage, they'll want the full rebuild. "The landing page is working — want me to do the rest of the site? I can have it ready in a week."

### Scenario B: "I don't need a website"

**Response:** "That's fine — a website isn't for everyone. Can I ask though: how are patients finding you right now?"

If the answer is "word of mouth / Google Maps / Facebook":
- "Your Google Maps listing is your website right now. Can I help you optimise that? Better photos, more reviews, accurate hours — it's the single most impactful thing you can do for free."
- Offer: Google Business Profile optimisation — R2,500 once-off. We update photos, write the business description, add all services, ensure hours are accurate, and set up a review request system.

**Path to full system:** Once they see review growth and Maps ranking improvement, the conversation naturally becomes: "Now imagine a website that captures all those people who find you on Maps and click through."

### Scenario C: "My nephew is building me a website"

**Response:** "Go for it — I'm sure he'll do a good job. Can I leave you the demo I built anyway? It's at [URL] — if things don't work out or you want a second opinion later, it'll still be there."

**Action:** No pressure. The demo stays live. Follow up in 30 days: "How's the site coming along? Let me know if I can help."

**Why this works:** 70% of "my nephew" websites never get finished or look terrible. By not pushing, you become the trusted alternative when it falls through.

### Scenario D: "I just want more Google reviews"

**Response:** "I can help with exactly that. We set up an automated system that sends a WhatsApp to every patient after their visit asking for a review. Most practices see 5-10 new reviews per month."

**Offer:** R1,500/month — Google Reviews Growth System (standalone, no website required)
- Make.com automation
- WhatsApp message templates
- Monthly review count report

**Path to full system:** "Your reviews went from 15 to 45 in 3 months. But when those patients click through to your site... let me show you what they see versus what they should see."

### The Universal Rule

**Never argue. Never push. Show the demo, state the cost of the problem, and let the math do the work. If they're not ready today, they will be when the nephew's site doesn't materialise or when their competitor's new site starts stealing patients.**

---

## APPENDIX — KEY NUMBERS TO MEMORISE

| Metric | Value | Use In |
|--------|-------|--------|
| Dental patient LTV (SA) | R6,700 | Every pitch |
| Dental CPC Cape Town | R15-R50/click | Ads waste calculation |
| Bad landing page waste rate | 67% | Ads waste calculation |
| Average practice visitors/month | 100-300 | Conversion gap calculation |
| Conversion rate (weak site) | 1% | Gap calculation |
| Conversion rate (optimised site) | 3-5% | Gap calculation |
| Missed call rate (average practice) | 15-30% | Missed call pitch |
| Review impact on click-through | +25% from 13→43 reviews | Review growth pitch |
| Time to build demo | < 2 hours | Capacity planning |
| Demo to close rate | 20% (1 in 5) | Pipeline planning |
| Weekly demos target | 5 | The one metric |
