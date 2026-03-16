---
name: 7thsense-locked-components
description: 'MUST READ FIRST before any 7thsense build. Defines locked structural components that never change between builds. The flexible design token layer (fonts, colours, radii, section order) applies ON TOP of these locked components — it cannot override them. If a differentiation decision would modify a locked component, the locked component wins.'
---

# 7thsense Locked Components

## The Two-Layer Rule

Every 7thsense build has two layers:

**LAYER 1 — LOCKED COMPONENTS (this skill)**
Solved problems. Proven solutions. The HTML structure, CSS behaviour, and implementation of these components NEVER changes between builds. The content inside them changes (business name, phone number, review text) but the structure never deviates.

**LAYER 2 — FLEXIBLE DESIGN TOKENS (handled by other skills)**
Legitimate variation: font choice, brand colour palette, border radius, section order, card style, divider style, CTA shape, animation direction. These tokens apply ON TOP of locked components via CSS variables. They cannot restructure locked components.

**OVERRIDE PRIORITY:**
1. Client branding assets (logo, extracted brand colours, real imagery) always win
2. Locked components define structure
3. Flexible tokens define visual skin
4. Niche defaults are fallback only

## Pre-Build Checklist

Before writing ANY code, confirm:
- [ ] I will implement every locked component exactly as specified below
- [ ] I will NOT restructure any locked component for "differentiation"
- [ ] Flexible tokens (font, colour, radius, etc.) will be applied via CSS variables only
- [ ] Client real data will replace all content placeholders
- [ ] I have read the hero-overlay.css component file

---

## LOCKED COMPONENT 1: Google Badge

The Google reviews badge uses the FULL Google wordmark SVG (all 6 colours), not a "G" icon. This is a non-negotiable trust signal.

### Structure (never changes):
```html
<div class="google-badge">
  <div class="google-badge-score">[RATING]</div>
  <div>
    <div class="google-badge-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
    <div class="google-badge-count">Based on [N] Reviews</div>
  </div>
  <div class="google-logo">
    <svg width="60" height="20" viewBox="0 0 272 92">
      <path d="M115.75 47.18c0 12.77-9.99 22.18-22.25 22.18s-22.25-9.41-22.25-22.18C71.25 34.32 81.24 25 93.5 25s22.25 9.32 22.25 22.18zm-9.74 0c0-7.98-5.79-13.44-12.51-13.44S80.99 39.2 80.99 47.18c0 7.9 5.79 13.44 12.51 13.44s12.51-5.55 12.51-13.44z" fill="#EA4335"/>
      <path d="M163.75 47.18c0 12.77-9.99 22.18-22.25 22.18s-22.25-9.41-22.25-22.18c0-12.85 9.99-22.18 22.25-22.18s22.25 9.32 22.25 22.18zm-9.74 0c0-7.98-5.79-13.44-12.51-13.44s-12.51 5.46-12.51 13.44c0 7.9 5.79 13.44 12.51 13.44s12.51-5.55 12.51-13.44z" fill="#FBBC05"/>
      <path d="M209.75 26.34v39.82c0 16.38-9.66 23.07-21.08 23.07-10.75 0-17.22-7.19-19.66-13.07l8.48-3.53c1.51 3.61 5.21 7.87 11.17 7.87 7.31 0 11.84-4.51 11.84-13v-3.19h-.34c-2.18 2.69-6.38 5.04-11.68 5.04-11.09 0-21.25-9.66-21.25-22.09 0-12.52 10.16-22.26 21.25-22.26 5.29 0 9.49 2.35 11.68 4.96h.34v-3.61h9.25zm-8.56 20.92c0-7.81-5.21-13.52-11.84-13.52-6.72 0-12.35 5.71-12.35 13.52 0 7.73 5.63 13.36 12.35 13.36 6.63 0 11.84-5.63 11.84-13.36z" fill="#4285F4"/>
      <path d="M225 3v65h-9.5V3h9.5z" fill="#34A853"/>
      <path d="M262.02 54.48l7.56 5.04c-2.44 3.61-8.32 9.83-18.48 9.83-12.6 0-22.01-9.74-22.01-22.18 0-13.19 9.49-22.18 20.92-22.18 11.51 0 17.14 9.16 18.98 14.11l1.01 2.52-29.65 12.28c2.27 4.45 5.8 6.72 10.75 6.72 4.96 0 8.4-2.44 10.92-6.14zm-23.27-7.98l19.82-8.23c-1.09-2.77-4.37-4.7-8.23-4.7-4.96 0-11.84 4.37-11.59 12.93z" fill="#EA4335"/>
      <path d="M35.29 41.19V32H67c.31 1.64.47 3.58.47 5.68 0 7.06-1.93 15.79-8.15 22.01-6.05 6.3-13.78 9.66-24.02 9.66C16.32 69.35.36 53.89.36 34.91.36 15.93 16.32.47 35.3.47c10.5 0 17.98 4.12 23.6 9.49l-6.64 6.64c-4.03-3.78-9.49-6.72-16.97-6.72-13.86 0-24.7 11.17-24.7 25.03 0 13.86 10.84 25.03 24.7 25.03 8.99 0 14.11-3.61 17.39-6.89 2.66-2.66 4.41-6.46 5.1-11.65l-22.49-.01z" fill="#4285F4"/>
    </svg>
  </div>
</div>
```

