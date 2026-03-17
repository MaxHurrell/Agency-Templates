# 7thsense — Strategy V2 Innovations
## Domain Decisions, GBP Playbook, Automation Stack, Package Evolution
*Created: March 17, 2026*
*Source: Full council session — c-level, business-growth, marketing, engineering, product, project-management, strategic-intelligence*
*Rule 43: Written from STRATEGY-V1.md, BRAIN.md, MASTER_BRIEF.md, DOMAIN-PLAYBOOK.md, web research*

---

## OUTPUT 1 — DOMAIN DECISION FRAMEWORK

### The Decision Tree

```
CLIENT APPROVES DEMO
        ↓
"Do you have an existing domain?"
        ↓
    YES ──────────────────────── NO → Scenario 5 (new domain, Max registers)
        ↓
"Do you want to keep it?"
        ↓
    YES ──── Follow DOMAIN-PLAYBOOK.md scenarios 1-4, 6-8
        ↓
    NO / UNSURE → EVALUATE:
        ↓
    ┌─────────────────────────────────────────┐
    │ WHEN A NEW DOMAIN IS ACTUALLY BETTER:   │
    │                                         │
    │ ✓ Old domain has penalty/spam history   │
    │ ✓ Domain is hard to spell/remember      │
    │ ✓ Domain doesn't match business name    │
    │ ✓ Old agency holds domain hostage       │
    │ ✓ Client is rebranding anyway           │
    │ ✓ Domain recovery will take 2+ weeks    │
    │   and client wants to launch NOW        │
    └─────────────────────────────────────────┘
        ↓
    If ANY of these are true → recommend new domain
    If NONE → recommend keeping existing domain
```

### The "New Domain Advantage" Pitch

When a client is stuck in a domain dispute or has a bad domain, turn it into an opportunity:

"Your old domain has been attached to an outdated site for years. Starting fresh gives us a clean slate — no baggage, no SEO penalties from the old site, and a domain that actually matches how patients search for you. Most of your traffic comes from Google Maps anyway, not people typing your domain directly. We update your Google Business Profile to the new domain and within 2-3 weeks, Google treats it as your primary web presence."

### GBP Connection for Both Paths

**Path A — Keeping existing domain:**
1. Update DNS to point to Vercel (per DOMAIN-PLAYBOOK.md)
2. GBP website URL stays the same — no GBP changes needed
3. Google re-crawls and picks up new site automatically within 3-7 days

**Path B — New domain:**
1. Register new domain, deploy site
2. Log into Google Business Profile → Info → Website → update URL to new domain
3. Google re-crawls within 24-72 hours
4. If old domain had Search Console data: add new domain to Search Console, submit Change of Address (Settings → Change of Address → select old property → confirm new)
5. Set up 301 redirect from old domain to new domain (if old domain is accessible)
6. Google transfers ~90% of link authority within 2-4 weeks via the Change of Address signal

### SEO Recovery Timeline (New Domain)

| Period | What Happens | Action Required |
|--------|-------------|-----------------|
| Day 1-7 | Google discovers new domain via GBP link and crawl | Submit sitemap in Search Console, request indexing |
| Week 2-4 | New pages indexed, GBP shows new URL in search | Monitor Search Console for coverage errors |
| Month 1-3 | Domain authority builds, local pack rankings stabilise | Publish 1-2 blog posts per month, build local citations |
| Month 3-6 | Full recovery to previous ranking levels (or better) | Continue citation building, review growth |

**Key insight:** For local service businesses, 70-80% of discovery happens via Google Maps, not organic search. Updating the GBP website URL is the single most impactful action. The domain itself matters less than the GBP connection.

---

## OUTPUT 2 — GOOGLE BUSINESS PROFILE PLAYBOOK

### A. Connecting the New Website to GBP

