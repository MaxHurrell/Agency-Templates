---
name: 7thsense-signal-detection
description: 'Josh-level signal detection for finding businesses with specific, quantifiable problems. Detects Google Ads spend with weak landing pages, strong reviews with no website, Maps ads without conversion infrastructure. Quantifies the monthly cost of each problem in rands/dollars. Produces ranked prospect lists with financial impact.'
---

# 7thsense Signal Detection

## What Is a Signal

A signal is observable evidence that a business already has the problem you solve — right now, not hypothetically.

**Josh's signal:** Google Ads spend over $50K/month + AI analysis showing poor performance.
**Our signal:** Strong Google presence (reviews, Maps, ads) + weak or missing website conversion layer.

The signal proves the problem exists. The quantification proves the problem is expensive. The demo proves you can fix it.

## Signal Hierarchy (ranked by urgency and value)

### CRITICAL — Score 5/5
**Running Google Ads + no website or broken website**
They are literally paying per click to send traffic nowhere. Every click that bounces is money burned.
- Detection: Search "[niche] [city]" on Google. Note "Sponsored" results. Click through to their site.
- Quantification: Estimated monthly ad spend × estimated bounce rate = monthly waste
- Typical waste: R5,000–R50,000/month for local service businesses
- **This is the highest-value target in the system.** They already believe in paying for leads — they just need the conversion layer.

### HIGH — Score 4/5
**Strong reviews (4.5+, 50+ count) + no website**
Word of mouth is working. Google Maps is generating impressions. But there's no website to convert that attention into bookings.
- Detection: Google Maps search → check each listing for website field. Empty = target.
- Quantification: Estimated monthly Maps impressions × 5% click rate × conversion gap × LTV
- **These prospects have no ego investment in an existing site** — easiest close.

### HIGH — Score 4/5
**Running Google Maps ads (Local Services Ads) + weak website**
Paying to appear at the top of Maps results. When someone clicks "Website" on their listing, they land on a page that doesn't convert.
- Detection: Search "[niche] near me" on mobile. First 3 results with "Sponsored" = running LSAs.
- Quantification: Estimated LSA cost per lead × leads lost to weak site = monthly opportunity cost

### MEDIUM — Score 3/5
**Good reviews + decent website + no lead capture**
Site exists and looks okay, but has no form, no WhatsApp CTA, no booking button, no chat.
- Detection: Firecrawl scrape → search for form elements, tel: links, WhatsApp links, chat widgets
- Quantification: Estimated traffic × missing conversion path × LTV

### LOW — Score 2/5
**Good reviews + decent website + basic lead capture**
Working system, minor improvements possible. Upsell opportunity, not a new sale.
- Detection: Full site audit reveals optimization opportunities
- Not worth building a demo for cold outreach. Only approach if referred or warm.

## How to Detect Each Signal

### Signal 1: Google Ads Running
```
1. Open Google in incognito mode
2. Search: "[niche] [city]" (e.g. "dentist cape town")
3. Results marked "Sponsored" or "Ad" are running Google Ads
4. For each ad result:
   a. Note business name
   b. Click through to landing page
   c. Scrape with Firecrawl — assess quality (mobile, forms, speed, design)
   d. If landing page is weak: CRITICAL signal
5. Optional: Check Google Ads Transparency Center (adstransparency.google.com)
   Search business name — shows active ads and approximate duration
```

### Signal 2: Strong Reviews, No Website
```
1. Search Google Maps: "[niche] in [city]"
2. Filter mentally: rating 4.0+, 20+ reviews
3. For each listing:
   a. Check "Website" field — empty or Facebook/Instagram link = no website
   b. If no website: HIGH signal
   c. If website exists: click through and assess quality
4. Record: business name, rating, review count, phone, address
```

### Signal 3: Local Services Ads (Maps Ads)
```
1. Search on mobile: "[niche] near me"
2. Top 3 results with green "Sponsored" checkmark = running LSAs
3. These businesses pay R20-R100 per lead through Maps
4. Click their website link — assess quality
5. If website is weak: they're paying premium prices to lose leads
```