### CSS (locked — only colours vary via tokens):
```css
.google-badge {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  background: var(--white, #fff);
  border: 1px solid rgba(0,0,0,0.08);
  border-radius: var(--radius-md, 12px);
  padding: 14px 20px;
  margin-bottom: 18px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}
.google-badge-score {
  font-family: var(--font-heading);
  font-size: 2rem;
  font-weight: 800;
  color: var(--text-dark);
}
.google-badge-stars { color: #f59e0b; font-size: 0.9rem; letter-spacing: 2px; }
.google-badge-count { color: var(--text-muted); font-size: 0.72rem; margin-top: 1px; }
.google-logo { display: flex; align-items: center; font-size: 0; margin-left: 6px; }
```

### What varies: rating number, review count, Place ID link
### What NEVER varies: the full Google wordmark SVG, the badge structure, star rendering as HTML entities `&#9733;`

---

## LOCKED COMPONENT 2: Star Rendering

Stars are ALWAYS rendered as HTML entities, never as inline SVGs.

```html
<!-- CORRECT — lightweight, proven -->
<span class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span>

<!-- WRONG — bloated, unnecessary -->
<div class="stars">
  <svg>...</svg><svg>...</svg><svg>...</svg><svg>...</svg><svg>...</svg>
</div>
```

This applies to: hero rating badge, trust bar, review cards, Google badge.

---

## LOCKED COMPONENT 3: Review Card

### Structure:
```html
<div class="review-card">
  <div class="review-card-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
  <p>"[REAL VERBATIM GOOGLE REVIEW TEXT]"</p>
  <div class="review-card-author">
    <div class="review-card-avatar">[TWO-LETTER INITIALS]</div>
    <div>
      <div class="review-card-name">[REAL NAME]</div>
      <div class="review-card-src">Google Review</div>
    </div>
  </div>
</div>
```

### Locked rules:
- Review text MUST be real verbatim quotes from Google Reviews — never paraphrased, never invented (Rule 4)
- Avatar shows TWO-LETTER initials (e.g. "CB" not "C")
- Source always reads "Google Review"
- Stars use HTML entities, not SVGs
- If real review text cannot be obtained, mark with `<!-- VERIFY: Replace with actual Google review text -->` but NEVER ship generic placeholder text to a prospect

---

## LOCKED COMPONENT 4: Hero Overlay (Desktop)

The hero desktop overlay uses the EXACT values from `~/agency-templates/7thsense-system/components/hero-overlay.css`. Copy the relevant layout class.