**Who does this:** Ideally the client (they're logged into their Google account). Max walks them through it via screen share or sends step-by-step instructions.

**Exact process:**
1. Go to business.google.com
2. Select the business
3. Click "Edit profile" (pencil icon)
4. Under "Contact" → find "Website" field
5. Replace old URL with new production domain (https://clientdomain.com)
6. Click Save
7. Changes appear in Google Search within 24-72 hours

**If Max needs to do it:** Client adds maxhurrellsa@gmail.com as a Manager on their GBP (Managers can edit but can't delete the listing or remove the owner).

### B. GBP Recovery Scenarios

**Scenario B1 — Client lost access to the Google account that owns the GBP**
1. Try account recovery at accounts.google.com/signin/recovery
2. If recovery email/phone still works → reset password → done
3. If not → go to business.google.com → find the listing → click "Claim this business"
4. Google will attempt to reach the current owner (email, phone, postcard)
5. If no response after 7 days → Google grants access to the new claimer
6. Time: 7-21 days
7. Client language: "We need to recover your Google Business listing. I'll walk you through the process — Google gives you access within 1-3 weeks if the old account doesn't respond."

**Scenario B2 — Old agency controls the GBP**
1. Client contacts old agency: "Please transfer ownership of my Google Business Profile to [client's email]"
2. If cooperative: Agency goes to GBP → People → Add new owner → Transfer primary ownership
3. If uncooperative: Client claims the listing via business.google.com → "Request access" → enters their email → Google contacts current manager
4. If agency still blocks after 7 days: File a Google Business Profile appeal at support.google.com/business/contact
5. Nuclear option: If business can prove they are the legitimate business (utility bill, business registration), Google will override the old agency's claim
6. Time: 7-30 days
7. Client language: "Your old agency controls your Google listing. We need to transfer it to you. If they cooperate, it takes a day. If not, Google has a dispute process that takes 2-3 weeks."

**Scenario B3 — No GBP exists**
1. Go to business.google.com → Add your business
2. Enter business name, category, address
3. Choose verification method (usually postcard to business address — takes 5-14 days)
4. Alternative: video verification (show storefront, signage, mail with address) — instant to 3 days
5. Once verified: fill in ALL fields (see optimisation below)
6. Client language: "You don't have a Google Business listing yet. I'll set one up — it takes about a week for Google to verify."

### C. Fully Optimised GBP — The Standard

Every 7thsense client's GBP should have:

| Element | Standard | Why It Matters |
|---------|----------|----------------|
| Business name | Exact legal name (no keyword stuffing) | Google penalises stuffed names |
| Category | Primary + up to 9 secondary categories | Determines which searches you appear in |
| Description | 750 chars, keywords natural, services listed | Google uses this for relevance matching |
| Website URL | Production domain | Drives traffic to conversion-optimised site |
| Phone | Primary business number (tracked if possible) | Direct lead channel |
| Hours | Accurate, including special hours for holidays | Wrong hours = missed patients + bad reviews |
| Photos | 20+ high-quality photos (exterior, interior, team, services) | Listings with 100+ photos get 520% more calls (Google data) |
| Posts | 1 per week minimum (offers, updates, events) | Signals activity to Google, improves ranking |
| Q&A | Pre-populate 10-15 common questions with answers | Prevents competitors from posting misleading answers |
| Products/Services | Every service listed with description and price range | Appears in search results directly |
| Review responses | Every review responded to within 24 hours | Signals engagement, builds trust |
| Messaging | Enabled with auto-response | Captures leads who prefer messaging |

**Monthly GBP management value:**
- Dental practice: R3,000-R5,000/month in additional patient value from improved Maps visibility
- Aesthetics: $500-$1,000/month in additional bookings
- Law: $2,000-$5,000/month in additional consultations

### D. Google Reviews Automation System

**The problem:** Businesses know reviews matter but never systematically ask for them. The ask happens manually, inconsistently, or not at all.

**The solution: Automated post-visit review request**

**Recommended stack: Make.com + WhatsApp Business API (via WATI or 360dialog)**

**How it works:**
1. Client (receptionist) enters patient name + phone number into a simple Google Form or Tally form after each visit
2. Make.com watches the form for new entries
3. 2 hours after submission, Make.com triggers a WhatsApp message via WATI:
   "Hi [Name], thanks for visiting [Practice] today. If you had a good experience, a quick Google review would mean the world to us: [direct review link]"
4. The review link uses: `https://search.google.com/local/writereview?placeid=[PLACE_ID]`
5. One tap opens the Google review form — no searching required

**Cost to deliver:**
- Make.com: Free tier (100 ops/month) → enough for ~50 review requests/month
- WATI: ~$40/month (includes WhatsApp Business API access)
- Total: ~$40/month (~R750/month)

**What to charge:** R1,500/month as part of retainer OR included in Growth/Full System packages

**Revenue impact of reviews:**
- Going from 13 to 50 reviews: ~30% increase in Google Maps impressions
- Going from 4.2 to 4.8 stars: ~25% increase in click-through rate
- Combined: up to 60% more Maps-driven traffic
- For a dental practice: 60% more Maps traffic × current conversion rate = 3-5 additional patients/month × R6,700 LTV = R20,100-R33,500/month in patient lifetime value

**The one-number pitch:** "Every review you don't ask for costs you roughly R6,700 in lifetime patient value. We automate the ask so you don't have to think about it."

---

## OUTPUT 3 — AUTOMATION STACK RECOMMENDATION

### 1. Missed Call Text-Back

**Best tool: Make.com + Twilio (Voice) + WATI (WhatsApp)**

**How it works:**
1. Client's business phone is forwarded to a Twilio number after 3 rings (no answer)
2. Twilio fires a webhook to Make.com: "missed call from +27XXXXXXXXX"
3. Make.com triggers a WhatsApp message via WATI: "Hi, thanks for calling [Practice]. We missed your call — our team will call you back within 30 minutes. Reply here to book an appointment."
4. If the caller replies, the message goes to the client's WhatsApp Business inbox

| Metric | Value |
|--------|-------|
| Implementation complexity | 6/10 |
| Monthly cost to deliver | ~R600/month (Twilio ~R200 + WATI ~R400) |
| What to charge | R1,500/month |
| Margin | R900/month (60%) |
| Setup time | 2-3 hours per client |
| Client maintenance | Zero |

**One-number pitch:** "A missed call is a R6,700 patient calling your competitor. We text them back automatically before they hang up."

### 2. AI Chat Widget

**Best tool: Tidio (free tier) or Chatbase ($19/month)**

**Why Tidio for starters:** Free plan includes live chat + basic chatbot. Can be embedded on any static HTML site with a single `<script>` tag. Supports WhatsApp handoff. No ongoing maintenance after initial setup. Free for up to 50 conversations/month — enough for most small practices.

**Why Chatbase for custom AI:** $19/month gets you a GPT-powered chatbot trained on the client's specific data (services, prices, hours, FAQ). Upload the client's website content + a custom knowledge base. It answers questions accurately and hands off to WhatsApp or a form for booking.

| Metric | Tidio (Free) | Chatbase ($19/mo) |
|--------|-------------|-------------------|
| Implementation complexity | 3/10 | 5/10 |
| Monthly cost to deliver | R0 | ~R350/month |
| What to charge | Included in retainer | R1,000/month add-on |
| Training time per client | 30 mins | 1-2 hours |
| Client maintenance | Zero | Zero |
| AI quality | Basic rule-based | GPT-powered, contextual |

**What the bot needs per niche:**
- **Dental:** Operating hours, services offered, accepted medical aids, pricing ranges, emergency procedures, location/parking, booking process
- **Aesthetics:** Treatment menu, pricing, before/after expectations, consultation process, practitioner qualifications, aftercare
- **Law:** Practice areas, consultation fees, case assessment process, office locations, attorney credentials

**One-number pitch:** "Your website loses 80% of visitors in the first 30 seconds. A chat widget that answers their questions keeps them on the page and converts them into bookings."

### 3. WhatsApp Automation Suite

**Best tool: WATI ($40/month) + Make.com**

Suite includes:
- Appointment reminders (24hr + 2hr before)
- Post-visit follow-up ("How was your visit?")
- Review request (2hrs after visit)
- Re-engagement (6-month checkup reminder for dental, 3-month for aesthetics)
- Birthday message with offer

| Metric | Value |
|--------|-------|
| Implementation complexity | 7/10 (initial setup), 2/10 (per client after first) |
| Monthly cost to deliver | ~R750/month (WATI + Make.com Pro if needed) |
| What to charge | R2,000/month |
| Margin | R1,250/month (63%) |
| Setup time | 4-6 hours first client, 1-2 hours thereafter |
| Client maintenance | Zero after setup |

**One-number pitch:** "Every patient who doesn't come back for their 6-month checkup costs you R6,700 in lifetime value. We remind them automatically so you don't have to."

### 4. Google Reviews Growth

**Best tool: Make.com + WATI (same stack as above — bundled)**

Already detailed in Output 2 Section D. When sold alongside the WhatsApp Automation Suite, the marginal cost is zero (same WATI account, same Make.com scenarios).

| Metric | Value |
|--------|-------|
| Implementation complexity | 4/10 |
| Monthly cost to deliver | R0 incremental (bundled with WhatsApp suite) |
| What to charge | R1,000/month standalone OR included in WhatsApp suite |
| Setup time | 1 hour |
| Client maintenance | Receptionist enters patient name+phone after each visit |

**One-number pitch:** "Every month you don't ask for reviews, your competitor with 80 reviews gets the patient who searched Google. We make asking automatic."

### Automation Stack Summary

| Automation | Tool | Cost to Deliver | Charge Client | Margin |
|-----------|------|-----------------|---------------|--------|
| Missed Call Text-Back | Twilio + WATI + Make.com | R600/mo | R1,500/mo | R900 (60%) |
| AI Chat Widget | Tidio Free or Chatbase | R0-350/mo | Included or R1,000/mo | 65-100% |
| WhatsApp Suite | WATI + Make.com | R750/mo | R2,000/mo | R1,250 (63%) |
| Reviews Growth | Same stack (bundled) | R0 incremental | R1,000/mo or bundled | 100% |
| **Full Stack** | **All above** | **~R1,350/mo** | **R4,500/mo** | **R3,150 (70%)** |

---

## OUTPUT 4 — UPDATED PACKAGE STRUCTURE

### Revised Packages

| Package | Price | Website | GBP Setup | Reviews | Chat | Missed Calls | WhatsApp Suite | Monthly Report |
|---------|-------|---------|-----------|---------|------|-------------|----------------|----------------|
| **Starter** | R7,500 once + R2,500/mo retainer | Single-page, 8 sections, 1 revision | Basic (update URL only) | — | — | — | — | Basic (visitors + forms) |
| **Growth** | R12,500 once + R3,500/mo retainer | 12 sections, AI images, 2 revisions | Full optimisation | Reviews automation | Tidio Free chat | — | — | Full monthly report |
| **System** | R18,500 once + R5,000/mo retainer | Multi-page option, 3 revisions | Full optimisation + monthly management | Reviews automation | AI chat (Chatbase) | Missed call text-back | Full WhatsApp suite | Full report + quarterly strategy call |

### Why Each Tier Exists

**Starter (R7,500 + R2,500/mo):** "I just need a website that works." Client gets a premium site that looks better than their competitor's. Retainer keeps it updated and hosted. This is the entry point — most clients start here.

**Growth (R12,500 + R3,500/mo):** "I want more patients." Client gets the site PLUS the reviews engine and basic chat. The R1,000/mo increase over Starter buys them automated review growth — the single highest-ROI activity. This is the sweet spot for most clients.

**System (R18,500 + R5,000/mo):** "I want a complete patient acquisition machine." The full stack: site + GBP management + reviews + AI chat + missed call recovery + WhatsApp automation + reporting. For practices doing R150K+/month revenue where the R5,000/month retainer is trivially justified by 1 extra patient per month (R6,700 LTV). This is where 7thsense makes serious money.

### Mathematical Justification

**Starter client (12 months):** R7,500 + (R2,500 × 12) = **R37,500 LTV**
**Growth client (12 months):** R12,500 + (R3,500 × 12) = **R54,500 LTV**
**System client (12 months):** R18,500 + (R5,000 × 12) = **R78,500 LTV**

**Cost to deliver per client:**
- Starter: ~R100/year (domain) + R0 hosting = ~R8/month
- Growth: R100/year + WATI R750/month share = ~R800/month (margins: R2,700/month)
- System: R100/year + R1,350/month tools = ~R1,400/month (margins: R3,600/month)

**At 10 System clients:** R50,000/month recurring, R14,000/month in tool costs, **R36,000/month profit** — from a one-person agency using AI to deliver.

### Upgrade Path

Every client should be guided up the ladder:
1. **Sign at Starter** → after 60 days, propose Growth: "Your site is working — now let's grow your reviews."
2. **Growth for 90 days** → propose System: "You've gone from 15 to 40 reviews. Imagine if we captured every missed call too."
3. **System for 6 months** → propose Premium retainer with quarterly strategy sessions

---

## OUTPUT 5 — THE INNOVATION SUMMARY

### 5 Genuinely Innovative Ideas for 7thsense

**1. THE PROOF CALL**
Before sending any demo, Max calls the prospect's practice as a mystery shopper. If the call is missed or goes to voicemail, that becomes the opening line: "I called your practice at 12:30 today and it went to voicemail. If that happens to a patient, they call the next dentist. I built you a website that captures those missed calls automatically." This is not a pitch — it is proof of a problem they didn't know they had. No competitor is doing this.

**2. THE REVIEW VELOCITY GUARANTEE**
Instead of selling a website, sell a measurable outcome: "I guarantee 20 new Google reviews in 90 days or the review automation is free until you get there." This is a Hormozi-style offer applied to the most visible, verifiable metric in the business's online presence. The client can count their reviews themselves — there's nowhere to hide. And because review automation costs essentially nothing to deliver (Make.com free tier + shared WATI), the risk to Max is near zero.

**3. THE COMPETITOR COMPARISON SCREENSHOT**
For every demo, include a side-by-side: the prospect's current site (or lack thereof) on the left, the 7thsense demo on the right. But add a third column: their top local competitor's site. This reframes the conversation from "is this site good enough?" to "do I want to look worse than my competitor?" The answer is always no. Nobody else in Cape Town is doing competitive visual positioning as part of the pitch.

**4. THE "COST OF DOING NOTHING" INVOICE**
Instead of quoting what 7thsense costs, send a monthly "invoice" for what doing nothing costs: "Your practice is currently losing approximately R30,000/month in lifetime patient value from: 4 missed calls/day (R6,700 × 4 recovered = R26,800/mo), 3 review-driven patient losses/month (R20,100/mo), 15% website bounce rate above benchmark (R10,050/mo). Total monthly cost of inaction: R56,950. 7thsense costs R3,500/month." This flips the price conversation entirely. The prospect isn't spending R3,500/month — they're saving R53,450/month.

**5. THE GBP TAKEOVER AS LEAD MAGNET**
Offer free GBP audits to local businesses as a lead generation tool. Run a batch of 20 GBP audits per week (5 minutes each with a standardised checklist), send each business a one-page PDF: "Your Google Business Profile is missing X, Y, Z. This is costing you approximately N patients per month." Include a link to a Tally form: "Want us to fix it? Reply here." This creates warm leads who have already seen proof of a specific problem — they're pre-sold before they ever see a demo. The GBP audit costs nothing to produce and positions 7thsense as an authority, not a vendor.

---

*This document extends STRATEGY-V1.md with concrete automation recommendations, revised packaging, and innovative go-to-market tactics. For domain-specific scenarios, see DOMAIN-PLAYBOOK.md. For deployment steps, see DEPLOYMENT-PROCESS.md and GO-LIVE-CHECKLIST.md.*
