# 7thsense — Deployment Process
## From Demo Approval to Site Live
*Created: March 17, 2026*
*Source: Council session — c-level, business-growth, marketing, engineering, product, project-management, strategic-intelligence*
*Rule 43: Written from MASTER_BRIEF.md, BRAIN.md, STRATEGY-V1.md, GO-LIVE-CHECKLIST.md, PACKAGES.md*

---

## OUTPUT 1 — RECOMMENDED DECISIONS

### QUESTION 1 — DOMAINS

> **For complex domain scenarios (existing domains, agency transfers, email protection, builder unlocks), see the full [DOMAIN-PLAYBOOK.md](DOMAIN-PLAYBOOK.md) which covers 8 scenarios with step-by-step resolution, client communication templates, and technical reference.**

**Decision: Option A — Max buys domain on client's behalf (new domain scenario).**

Max registers the domain on Namecheap (international clients) or Domains.co.za (.co.za clients) at the time of 50% deposit receipt. Domain cost is included in the package price — the client never sees a separate domain bill. Domain ownership is registered in the client's name with Max as the technical contact. After 12 months of active retainer (or on cancellation), Max transfers full registrar access to the client.

**Why this wins:** Zero friction for the client. They don't need to understand registrars, DNS, or WHOIS. They pay one price and get everything. Max retains technical control during the active relationship, which is essential for deployments, SSL, and DNS changes. The 12-month transfer clause creates natural retention without feeling like a hostage situation. Namecheap costs ~$10-12/year for .com, ~R100-150/year for .co.za on Domains.co.za — trivially absorbed into the R7,500+ package price.

**Risks mitigated:** Client can always request transfer at any time (contractually guaranteed) — this prevents any accusation of domain holding. The domain is registered in THEIR name from day one — Max is the technical contact only. If the relationship ends, Max initiates transfer within 7 business days.

### QUESTION 2 — HOSTING

**Decision: Option A — All sites on Vercel under Max's account (free tier).**

Every client site is deployed as its own Vercel project under Max's account. Custom domains are added per project. Vercel's free tier includes unlimited projects, 100GB bandwidth/month, and automatic SSL. This is the correct choice now and remains correct until approximately 20 active client sites, at which point bandwidth may approach the free tier limit.

**When it changes:** At 20+ active clients or if any single site exceeds 10GB/month bandwidth, upgrade to Vercel Pro ($20/month). This is still cheaper than any alternative and gives 1TB bandwidth. The switch is seamless — no migration required, just a plan upgrade. Never move to per-client Vercel accounts — it creates administrative chaos and removes Max's ability to deploy quickly.

### QUESTION 3 — SSL AND DNS

**DNS records the client's domain needs:**

| Type | Name | Value | TTL |
|------|------|-------|-----|
| A | @ | 76.76.21.21 | 3600 |
| CNAME | www | cname.vercel-dns.com | 3600 |

**Exact steps Max follows:**
1. Log into the registrar (Namecheap/Domains.co.za)
2. Navigate to DNS management for the domain
3. Delete any existing A records for @ (root domain)
4. Add A record: Host=@ Value=76.76.21.21 TTL=Automatic
5. Add CNAME record: Host=www Value=cname.vercel-dns.com TTL=Automatic
6. In Vercel dashboard → select client project → Settings → Domains → Add domain
7. Enter both `clientdomain.com` and `www.clientdomain.com`
8. Vercel will show "Invalid Configuration" until DNS propagates — this is normal
9. Wait. Check with: `dig clientdomain.com +short` — when it returns `76.76.21.21`, it's live
10. Vercel auto-provisions SSL via Let's Encrypt. No manual action needed.

**What to tell the client:** "DNS is being connected — your site will be live within 30 minutes. Sometimes it takes up to 2 hours. I'll confirm the moment it's live." In practice, Namecheap propagates in 5-15 minutes. Domains.co.za can take up to 2 hours. Never promise "instant" — always under-promise.

### QUESTION 4 — TALLY FORMS

**Decision: Option A with upgrade path — All forms under Max's Tally, notifications forwarded to client.**

During demo phase: all forms notify maxhurrellsa@gmail.com (Max tracks leads as sales signals). At go-live: update the existing form's notification email to the client's email address. Do NOT create a new form per client — this wastes Tally form limits and creates unnecessary complexity. Instead, update the `&source=` parameter to the client's slug and change the notification email.