### Default (image_right layout):
```css
@media (min-width: 1024px) {
  .hero {
    background:
      linear-gradient(
        to right,
        rgba(0, 0, 0, 0.75) 0%,
        rgba(0, 0, 0, 0.75) 45%,
        rgba(0, 0, 0, 0.20) 100%
      ),
      url('[HERO_IMAGE]') center/cover no-repeat;
  }
  .hero h1 { text-shadow: 0 2px 8px rgba(0,0,0,0.5); }
  .hero-sub { text-shadow: 0 2px 8px rgba(0,0,0,0.5); }
}
```

### Locked rules:
- Gradient direction matches the hero layout from hero-overlay.css (to right, to left, 135deg, 180deg)
- Text-side opacity is ALWAYS 0.75 — never lighter
- Image-side opacity is ALWAYS 0.20 — never darker
- text-shadow on ALL hero text elements
- NEVER deviate from these opacity values for "aesthetic" reasons

---

## LOCKED COMPONENT 5: Hero Rating Badge (clickable)

The hero always contains a clickable rating badge that links to the real Google Reviews page.

```html
<a href="https://search.google.com/local/reviews?placeid=[PLACE_ID]"
   target="_blank" rel="noopener" class="hero-rating">
  <span class="hero-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
  <span>[RATING] Google Rating</span>
</a>
```

### Locked rules:
- MUST be an `<a>` tag (clickable), not a `<div>`
- Links to real Google Reviews URL with verified Place ID
- Contains star entities + rating + "Google Rating" text
- Styled as a pill badge

---

## LOCKED COMPONENT 6: Trust Bar Stats

Trust bar stats show NUMBERS or SHORT VALUES. Never location names.

### Good examples:
```
5.0 — Google Rating
13 — Patient Reviews
12 — Services
Sat — Open Saturdays
88 — Years Combined Experience
FSP — Licence 2180
8 — Medical Aids Accepted
```

### Bad examples (NEVER do these):
```
Ocean View — Proudly Local     ← location name, says nothing
Cape Town — Our Home           ← same problem
Kommetjie — Community Based    ← same problem
```

### Rule: Every trust bar stat must answer "how much?" or "how many?" — never "where?"

---

## LOCKED COMPONENT 7: Floating Bottom Bar (Mobile)

```html
<div class="floating-bar" id="floatingBar">
  <div class="floating-bar-inner">
    <!-- If landline only: ONE button -->
    <a href="tel:[PHONE]" class="float-btn float-btn-primary">
      <svg><!-- phone icon --></svg> Call Now
    </a>

    <!-- If mobile number available: TWO buttons -->
    <a href="tel:[PHONE]" class="float-btn float-btn-outline">
      <svg><!-- phone icon --></svg> Call
    </a>
    <a href="whatsapp://send?phone=[MOBILE_NO_PLUS]" class="float-btn float-btn-whatsapp">
      <svg><!-- whatsapp icon --></svg> WhatsApp
    </a>
  </div>
</div>
```

### Locked rules:
- Maximum 2 buttons (Rule 5 / mobile CTA rules)
- WhatsApp ONLY if mobile number confirmed (Rule 3)
- WhatsApp button colour is ALWAYS `#25D366`
- WhatsApp uses `whatsapp://` protocol (works on mobile)
- Appears on mobile only (`display: none` on desktop >=1024px)
- Has `backdrop-filter: blur()` glass effect
- Respects `safe-area-inset-bottom` for iPhone notch

---

## LOCKED COMPONENT 8: Tally Contact Form

Always use the master component from `~/agency-templates/7thsense-system/components/contact-form.html`.

```html
<iframe
  data-tally-src="https://tally.so/embed/9qlQe4?alignLeft=1&hideTitle=1&transparentBackground=1&dynamicHeight=1&source=[CLIENT-NAME]"
  loading="lazy" width="100%" height="205"
  frameborder="0" marginheight="0" marginwidth="0"
  title="Contact Form">
</iframe>
```

