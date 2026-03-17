---
name: 7thsense-prospect-qualifier
description: 'Pre-qualification system for prospects. Takes a business name and domain URL, automatically produces domain intelligence (whois, hosting, platform, expiry, ownership), GBP intelligence (rating, reviews, completeness), SEO health (indexing, sitemap, mobile, speed), and a transition complexity score (GREEN/AMBER/RED). Routes prospects for outreach with correct pricing and timeline expectations. Run this BEFORE any outreach or demo build.'
---

# 7thsense Prospect Pre-Qualification System

## Purpose

Given only a business name and domain URL, automatically determine the full technical situation before any outreach happens. This prevents surprises post-sale, sets correct client expectations, and routes prospects to the right package and timeline.

## When to Use

- Before building any demo
- Before sending any outreach message
- When evaluating a prospect from the opportunity scanner
- When a prospect responds and wants to proceed

## Input Required

```
Business name: "Werner Joubert Dental"
Domain: bellvilledentist.co.za
```

## Data Collection Protocol

### 1. DOMAIN INTELLIGENCE

**Who owns the domain:**
```bash
whois [DOMAIN] 2>/dev/null | grep -iE "registrant|registrar|name server|expir|status"
```
Parse for:
- Registrant name — does it match the business name? If not → RED FLAG (agency-owned)
- Registrar name — identifies where DNS is managed (Namecheap, GoDaddy, Domains.co.za, etc.)
- Expiry date — less than 30 days → RED FLAG (urgent renewal needed)
- Domain status — "clientTransferProhibited" means domain is locked (normal, but needs unlocking for transfer)

**Where it's hosted/pointing:**
```bash
dig [DOMAIN] +short          # A record — where site is hosted
dig www.[DOMAIN] +short       # CNAME — often reveals CDN/platform
dig MX [DOMAIN] +short        # Email provider — CRITICAL for transition
dig TXT [DOMAIN] +short       # SPF/DKIM — needed for email protection
```

**What platform the site is built on:**
Use Firecrawl to scrape the site, then check for platform signatures:
- **Wix:** `<meta name="generator" content="Wix.com"` or scripts from `static.wixstatic.com`
- **Squarespace:** `<link href="//fonts.squarespace.com"` or `<!-- This is Squarespace -->`
- **WordPress:** `<meta name="generator" content="WordPress"` or `/wp-content/` in URLs
- **WordPress.com (hosted):** `*.wordpress.com` in CNAME or `s0.wp.com` scripts
- **Shopify:** `cdn.shopify.com` in scripts
- **Site123:** `cdn-cms-s.f-static.net` in scripts
- **GoDaddy Builder:** `img1.wsimg.com` in scripts
- **Custom/Static:** No platform signatures — likely developer-built HTML

```bash
# Quick platform detection via curl headers
curl -sI [DOMAIN] | grep -iE "x-powered-by|server|x-wix|x-squarespace"
# Deep detection via page source
curl -s [DOMAIN] | grep -ioE "wix\.com|squarespace|wordpress|shopify|site123|wsimg\.com" | sort -u
```

### 2. GBP INTELLIGENCE

**Check if GBP exists and get data:**
If `GOOGLE_MAPS_API_KEY` is available:
```bash
curl -s "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=[BUSINESS_NAME_ENCODED]&inputtype=textquery&fields=place_id,name,formatted_address,rating,user_ratings_total,business_status,website&key=$GOOGLE_MAPS_API_KEY"
```

If no API key — use web search:
```
Search: "[business name]" "[city]" site:google.com/maps
```
Or use Firecrawl to search Google Maps directly.

**GBP Completeness Score (out of 10):**
| Element | Points | How to Check |
|---------|--------|-------------|
| GBP exists and is claimed | 2 | Place ID found |
| Rating 4.0+ | 1 | rating field |
| 10+ reviews | 1 | user_ratings_total |
| Website URL present | 1 | website field not empty |
| Website URL matches domain | 1 | website field matches input domain |
| Photos present (10+) | 1 | Check via Maps scrape |
| Hours listed | 1 | Check via Maps scrape |
| Description present | 1 | Check via Maps scrape |
| Posts in last 30 days | 1 | Check via Maps scrape |

### 3. SEO HEALTH

**Is the site indexed?**
```bash
# Check via Google Search (use Firecrawl search)
Search: site:[DOMAIN]
# Count approximate indexed pages from result count
```

**Does it have a sitemap?**
```bash
curl -sI [DOMAIN]/sitemap.xml | head -1    # Should return 200
curl -sI [DOMAIN]/sitemap_index.xml | head -1
curl -s [DOMAIN]/robots.txt | grep -i sitemap
```

**Mobile-friendly?**
```bash
# Quick check: does viewport meta exist?
curl -s [DOMAIN] | grep -i "viewport"
```

**Page load speed (rough):**
```bash
# Time to first byte
curl -s -o /dev/null -w "TTFB: %{time_starttransfer}s\nTotal: %{time_total}s\n" [DOMAIN]
# Under 1s TTFB = good, 1-3s = acceptable, 3s+ = poor
```