**The exact go-live process:**
1. Open tally.so → find the form used on the client's site
2. Settings → Notifications → Change email from maxhurrellsa@gmail.com to client's email
3. Optionally add Max as CC (to monitor that leads are flowing)
4. Update `&source=` parameter in the iframe URL to the client's production slug
5. Submit a test entry on the live domain
6. Confirm with client: "Check your email — you should have a test enquiry"
7. Done

**Upgrade trigger:** At 10 active clients, the free tier (100 submissions/month) becomes tight. At that point, upgrade to Tally Pro ($29/month) for unlimited submissions and custom branding. This cost is trivially covered by one retainer client.

### QUESTION 5 — ANALYTICS

**Decision: GA4 + Google Search Console, owned by Max, client given viewer access.**

**Minimum viable setup:**
1. Create GA4 property under Max's Google account (maxhurrellsa@gmail.com)
2. Add GA4 snippet to the site's `<head>` before deployment
3. Submit site to Google Search Console — verify via DNS TXT record
4. Add client's email as Viewer on both GA4 and Search Console

**Why GA4 over Plausible:** GA4 is free, the client has heard of it, and it integrates with Google Ads if they ever run ads. Plausible ($9/month per site) is better for privacy but costs money per client and the client won't recognise it. Use GA4.

**Monthly report template (included in retainer):**
- Unique visitors this month (vs last month)
- Top 5 pages by traffic
- Form submissions this month
- Phone click events this month
- Average session duration
- Google Search Console: impressions, clicks, average position for top 5 keywords
- Lighthouse performance score
- Google review count change
- One recommendation for next month

Delivered as a PDF or formatted email on the 1st of each month. Takes ~15 minutes to compile once the GA4 property is set up.

### QUESTION 6 — CLIENT HANDOFF

**What the client receives on go-live day:**
1. Live URL on their own domain (tested, SSL active)
2. Confirmation that the contact form sends enquiries to their email
3. Client Handoff Document (see Output 3 below)
4. GA4 Viewer access invitation
5. Google Search Console Viewer access invitation
6. A WhatsApp message: "Your new website is live at [domain]. Every enquiry goes straight to your email."

**What logins the client needs:** None. They receive viewer access to analytics. They don't need access to Vercel, GitHub, Tally, or the DNS registrar. Max manages everything technical.

**What ongoing access Max needs:**
- Vercel project (owns it)
- GitHub repo (owns it)
- Tally form (owns it)
- DNS registrar (technical contact)
- GA4 property (Admin access)
- Google Search Console (Owner access)

The client should never need to "log in to their website." If they want changes, they WhatsApp or email Max. This is the retainer value proposition.

---

## OUTPUT 2 — THE GO-LIVE CHECKLIST

### Phase 1 — Payment & Domain (Day 0)

1. Confirm 50% balance payment received (EFT or payment link)
2. Register domain on Namecheap (.com) or Domains.co.za (.co.za)
   - Register in client's name
   - Set Max (maxhurrellsa@gmail.com) as technical contact
   - Enable auto-renew
   - Note: domain cost absorbed into package price
3. Confirm domain registration is active: `whois clientdomain.com`

### Phase 2 — Code Updates (30 minutes)

4. Open `~/client-sites/[client-name]/index.html`
5. Update `<link rel="canonical" href="https://[client-domain]">`
6. Update `og:url` to `https://[client-domain]`
7. Update `og:image` URLs to use `https://[client-domain]/` prefix
8. Update `og:site_name` to client business name
9. Update Tally form `&source=` parameter to production slug
10. Add GA4 snippet before `</head>`:
    ```html
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-[ID]"></script>
    <script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','G-[ID]');</script>
    ```
11. Add `robots.txt` and `sitemap.xml` to client directory
12. Update any hardcoded demo URLs in the HTML

### Phase 3 — DNS & Deployment (15 minutes)

13. Log into domain registrar → DNS management
14. Add A record: `@` → `76.76.21.21`
15. Add CNAME record: `www` → `cname.vercel-dns.com`
16. In Vercel dashboard → client project → Settings → Domains
17. Add `clientdomain.com` and `www.clientdomain.com`
18. Deploy: `cd ~/client-sites && ./deploy-client.sh [client-name]`
19. Wait for DNS propagation — check with: `dig clientdomain.com +short`
20. Confirm returns `76.76.21.21`
21. Curl confirm 200: `curl -sI https://clientdomain.com | head -1`
22. Confirm SSL active: open in browser, verify padlock icon
23. Confirm www redirect works: `curl -sI https://www.clientdomain.com | head -1`