Before `</body>`:
```html
<script>
var d=document,w="https://tally.so/widgets/embed.js",v=function(){"undefined"!=typeof Tally?Tally.loadEmbeds():d.querySelectorAll("iframe[data-tally-src]:not([src])").forEach(function(e){e.src=e.dataset.tallySrc})};if("undefined"!=typeof Tally)v();else if(d.querySelector('script[src="'+w+'"]')==null){var s=d.createElement("script");s.src=w;s.onload=v;s.onerror=v;d.body.appendChild(s);}
</script>
```

### Locked rules:
- Form ID is always `9qlQe4` (master form)
- `&source=[CLIENT-NAME]` parameter is ALWAYS set
- Never build a custom `<form>` element (Rule 16)
- Only ONE form embed per page

---

## LOCKED COMPONENT 9: Favicon

Favicons use an SVG data URI with brand primary colour and TWO-LETTER business initials.

```html
<link rel="icon" type="image/png" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' rx='20' fill='%23[HEX_NO_HASH]'/><text x='50' y='68' font-family='sans-serif' font-size='50' font-weight='bold' fill='white' text-anchor='middle'>[INITIALS]</text></svg>">
```

### Locked rules:
- NEVER use emoji favicons (🦷, 🏠, etc.) — they look unprofessional
- Background colour matches brand primary
- Text is white, bold, sans-serif
- Two-letter initials of business name (DS, T24, etc.)

---

## LOCKED COMPONENT 10: Animation Approach

All animations use IntersectionObserver with opacity transitions only.

```css
.fade-in {
  opacity: 0;
  transition: opacity 0.6s ease;
}
.fade-in.visible {
  opacity: 1;
}
```

```javascript
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('visible');
    }
  });
}, { threshold: 0.1 });
document.querySelectorAll('.fade-in').forEach(el => observer.observe(el));
```

### Locked rules:
- ONLY opacity transitions — no `translateY`, no `scale`, no parallax
- Use `.fade-in` class name (or `.animate-in` as alias)
- IntersectionObserver — not scroll event listeners
- `threshold: 0.1` — trigger early
- No animation libraries (no AOS, no GSAP, no Framer Motion)
- No `transform` in any animation

---

## LOCKED COMPONENT 11: Navigation Structure

```
Desktop (>=1024px):
[Logo] .............. [Link] [Link] [Link] [Link] [Link] ... [Phone] [CTA Button]

Mobile (<1024px):
[Logo] ............................................ [Hamburger ☰]
```

### Locked rules:
- Fixed position, `z-index: 1000`
- Transparent on hero → solid on scroll (with `backdrop-filter: blur`)
- Text-shadow on nav elements when transparent → removed when scrolled (per hero-overlay.css)
- Hamburger on mobile opens full-screen overlay menu
- Desktop shows all links + phone number + CTA button
- Desktop CTA button uses brand primary colour

---

## LOCKED COMPONENT 12: Footer Structure

```
Footer: dark charcoal background (var(--footer-bg) from config)
  Row 1: [Brand column] [Quick Links] [Services] [Contact Info]
  Row 2: Copyright + 7thsense credit
```

### Locked rules:
- Background is ALWAYS dark charcoal — never brand primary colour (Rule 1)
- Copyright year is current year
- Contains link to Google Reviews
- Contains all contact details (phone, email, address)
- Footer bottom padding accounts for mobile floating bar: `padding-bottom: 90px` on mobile

---

## LOCKED COMPONENT 13: Schema Markup

Every site includes LocalBusiness JSON-LD in `<head>`.

```json
{
  "@context": "https://schema.org",
  "@type": "[Niche-specific type: Dentist, InsuranceAgency, Plumber, etc.]",
  "name": "[BUSINESS_NAME]",
  "image": "[HERO_IMAGE_URL]",
  "telephone": "[PHONE]",
  "email": "[EMAIL]",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "[ADDRESS]",
    "addressLocality": "[CITY]",
    "addressCountry": "ZA"
  },
  "geo": {
    "@type": "GeoCoordinates",
    "latitude": "[LAT]",
    "longitude": "[LONG]"
  },
  "url": "[CANONICAL_URL]",
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "[RATING]",
    "reviewCount": "[REVIEW_COUNT]"
  },
  "openingHours": "[HOURS]"
}
```