**Basic on-page SEO:**
```bash
# Check for meta title and description
curl -s [DOMAIN] | grep -ioE '<title>[^<]+</title>'
curl -s [DOMAIN] | grep -ioE 'meta name="description" content="[^"]*"'
# Missing either = SEO issue
```

### 4. TRANSITION COMPLEXITY SCORING

Score each dimension, then assign overall rating:

| Dimension | GREEN (0 pts) | AMBER (1 pt) | RED (2 pts) |
|-----------|--------------|--------------|-------------|
| Domain ownership | Registrant matches business | Unclear/private registration | Registrant is different entity (agency) |
| Domain access | Client confirms access | Client unsure | No access, agency holds |
| Platform | Static HTML / WordPress self-hosted | WordPress.com / GoDaddy Builder | Wix / Squarespace (domain locked in platform) |
| Domain expiry | 6+ months | 1-6 months | Under 30 days |
| Email on domain | No domain email | Domain email, standard provider | Domain email, unknown/custom mail server |
| GBP ownership | Client owns / easy to verify | Uncertain | Agency-owned or unclaimed |
| SEO value | Low traffic, few backlinks | Moderate traffic, some backlinks | High traffic, significant backlinks to preserve |

**Total score:**
- 0-3 → **GREEN** (easy, 1-2 hours, standard package)
- 4-7 → **AMBER** (medium, 1-5 days, run domain discovery checklist before signing)
- 8+ → **RED** (complex, 1-4 weeks + R1,500 domain recovery fee)

### 5. ROUTING DECISION

**GREEN route:**
- Include in standard package
- Proceed with outreach using normal messaging
- Timeline: demo → approval → live in 1-2 days
- No additional fees

**AMBER route:**
- Flag for domain discovery checklist (DOMAIN-PLAYBOOK.md Output 2)
- Adjust outreach: "We'll need a few days to set up your domain — I'll handle everything"
- Timeline: demo → approval → live in 3-7 days
- No additional fees, but set timeline expectations

**RED route:**
- Flag R1,500 Domain Recovery Service fee
- Adjust outreach messaging: lead with the problem they already know about (their domain situation is likely something they've been frustrated by)
- Timeline: demo → approval → domain recovery (1-4 weeks) → live
- Quote the R1,500 fee upfront in the proposal
- Consider starting on a temporary domain while recovery happens

### 6. OUTREACH ANGLE RECOMMENDATION

Based on qualification data, suggest the strongest outreach angle:

| Finding | Outreach Angle |
|---------|---------------|
| High reviews, bad site | "Your patients love you — your website doesn't show it" |
| No website at all | "X patients searched for you this month and found nothing" |
| Old/slow site | "Your site takes Xs to load — that's Y patients bouncing per month" |
| No mobile optimisation | "60% of your visitors are on mobile and your site doesn't work on phones" |
| Running ads with bad site | "You're spending R[X]/month on ads going to a page that loses 67% of clicks" |
| Low review count | "You have X reviews — your competitor has Y. Every missing review costs you patients" |
| GBP incomplete | "Your Google listing is missing [X, Y, Z] — that's the first thing patients see" |
| Domain expiring | "Your domain expires on [date] — if you lose it, you lose your online identity" |

## Output Format

The qualification produces a structured report:

```
═══════════════════════════════════════
PROSPECT QUALIFICATION REPORT
═══════════════════════════════════════
Business: [NAME]
Domain: [DOMAIN]
Date: [DATE]

DOMAIN INTELLIGENCE
  Registrar: [registrar]
  Registrant: [name] — [MATCH/MISMATCH with business name]
  Expiry: [date] — [OK/WARNING/CRITICAL]
  Hosting: [IP/provider]
  Platform: [Wix/WP/Custom/etc]
  Email: [MX records found / none]

GBP INTELLIGENCE
  Place ID: [ID or NOT FOUND]
  Rating: [X.X] from [N] reviews
  Website on GBP: [URL] — [MATCHES/MISMATCHES domain]
  Completeness: [X]/10

SEO HEALTH
  Indexed pages: ~[N]
  Sitemap: [YES/NO]
  Mobile-friendly: [YES/NO]
  TTFB: [X.Xs]
  Meta title: [present/missing]
  Meta description: [present/missing]

TRANSITION COMPLEXITY: [GREEN/AMBER/RED]
  Score: [N]/14
  Key risks: [list]

ROUTING: [Standard / Discovery checklist / Recovery fee]
ESTIMATED GO-LIVE: [timeline]
SUGGESTED OUTREACH ANGLE: [angle]
FLAGS: [any critical issues]
═══════════════════════════════════════
```

## Script

Run the automated qualification script:
```bash
bash ~/agency-templates/7thsense-system/scripts/qualify-prospect.sh [DOMAIN] "[BUSINESS NAME]"
```

See also:
- DOMAIN-PLAYBOOK.md — for resolving domain scenarios
- DEPLOYMENT-PROCESS.md — for go-live process
- SEO-TRANSITION-PROTOCOL.md — for domain migration SEO
