# SEO Transition Protocol — 7thsense
## Domain Migration, Redirect Strategy, and Post-Migration Monitoring
*Created: March 17, 2026*

---

## When This Document Applies

- Client is moving from an old domain to a new domain
- Client is moving from a website builder (Wix/Squarespace) to 7thsense on Vercel
- Client's old site had meaningful SEO value (indexed pages, backlinks, traffic)
- Any situation where Google needs to understand that a website has moved

---

## Step 1 — Pre-Migration Assessment

Before changing anything, document the current state:

```bash
# Check current indexed pages
# Use Firecrawl search: site:olddomain.com

# Check current backlinks (if Ahrefs/Moz available, or use free tools)
# Note: for small local businesses, backlinks are usually minimal

# Document current Search Console data (if accessible)
# - Total impressions last 90 days
# - Total clicks last 90 days
# - Top 10 keywords and positions
# - Top 10 pages by traffic

# Save all data — this is the baseline for measuring migration success
```

**Decision point:** If the old site has fewer than 50 indexed pages and fewer than 10 referring domains, the SEO risk of migration is LOW. Most local service businesses fall into this category. Proceed confidently.

---

## Step 2 — Google Search Console Setup

### If Old Domain Has Search Console Access

1. Go to search.google.com/search-console
2. Ensure both old and new properties are verified:
   - Old: `https://olddomain.com` (should already be verified)
   - New: `https://newdomain.com` (verify via DNS TXT record)
3. In the OLD property: Settings → Change of Address → select new property → Validate & Submit
4. Google begins transferring signals within 24-48 hours

### If Old Domain Has No Search Console

1. Add ONLY the new domain to Search Console
2. Verify via DNS TXT record:
   ```
   TXT record: google-site-verification=[code from GSC]
   ```
3. Submit sitemap: `https://newdomain.com/sitemap.xml`
4. Request indexing for the homepage and top 5 pages

---

## Step 3 — 301 Redirect Implementation

### If You Control the Old Domain

Set up 301 redirects from every old URL to the corresponding new URL. For single-page sites (most 7thsense builds), this is simple:

**Option A — At the DNS/hosting level (Vercel redirect):**
Deploy a minimal `vercel.json` to the old domain's Vercel project:
```json
{
  "redirects": [
    { "source": "/(.*)", "destination": "https://newdomain.com/$1", "statusCode": 301 }
  ]
}
```

**Option B — At the registrar level:**
Many registrars (Namecheap, GoDaddy) offer URL forwarding with 301 status. Set the old domain to forward to the new domain with a 301 redirect.

**Option C — If old site was on a builder (Wix/Squarespace):**
Most builders do NOT support custom 301 redirects to external domains. Options:
1. Transfer the domain out of the builder first, then set up redirects via Vercel or registrar
2. If domain can't be transferred, accept that old URLs will 404 and focus on building new authority

### If You Don't Control the Old Domain

1. Can't set up 301 redirects — accept this limitation
2. Focus entirely on building new domain authority via GBP update, citations, and fresh content
3. Timeline to recover is longer (3-6 months vs 1-3 months with redirects)

---

## Step 4 — Post-Migration Technical Checklist

Within 24 hours of go-live on new domain:

- [ ] Verify new site returns 200 on all pages
- [ ] Verify sitemap.xml is accessible at `https://newdomain.com/sitemap.xml`
- [ ] Verify robots.txt allows crawling: `https://newdomain.com/robots.txt`
- [ ] Submit sitemap in Google Search Console
- [ ] Request indexing for homepage in Search Console (URL Inspection → Request Indexing)
- [ ] Verify GBP website URL updated to new domain
- [ ] Update all business citations (Yelp, Yellow Pages, industry directories) to new domain
- [ ] Update social media profiles (Facebook, Instagram, LinkedIn) to new domain
- [ ] If 301 redirects set up: verify they work: `curl -sI https://olddomain.com | grep -i location`

---

## Step 5 — Citation Update Priority List

Update these in order of impact:

1. **Google Business Profile** — highest impact, update immediately
2. **Facebook business page** — update website URL
3. **Instagram bio** — update link
4. **Yelp / Yellow Pages / industry directories** — update within first week
5. **LinkedIn company page** — update website
6. **Any other directory listing** the business appears on

For SA businesses specifically:
- Yell.co.za
- BusinessListing.co.za
- Brabys.com
- SA Yellow Pages

---

## Step 6 — Monitoring Checklist

### Week 1 (Days 1-7)
- [ ] Check Search Console for crawl errors daily
- [ ] Verify homepage is indexed: search `site:newdomain.com` on Google
- [ ] Check that 301 redirects are working (if set up)
- [ ] Monitor GBP for updated website link display

### Month 1 (Days 8-30)
- [ ] Check Search Console weekly for indexing progress
- [ ] Compare impressions to pre-migration baseline
- [ ] Verify all key pages are indexed
- [ ] Check for any 404 errors in Search Console → Coverage report
- [ ] First monthly report to client (include migration status)

### Month 2 (Days 31-60)
- [ ] Search Console impressions should be approaching pre-migration levels
- [ ] Check ranking positions for top keywords
- [ ] Identify any pages that lost ranking → investigate
- [ ] Continue citation updates for any missed directories

### Month 3 (Days 61-90)
- [ ] Full recovery expected if 301 redirects are in place
- [ ] 70-80% recovery expected without redirects (local businesses recover faster)
- [ ] Compare impressions, clicks, and positions to pre-migration baseline
- [ ] Report to client with before/after comparison

---

## What to Tell the Client

### Before Migration
"During the domain transition, there may be a temporary dip in your Google search visibility — this is completely normal and expected. For local businesses like yours, most of your traffic comes from Google Maps, which updates within 24-72 hours. The organic search rankings typically recover within 4-8 weeks. I'll monitor everything and send you weekly updates during the transition period."

### During Migration (Week 1)
"Your new site is live. Google is already re-indexing it — I can see it in Search Console. Your Google Maps listing has been updated to point to your new domain. Everything is on track."

### Post-Migration (Month 1)
"Here's your first post-migration report. Google has indexed [X] pages on your new domain. Your Maps listing is showing the new site. Traffic is [recovering/stable/growing]. We're right on track."

---

## Key Facts for Context

- **Local businesses recover faster** than content sites because their primary traffic source is Google Maps, not organic search
- **Google Maps updates within 24-72 hours** of GBP website URL change
- **301 redirects transfer ~90-95% of link equity** (Google's guidance)
- **Without 301 redirects, recovery takes ~2x longer** but still happens as Google discovers the new domain via GBP and citations
- **For sites with <50 indexed pages and <10 backlinks** (most small businesses), the SEO impact of migration is minimal — the GBP update is the most important step
- **The biggest risk is NOT migrating** — staying on a slow, outdated site costs more in lost patients than any temporary SEO dip

---

*Referenced by: DOMAIN-PLAYBOOK.md, DEPLOYMENT-PROCESS.md, prospect-qualifier skill*