### Signal 4: Social Media Only
```
1. Search: "[business name]"
2. If top result is Instagram/Facebook, not a .com/.co.za: no website
3. Check their Instagram bio — if it's a Linktree/link-in-bio: no website
4. These businesses have customers but zero conversion infrastructure
```

### Signal 5: Facebook/Instagram Ads Running
```
1. Go to facebook.com/ads/library
2. Search business name
3. If active ads appear: they are paying for traffic
4. Click through to where the ads send traffic
5. If it goes to Instagram DMs or a weak site: HIGH signal
```

## Quantification Formulas

### Dental (South Africa)
```
Monthly Maps impressions (estimate): review_count × 50
Click-through rate: 5%
Current conversion rate (bad site): 5%
Good site conversion rate: 20%
Conversion gap: 15%
Patient LTV: R6,700

Monthly opportunity cost = (review_count × 50) × 5% × 15% × R6,700
Example: 30 reviews × 50 = 1,500 impressions × 5% = 75 clicks × 15% gap = 11 patients × R6,700 = R73,700/month in missed LTV

Simplified pitch: "You're likely losing 5-10 potential patients per month to your website. That's R33,000-R67,000 in lifetime value walking away."
```

### Law (US Market)
```
Estimated monthly search volume for "[practice area] [city]": 500-2,000
Website traffic estimate (if ranking): 10-20% of search volume
Current conversion rate (bad site): 1%
Good site conversion rate: 4%
Conversion gap: 3%
Average case value: $15,000-$50,000

Monthly opportunity cost = traffic × 3% gap × case value
Example: 200 visitors × 3% = 6 missed consultations × $20,000 = $120,000/month

Simplified pitch: "Every month your website fails to convert visitors into consultations, you're leaving 3-5 cases on the table. At your case values, that's $50,000-$100,000."
```

### Aesthetics (US Market)
```
Monthly website visitors (estimate from reviews/social): 500-3,000
Current conversion rate: 1.5%
Good site conversion rate: 4%
Conversion gap: 2.5%
Average client annual value: $4,000

Monthly opportunity cost = visitors × 2.5% gap × ($4,000/12)
Example: 1,000 visitors × 2.5% = 25 missed bookings × $333/month value = $8,325/month

Simplified pitch: "Your reviews are doing the hard work of building trust. Your website is dropping the ball on converting that trust into bookings."
```

## Detection Workflow (Step by Step)

1. **Define target:** niche + city (e.g. "dentist Cape Town Southern Suburbs")
2. **Google Maps scan:** search, extract top 20 listings rated 4.0+
3. **Website check:** for each listing — website exists? quality? mobile?
4. **Ads check:** search Google for "[niche] [city]" — note which businesses appear in ads
5. **Facebook check:** search Ad Library for each top prospect
6. **Score each prospect** 1-5 based on signal hierarchy
7. **Quantify the problem** for the top 5 prospects using niche formula
8. **Output ranked list:** name, signal, score, estimated monthly cost, demo priority
9. **Build demos** for top 3 CRITICAL/HIGH signals before making any contact

## Output Format

```
SIGNAL SCAN: [Niche] in [City]
Date: [Date]
Scanned: [N] businesses

CRITICAL (Score 5):
1. [Business] — Running Google Ads, landing page scores 2/10
   Rating: [X] | Reviews: [N] | Monthly cost of problem: R[X]
   Ad evidence: [search query where ad appeared]

HIGH (Score 4):
2. [Business] — 4.8 stars, 45 reviews, NO website
   Monthly cost of problem: R[X]
   Contact: [phone] | [email if found]

WARM (Score 3):
3. [Business] — Good site, no contact form
   Monthly cost of problem: R[X]

RECOMMENDATION: Build demos for prospects 1-3 today. Outreach by [date].
```