### Phase 4 — Tally Form Handoff (5 minutes)

24. Open tally.so → form settings
25. Change notification email from maxhurrellsa@gmail.com to client's email
26. Add Max as CC (optional — recommended for first month)
27. Submit test form on live domain
28. WhatsApp client: "Check your email — test enquiry from your new site"
29. Wait for client confirmation: "Got it"

### Phase 5 — Analytics Setup (10 minutes)

30. Create GA4 property at analytics.google.com
31. Copy Measurement ID (G-XXXXXXX)
32. Confirm GA4 snippet is in the deployed HTML (step 10)
33. Go to GA4 → Admin → Property Access → Add client email as Viewer
34. Go to search.google.com/search-console
35. Add property → URL prefix → `https://clientdomain.com`
36. Verify via DNS TXT record (add to registrar, Google confirms within minutes)
37. Add client email as Viewer on Search Console

### Phase 6 — Quality Verification (10 minutes)

38. Test contact form on live domain — confirm notification arrives at client email
39. Test WhatsApp button on real mobile phone
40. Test click-to-call on real mobile phone
41. Test Google Maps embed loads correctly
42. Test Open Graph preview: share URL in WhatsApp to yourself
43. Run Lighthouse mobile audit — must score 85+ performance
44. Verify all images load (no broken images)
45. Verify correct phone number, address, hours displayed

### Phase 7 — Client Handoff (10 minutes)

46. Send Client Handoff Document (see Output 3) via email
47. Send WhatsApp: "Your site is live at [domain]. Contact form enquiries go to your email. Let me know if you need anything."
48. Update `~/client-sites/client-index.md` — status: Live (production), URL: production domain
49. Update MASTER_BRIEF.md Section 2 with production URL
50. If on retainer: set calendar reminder for monthly report (30 days from go-live)

### Phase 8 — Post-Go-Live (48 hours)

51. Morning after: check site loads, check for form submissions
52. Send client a WhatsApp: "Just checking everything's running smoothly — any questions?"
53. Day 3: check GA4 — confirm data is flowing
54. Day 7: first mini-report to client — "Your site had X visitors this week"

**Total steps: 54**
**Total time: approximately 1.5-2 hours per client go-live**

---

## OUTPUT 3 — CLIENT HANDOFF DOCUMENT TEMPLATE

---

**[CLIENT BUSINESS NAME]**
**Website Launch — Handoff Document**
*[DATE]*

---

Dear [CLIENT NAME],

Your new website is live.

**Your site:** https://[CLIENT-DOMAIN]

Everything is set up and working. Here's what you need to know.

---

### How Enquiries Work

Every time someone fills in the contact form on your website, you'll receive an email notification at **[CLIENT EMAIL]**. The notification includes their name, phone number, and message.

**Action required from you:** Reply to enquiries within 1 hour during business hours. Speed of response is the single biggest factor in converting a website enquiry into a booked appointment.

You can also check your Google Analytics dashboard to see how many people visited your site: [GA4 VIEWER LINK]

---

### How to Request Changes

Need to update your phone number, hours, services, or any text on the site? Simply send me a WhatsApp or email:

- **WhatsApp:** [MAX'S NUMBER]
- **Email:** maxhurrellsa@gmail.com

Describe what you'd like changed and I'll update it within 24 hours (business days). Your retainer includes [X] content changes per month.

---

### What Your Retainer Includes

Your monthly retainer (R2,500/month) covers:

- **[X] content changes per month** — text updates, new photos, service changes
- **Performance monitoring** — I check your site speed and uptime weekly
- **Monthly report** — delivered on the 1st of each month with visitor stats, enquiry count, and Google ranking updates
- **Priority support** — any issues are addressed within 24 hours
- **Hosting & SSL** — included at no extra charge, your site stays fast and secure

---

### What Happens Next

1. **This week:** I'll monitor the site closely to make sure everything runs smoothly
2. **End of month:** You'll receive your first monthly performance report
3. **Ongoing:** If you want to add Google Ads, a blog, or additional pages — just ask and I'll send you a quote

---

### Important Details

| Item | Detail |
|------|--------|
| Website URL | https://[CLIENT-DOMAIN] |
| Contact form notifications | [CLIENT EMAIL] |
| Domain renewal | Handled automatically — included |
| SSL certificate | Automatic — always active |
| Hosting | Managed by 7thsense — no action needed |
| Analytics | Google Analytics — viewer access sent to your email |

---

### About Your Domain

Your domain **[CLIENT-DOMAIN]** is registered in your name. I manage the technical settings (DNS, hosting connection) as part of your retainer. If you ever want to transfer it to another provider, I'll initiate the transfer within 7 business days — no questions asked.

---

Thank you for choosing 7thsense. I built this site to make your phone ring more — and I'm here to make sure it keeps doing that.

Max Hurrell
**7thsense**
maxhurrellsa@gmail.com

---

## OUTPUT 4 — THE VISUAL FLOW

### Demo Approval → Site Live (complete flow)

```
CLIENT APPROVES DEMO
        ↓
Max sends invoice (50% balance)
        ↓
PAYMENT RECEIVED ← Gate: nothing proceeds until payment clears
        ↓
Max registers domain (Namecheap or Domains.co.za)
  → In client's name
  → Max as technical contact
  → Auto-renew enabled
        ↓
Domain active — Max configures DNS
  → A record: @ → 76.76.21.21
  → CNAME: www → cname.vercel-dns.com
        ↓
Max updates site code
  → Canonical URLs → production domain
  → OG meta tags → production domain
  → Tally source param → production slug
  → GA4 snippet added
  → robots.txt + sitemap.xml added
        ↓
Max adds custom domain in Vercel dashboard
        ↓
Max deploys: ./deploy-client.sh [client]
        ↓
DNS PROPAGATES (5-120 minutes)
  → Max monitors with: dig clientdomain.com +short
  → Vercel auto-provisions SSL
        ↓
SITE LIVE ON CUSTOM DOMAIN ← Gate: curl confirms 200
        ↓
Max updates Tally form notifications
  → Remove Max's email
  → Add client's email
  → Submit test form
        ↓
CLIENT CONFIRMS TEST EMAIL RECEIVED ← Gate: must confirm before proceeding
        ↓
Max sets up GA4 + Search Console
  → Create property
  → Add client as Viewer
  → Verify Search Console via DNS
        ↓
Max runs quality checks
  → Form test ✓
  → WhatsApp button ✓
  → Click-to-call ✓
  → Maps embed ✓
  → Lighthouse 85+ ✓
  → OG preview ✓
        ↓
Max sends Client Handoff Document
  → Via email (professional PDF or formatted email)
  → Includes: URL, how enquiries work, how to request changes, retainer details
        ↓
Max sends WhatsApp confirmation
  → "Your site is live at [domain]. Enquiries go to your email."
        ↓
SITE IS OFFICIALLY LIVE
        ↓
48-HOUR POST-LAUNCH MONITORING
  → Day 1 AM: check site loads
  → Day 1 PM: check form submissions
  → Day 2: WhatsApp check-in with client
  → Day 3: confirm GA4 data flowing
  → Day 7: first mini traffic report
        ↓
ONGOING RETAINER BEGINS
  → Monthly report on the 1st
  → Content changes within 24hr
  → Performance monitoring weekly
```

---

## APPENDIX — COST SUMMARY

| Item | Cost | Who Pays | Frequency |
|------|------|----------|-----------|
| Domain (.com) | ~$10-12 | Absorbed into package | Annual |
| Domain (.co.za) | ~R100-150 | Absorbed into package | Annual |
| Vercel hosting | Free (up to 20 clients) | Max | Monthly |
| Vercel Pro | $20/month (20+ clients) | Max | Monthly |
| SSL certificate | Free (Vercel auto) | N/A | Automatic |
| GA4 | Free | N/A | N/A |
| Google Search Console | Free | N/A | N/A |
| Tally Free | Free (up to 100 subs/month) | Max | Monthly |
| Tally Pro | $29/month (10+ clients) | Max | Monthly |

**Total cost per client at current scale: ~R100-150/year (domain only)**
**Total platform costs at 20 clients: ~$49/month (Vercel Pro + Tally Pro)**

---

*This document supersedes any previous go-live process notes. The GO-LIVE-CHECKLIST.md remains the tactical step-by-step reference. This document provides the strategic decisions and client-facing templates that wrap around it.*