### What varies: business type, all data values
### What NEVER varies: the schema structure and required fields

---

## LOCKED COMPONENT 14: Medical Aids Display (SA-specific)

For dental/medical niches, always include a medical aids section.

### Locked rules:
- List ONLY medical aids the business ACTUALLY accepts (Rule 4 — no invented claims)
- Display as a grid of recognisable names/logos
- Include section heading: "Medical Aids We Accept" or similar
- Add text: "Submit directly to your medical aid" or similar practical info

---

## LOCKED COMPONENT 15: WhatsApp Button Implementation

```html
<!-- Mobile only — use whatsapp:// protocol -->
<a href="whatsapp://send?phone=[NUMBER_NO_PLUS_NO_SPACES]" class="whatsapp-btn">
  <svg><!-- WhatsApp icon from Simple Icons --></svg>
  WhatsApp
</a>
```

### Locked rules:
- Colour is ALWAYS `#25D366` — never the brand colour
- Uses `whatsapp://` protocol (not `https://wa.me/` which doesn't work reliably on all devices)
- Phone number format: country code + number, no spaces, no plus (e.g. `27649447759`)
- ONLY present if the business has a confirmed MOBILE number (Rule 3)
- Never shown for landline numbers

---

## Summary Checklist

Before completing any build, verify:
- [ ] Google badge uses full 272x92 wordmark SVG (not just "G" icon)
- [ ] All stars rendered as HTML entities `&#9733;` (not SVGs)
- [ ] Review text is real verbatim quotes (not paraphrased or placeholder)
- [ ] Review avatars use TWO-letter initials
- [ ] Hero rating badge is clickable `<a>` tag linking to Google Reviews
- [ ] Hero overlay uses exact opacity values from hero-overlay.css (0.75/0.20)
- [ ] Trust bar stats are all numbers/short values (no location names)
- [ ] Floating bar has max 2 buttons, WhatsApp only if mobile number
- [ ] Tally form uses master component with `&source=` set
- [ ] Favicon uses brand-colour SVG with initials (no emoji)
- [ ] Animations are opacity-only (no transforms, no parallax)
- [ ] Footer is dark charcoal (never brand primary)
- [ ] Schema markup uses LocalBusiness JSON-LD
- [ ] WhatsApp button is `#25D366`, uses `whatsapp://` protocol

---

## LOCKED MODULE A: Hero Section

### Locked CSS (mobile-first):
```css
.hero{position:relative;display:flex;align-items:flex-start;background:var(--cream);padding:96px 0 48px;overflow:hidden}
.hero-content{position:relative;z-index:2}
.hero-badge{display:inline-flex;align-items:center;gap:8px;background:rgba(74,155,176,0.1);border:1px solid rgba(74,155,176,0.2);padding:7px 18px;border-radius:50px;color:var(--primary);font-size:0.72rem;font-weight:600;letter-spacing:2px;text-transform:uppercase;margin-bottom:24px}
.hero h1{margin-bottom:18px;max-width:620px;font-weight:800}
.hero-sub{color:var(--text-mid);font-size:1rem;max-width:500px;margin-bottom:24px;line-height:1.8}
.hero-trust{display:flex;flex-wrap:wrap;gap:14px;color:var(--text-mid);font-size:0.78rem;font-weight:500}
```

### Locked CSS (desktop >=1024px):
```css
.hero{min-height:100vh;align-items:center;padding:120px 0 64px;background:linear-gradient(to right,rgba(0,0,0,0.75) 0%,rgba(0,0,0,0.75) 45%,rgba(0,0,0,0.2) 100%),url('hero.png') center/cover no-repeat}
.hero h1{color:#fff;text-shadow:0 2px 8px rgba(0,0,0,0.5)}
.hero-sub{color:rgba(255,255,255,0.85);text-shadow:0 2px 8px rgba(0,0,0,0.5)}
.hero-badge{background:rgba(255,255,255,0.12);border-color:rgba(255,255,255,0.2);color:rgba(255,255,255,0.95)}
.hero-rating{background:rgba(255,255,255,0.1);border-color:rgba(255,255,255,0.15);color:#fff}
.hero-trust{color:rgba(255,255,255,0.65);text-shadow:0 1px 4px rgba(0,0,0,0.4)}
```

### Locked HTML:
- Location badge above headline (e.g. "OCEAN VIEW, CAPE TOWN")
- H1 headline
- Subtitle paragraph
- Clickable Google rating `<a>` tag with stars + "5.0 Google Rating"
- One primary CTA button (pill shape)
- Ghost CTA button (desktop only: Call number)
- Trust indicators: "All Medical Aids | Open Saturdays | 5.0 Google Rating"

### Conditional: Hero image MUST exist. Gradient-only hero is not acceptable.

---

## LOCKED MODULE B: Trust Strip

### Locked CSS:
```css
.trust-strip{background:var(--text-dark);padding:36px 0}
.trust-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px;text-align:center}
.trust-num{font-family:var(--font-heading);font-size:1.6rem;font-weight:800;color:var(--primary-light);line-height:1;margin-bottom:4px}
.trust-label{font-size:0.72rem;color:rgba(255,255,255,0.5);font-weight:500;letter-spacing:0.5px}
@media(min-width:768px){.trust-grid{grid-template-columns:repeat(4,1fr)}}
```

### Locked structure: Dark background, 4 stats, 2x2 on mobile, 4-col on desktop. Never single column.

---

## LOCKED MODULE C: Services (Image Cards)

### Locked CSS:
```css
.svc-card{background:var(--white);border-radius:var(--radius-md);overflow:hidden;box-shadow:var(--shadow-sm);border:1px solid rgba(0,0,0,0.04);transition:all var(--transition)}
.svc-card:hover{transform:translateY(-3px);box-shadow:var(--shadow-md)}
.svc-card img{width:100%;height:120px;object-fit:cover}
.svc-card-body{padding:14px 12px}
```

### Grid: 2-col mobile, 3-col tablet (768px+), 4-col desktop (1024px+)
### Each card MUST have: image top + service name + description. Never icon-only cards.
### Images sourced in order: Firecrawl real → stock → Gemini → brand-colour placeholder. Never blank.

---

## LOCKED MODULE D: Team Section

### Locked CSS:
```css
.team-card{background:var(--white);border-radius:var(--radius-md);overflow:hidden;box-shadow:var(--shadow-sm);border:1px solid rgba(0,0,0,0.04);text-align:center}
.team-card img{width:100%;height:180px;object-fit:cover;object-position:top}
.team-card-body{padding:14px 10px}
.team-card .team-role{color:var(--primary);font-size:0.7rem;font-weight:600;letter-spacing:0.5px}
```

### Grid: 2-col mobile, 4-col tablet/desktop
### Conditional: ONLY include if real team photos exist. Never generate AI faces. Never include with placeholder/empty cards.

---

## LOCKED MODULE E: Reviews Section

### Structure:
1. Google badge (272x92 wordmark) centered above heading — linked to Google reviews page
2. Eyebrow + H2 heading
3. Review cards grid: 1-col mobile, 2-col tablet, 3-col desktop
4. "Read all N reviews on Google" link below grid

### Conditional: ONLY include if business has real Google reviews. Never show empty or placeholder review cards.

### REVIEW SOURCING RULE:
If Firecrawl cannot extract reviews — use web search: '[business name] Google reviews rating'. Reviews from web search are acceptable for verified count and rating. Never omit the reviews component for a business that has real Google reviews.

---

## LOCKED COMPONENT 16: Faith Identity Display

When a law firm (or any business) identifies as faith-based on their existing site — this must be prominently displayed in the demo. Never bury faith identity in the bio only.

### Implementation:
1. **Top announcement bar** above the nav — first thing a visitor sees on any device
   - Background: slightly lighter than nav (e.g. #1B2B4B for navy sites)
   - Text: 12px, white, centred, with cross symbol
   - Example: "✝ A Christian Civil Litigation Firm — Serving All People with Faith, Strategy & Excellence"
2. **Hero bible verse** (desktop only) — below hero subtitle
   - Italic, 14px, subdued white (rgba 0.7)
3. **Attorney bio** — natural sentence about faith values
4. **Trust badge** — cross icon with "Faith-Based Firm" label

### When to apply:
- Only when the business explicitly identifies as faith-based on their real website
- Never assume or add faith identity that doesn't exist on the client's actual site
- Always frame as inclusive: "serving all people"

---

## LOCKED COMPONENT 17: See More Collapse

Any card grid section with more than 4 cards must implement show/hide with a See More button.

### Rules:
- First 4 cards always visible
- Cards 5+ get class `hidden-card` (display: none)
- "See More [Label] ↓" button below grid, pill shape, brand outline style
- On click: toggle `.show` class on hidden cards, change button text to "See Less ↑"
- Applies to: services, practice areas, and any other card grid exceeding 4 items
- Does NOT apply to: reviews (max 5 cards), team (max 4 cards), trust badges (small items)

### CSS (locked):
```css
.hidden-card { display: none; }
.hidden-card.show { display: block; }
.see-more-btn { display: flex; align-items: center; justify-content: center; gap: 8px; margin: 28px auto 0; padding: 12px 28px; border-radius: var(--radius-pill, 50px); border: 1.5px solid var(--primary); background: transparent; color: var(--primary); font-family: var(--font-heading); font-weight: 600; font-size: 0.85rem; cursor: pointer; transition: all 0.25s ease; }
.see-more-btn:hover { background: var(--primary); color: #fff; }
```

### JS (locked):
```javascript
function toggleCards(gridClass, btnId, label) {
  var cards = document.querySelectorAll('.' + gridClass + ' .hidden-card');
  var btn = document.getElementById(btnId);
  var showing = cards[0] && cards[0].classList.contains('show');
  cards.forEach(function(c) { if (showing) c.classList.remove('show'); else c.classList.add('show'); });
  btn.textContent = showing ? 'See More ' + label + ' ↓' : 'See Less ↑';
}
```

---

## Two-Pass Build Process

Every new site build must use two passes:

### Pass 1 — Write the HTML
Build the complete site HTML. Focus on content, structure, and niche intelligence application.

### Pass 2 — Locked Component Verification
After writing the HTML, run these grep checks before QA:

```bash
grep -c '&#9733;' index.html          # Stars as entities — must be >0
grep -c 'viewBox="0 0 272 92"' index.html  # Google wordmark — must be >0 if reviews exist
grep -c 'source=' index.html          # Tally source param — must be >0
grep -c 'data:image/svg' index.html   # SVG favicon — must be >0
grep -c 'hero-rating' index.html      # Clickable Google badge — must be >0 if reviews
grep -c 'floating-bar' index.html     # Mobile floating bar — must be >0
grep -c 'brand_identity' index.html   # Brand identity applied — must be >0
```

If any check returns 0 when it should be >0 — fix before running QA script.

---

## Pre-Build Module Checklist

Before completing any build, verify each module:
- [ ] Hero: image present? Gradient overlay applied? Text left desktop, centred mobile? Google badge linked?
- [ ] Trust strip: 4-col desktop? 2x2 mobile grid? Never wrapping? Dark background?
- [ ] Services: image cards not icon-only? All real services listed? 4-col desktop grid?
- [ ] Team: real photos available? If not, section omitted entirely?
- [ ] Reviews: real reviews available? Google wordmark present and linked? Two-letter avatars?
