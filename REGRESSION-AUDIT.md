# Regression Audit — OLD Dentist vs NEW Dr. Sonday

## A. REGRESSION AUDIT TABLE

| # | Element | OLD (dentist/) | NEW (dr-sonday/) | Classification | Verdict |
|---|---------|----------------|-------------------|----------------|---------|
| 1 | **Heading font** | Plus Jakarta Sans | Outfit | FLEXIBLE | Acceptable — different niche feel |
| 2 | **Google badge in reviews** | Full SVG Google wordmark (272x92, 6-colour) with rating score, stars, review count in a structured badge component | Small 24x24 Google "G" icon only. No wordmark. No structured badge. Rating/count shown as plain text above. | REGRESSION | The old badge was instantly recognisable as Google — a solved trust signal. The new one looks generic. |
| 3 | **Review text** | Real verbatim Google review quotes (Shelley Bright's R3500 vs R900 comparison, etc.) | Generic placeholder text ("Excellent service. Dr. Sonday and his team are professional...") marked with `<!-- DEMO: Replace with actual Google review text -->` | REGRESSION | Rule 4: never commit invented content. The old build had real quotes. The new one has placeholders that could ship to a prospect. |
| 4 | **Review card avatar** | Two-letter initials (CB, FR, SB, SF, PH) | Single-letter initial (C, S, F) | REGRESSION | Minor — but two initials are more personal and match Google's own UI convention. |
| 5 | **Trust bar stats** | `5.0` / `13` / `12` / `Sat` — all numeric/short, no location names | `5.0` / `13` / `8` / `Ocean View` — last stat uses a location name | REGRESSION | Trust bars should show universally impressive numbers, not place names. "Ocean View" communicates nothing to someone who doesn't know the area. OLD used "Sat" (Open Saturdays) which is more useful. |
| 6 | **Trust bar stat: services count** | `12` Services | `8` Medical Aids Accepted | FLEXIBLE | Different metric, both valid. New one may be more relevant for SA dental. |
| 7 | **Hero mobile background** | Solid cream/off-white `#FAFAFA` on mobile | Solid teal `var(--primary)` on mobile | FLEXIBLE | Acceptable — both approaches work. New version uses brand colour more boldly. |
| 8 | **Hero desktop overlay** | `linear-gradient(to right, rgba(0,0,0,0.75) 0%, rgba(0,0,0,0.75) 45%, rgba(0,0,0,0.2) 100%)` — matches hero-overlay.css component exactly | Same approach but checking... `background: linear-gradient(135deg, rgba(0,0,0,0.65) 0%, rgba(0,0,0,0.35) 100%)` — diagonal, lighter | REGRESSION | Old build used the exact hero-overlay.css component (Rule 15). New build deviates — lighter opacity (0.65/0.35 vs 0.75/0.75/0.20), different gradient direction (135deg vs to right). Text may be less readable. |
| 9 | **Floating bottom bar** | Not present (old build) | Present — Call + WhatsApp, properly styled | IMPROVEMENT | Modern mobile pattern. Good addition. |
| 10 | **Hero rating badge** | Linked pill badge: `★★★★★ 5.0 Google Rating` → clicks to Google Reviews page | Star SVGs + text "5.0 rating · 13 Google Reviews" — not a link, not a pill | REGRESSION | The old clickable pill badge was a proven conversion element. Link to real Google reviews = social proof amplifier. New version lost the link and the badge structure. |
| 11 | **Animations** | `fade-in` class with IntersectionObserver (opacity only, no transform) | `animate-in` class — need to check if transform is used | CHECK | Old approach matches CLAUDE.md (opacity only). Need to verify new approach. |
| 12 | **Review star rendering** | HTML entities `&#9733;` (simple, lightweight) | SVG polygon per star (5 SVG elements per review × 3-5 reviews = 15-25 SVGs) | REGRESSION | Massive code bloat. 5 inline SVGs per star row × 3 reviews + trust bar + hero = ~40 star SVGs. The old approach used a single HTML entity string. Same visual result, 10x less code. |
| 13 | **Section order** | Hero → Trust → Team → Services → Reviews → Med Aids → Contact | Hero → Trust → Services → Reviews → Med Aids → FAQ → Contact | FLEXIBLE | Different section order is a valid differentiation lever. |
| 14 | **Footer colour** | Dark charcoal | Dark charcoal | LOCKED | Both correct. |
| 15 | **Tally form implementation** | Correct: iframe with `data-tally-src`, form ID `9qlQe4`, `source=dr-sonday`, Tally loader script | Correct: same implementation | LOCKED | Both correct — component used properly. |
| 16 | **WhatsApp button colour** | `#25D366` | `#25D366` | LOCKED | Both correct. |
| 17 | **Schema markup** | LocalBusiness JSON-LD with real data | LocalBusiness JSON-LD with real data | LOCKED | Both present. |
| 18 | **Google Reviews link format** | `https://search.google.com/local/reviews?placeid=ChIJZ61zaEFrzB0RqVIYufiLzY8` | Same | LOCKED | Both correct. |
| 19 | **Medical aids section** | 8 medical aid logos in a grid | 8 medical aid pills/badges | FLEXIBLE | Different visual treatment, same content. |
| 20 | **Contact section structure** | Info panel (left) + Tally form (right) | Same two-column pattern | LOCKED | Both correct. |
| 21 | **Nav scroll behaviour** | Transparent → solid on scroll, text-shadow removed on scroll | Same approach | LOCKED | Both correct. |
| 22 | **Mobile menu** | Full-screen overlay, clean links, close button | Same pattern | LOCKED | Both correct. |
| 23 | **Favicon** | SVG data URI with brand colour + "DS" initials | Emoji tooth 🦷 data URI | REGRESSION | Tooth emoji looks unprofessional. Old approach (brand colour + initials) is more polished. |
| 24 | **Canon/OG meta** | No canonical, basic OG | Full canonical, OG URL, twitter card, theme-color | IMPROVEMENT | New build has better SEO meta. |
| 25 | **Font preloading** | No preload | `rel="preload" as="style"` for Google Fonts | IMPROVEMENT | Better LCP. |
| 26 | **CSS architecture** | Minified single-line CSS | Well-commented, structured CSS with section headers | IMPROVEMENT | Much more maintainable. |
| 27 | **FAQ section** | Not present | Present with accordion | IMPROVEMENT | Good addition — answers common questions. |
| 28 | **Divider elements** | Not present | `<div class="divider">` between sections | FLEXIBLE | Design choice — acceptable variation. |
| 29 | **Hero trust items (desktop)** | Three trust items with checkmarks: "All Medical Aids", "Open Saturdays", "5.0 Google Rating" | Similar but styled as a single line | FLEXIBLE | Both acceptable. |

## REGRESSION SUMMARY

**Regressions that must be fixed (would embarrass if sent to prospect):**
1. Google badge lost full wordmark SVG — now looks generic
2. Review text uses placeholder copy, not real Google quotes
3. Hero rating badge lost clickable link to Google Reviews
4. Trust bar uses "Ocean View" location name instead of useful stat
5. Star rendering bloated from HTML entities to 40+ inline SVGs
6. Hero overlay deviates from locked component (lighter, diagonal)
7. Favicon uses emoji instead of brand-coloured initials
8. Review avatars use single initial instead of double

**Improvements to keep:**
1. Floating bottom bar (Call + WhatsApp)
2. Full SEO meta (canonical, OG, twitter card, theme-color)
3. Font preloading
4. Well-commented CSS architecture
5. FAQ section
