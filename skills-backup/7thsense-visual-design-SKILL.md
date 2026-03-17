---
name: 7thsense-visual-design
description: 'Senior brand designer perspective on visual quality. Evaluates colour harmony, typographic hierarchy, brand coherence, niche fit, and visual polish. Catches aesthetic failures before they reach the prospect. Read this skill when evaluating any built site, choosing colours, placing visual elements, or assessing whether a design matches its niche.'
---

# 7thsense Visual Design Skill

## Core Principle

Every design decision must pass three tests:
1. Does it belong to this brand? (brand coherence)
2. Does it serve the visitor's emotional state? (niche fit)
3. Does it look intentional? (visual polish)

If any answer is no — redesign before shipping.

## Niche Visual Language

### Law
Authoritative, restrained, confident. Navy backgrounds. Gold accents used sparingly and precisely. Typography is serious — never playful. Photography is professional, never stock-looking. White space signals confidence. No gradients that look "web agencyish". The visitor is in crisis or under financial pressure — the design must communicate immediate trust.

### Dental
Warm, clinical, reassuring. Teal-blue palette. Soft whites and light backgrounds below the fold. Family-friendly imagery. Approachable not sterile — like a good dentist's waiting room. Rounded corners, gentle animations, soft shadows.

### Aesthetics / MedSpa
Aspirational, luxurious, results-focused. Warm peach or rose-gold tones. High-end spa aesthetic — think glossy magazine not hospital. Before/after framing. The practitioner IS the brand — their photo must feel premium. Never cold or clinical.

### Insurance
Stable, trustworthy, local. Green tones. Community feel. Friendly not corporate. The visitor wants to feel protected, not sold to.

## Colour Harmony Rules

- Peach/warm tones → beauty, aesthetics, femme wellness. Never for law or dental.
- Navy/gold → law, finance, authority, trust. Classic and timeless.
- Teal/blue → dental, medical, calm, clean. Clinical warmth.
- Dark green → insurance, sustainability, stability.
- Accent colours must appear in at least 3 places to feel intentional (CTA button, split headline word, badge/stat number). If used once it looks like an error.
- Announcement bars above the nav: only use if the message is a genuine core brand signal AND the colour matches the nav palette. A clashing bar colour signals amateur work. If unsure — omit it.
- Never add a design element just because you can. Every element must earn its place.

## Typographic Hierarchy Rules

- Hero headline must be the largest, boldest, most emotionally resonant text on the page
- Split colour on exactly 1-2 words creates a focal point — never split more than 2 words
- Subheadline must be meaningfully smaller and lighter than headline — never the same size
- Section eyebrow labels (small caps, tracked out, above heading) signal professionalism — use them
- Body text must never exceed 65 characters per line on desktop — add max-width to paragraphs
- Button text must be short — 2-4 words maximum. "Free Consultation" not "Click Here to Book a Free Consultation"

## Visual Element Placement

- Bible verses, taglines, or brand statements overlaid on hero images must have sufficient text-shadow or semi-transparent backing to guarantee readability at all image states
- Absolute positioned elements in heroes must be tested at desktop, tablet, and mobile — they frequently break at 768-1024px
- Faith identity elements (verses, crosses) must feel like intentional brand design, not copy-pasted afterthoughts. They need proper sizing, colour, and positioning that respects the existing visual hierarchy
- Logo in nav must be properly sized — typically 36-48px tall, never stretched or pixelated

## Logo Rules

- If client has a logo on their existing site — it must be used
- Extract via Firecrawl: look for img tags near header/nav containing keywords: logo, brand, mark, header-logo
- Display at height: 40-48px, width: auto — never distort aspect ratio
- If logo is dark and nav is dark — check if a light/reversed version exists
- If no logo available — text logo is acceptable but must be styled to match brand (correct font, correct colour, correct weight)
- Never use emoji or generic icons as a logo placeholder

## Common Visual Failures — Catch Before Shipping

| Failure | Why It's Bad | Fix |
|---------|-------------|-----|
| Announcement bar in clashing colour | Looks like a system alert, not a brand element | Remove it or match nav colour exactly |
| Hero gradient too dark on right side | Hides the image — the photo should breathe | Fade to rgba(0,0,0,0.08) at 100% |
| White/cream mobile hero background with white text | Critical contrast failure — text invisible | Dark brand colour background on mobile |
| Transparent nav on mobile | Nav text invisible against hero | Solid dark background on mobile always |
| Accent colour used only once | Looks like an error, not a design decision | Use accent in 3+ places or remove it |
| Trust strip with location name as stat | Wastes a stat slot — locations aren't trust signals | Use a real number or measurable fact |
| Section backgrounds all the same colour | Page feels flat and unending | Alternate between white, light, and dark sections |
| CTA button same colour as section | Button disappears into background | Ensure 3:1 contrast ratio minimum |
| Broken image with visible alt text | Destroys professional impression instantly | Always add onerror fallback |
| Oversized team photo placeholder | Empty space screams "unfinished" | Branded initials block at correct aspect ratio |

## Visual Critique Process

When reviewing any built site, ask in this order:
1. Does the colour palette match the niche emotional register?
2. Is there visual hierarchy — does the eye know where to go first, second, third?
3. Are there any elements that look like accidents?
4. Does the hero make a strong first impression in under 3 seconds?
5. Does mobile feel as intentional as desktop?
6. Would a business owner in this niche feel proud to show this to their best client?
7. Is the logo present and correctly used?
8. Are all brand identity signals (faith, tagline, philosophy) applied with design intent?

If any answer is no — provide a specific fix with exact CSS/HTML, not a vague suggestion.

## When to Read This Skill

- Before finalising any new build
- When choosing a colour palette for a new niche
- When placing any hero overlay element (verse, tagline, badge)
- When evaluating a screenshot or visual feedback from Max or Tristan
- When the council reviews demo quality before outreach
