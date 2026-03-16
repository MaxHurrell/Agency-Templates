# C. New CLAUDE.md Rules — Rule 17 onwards

Add these rules to the 16 HARD RULES section in both `~/.claude/CLAUDE.md` and `~/agency-templates/CLAUDE.md`.

---

17. **LOCKED COMPONENTS:** Read the `7thsense-locked-components` skill FIRST before any build. Locked components (Google badge, star rendering, review cards, hero overlay, floating bar, Tally form, favicon, animations, nav, footer, schema) define structure that never changes. Flexible design tokens (fonts, colours, radii) apply on top — they cannot restructure locked components. If a differentiation decision would modify a locked component, the locked component wins.

18. **GOOGLE BADGE:** The Google reviews badge must use the full 272x92 Google wordmark SVG with correct 6-colour rendering. Never use a small "G" icon or plain text "Google." The badge structure (score + stars + count + wordmark) is a locked component.

19. **STAR RENDERING:** Stars are always rendered as HTML entities (`&#9733;`) — never as inline SVG elements. This applies to hero badges, trust bars, review cards, and Google badges. Five SVGs per star row is unnecessary code bloat.

20. **REVIEW TEXT:** Review card text must be real verbatim quotes copied from Google Reviews. Never paraphrase. Never invent. If real review text cannot be obtained, add an HTML comment `<!-- VERIFY: Replace with actual review text -->` but never ship generic placeholder text ("Excellent service..." etc.) to a prospect.

21. **REVIEW AVATARS:** Review card avatars always show TWO-LETTER initials (e.g. "CB", "SF") — never single letters. Two initials match Google's own convention and feel more personal.

22. **HERO RATING LINK:** The hero section must contain a clickable `<a>` tag linking to the real Google Reviews page (`https://search.google.com/local/reviews?placeid=[ID]`). Never render the rating as a non-clickable `<div>`. The link turns social proof into a verifiable trust signal.

23. **TRUST BAR STATS:** Trust bar statistics must show numbers or short values that answer "how much?" or "how many?" — never location names. "5.0", "13", "Sat", "88" are good. "Ocean View", "Cape Town" are bad — they waste a trust slot on information that communicates nothing about quality.

24. **FAVICON:** Favicons use an SVG data URI with the brand primary colour background and two-letter business initials in white. Never use emoji favicons (tooth, house, etc.) — they look unprofessional in browser tabs.

25. **DATA VERIFICATION:** Before deploying any demo, cross-check phone number, address, operating hours, and Google review count against the business's Google Maps listing. If any data cannot be verified, mark it in the niche config as `"verified": false` and flag to Max before sending the demo.

26. **IMAGE FILE VERIFICATION:** Before deploying, verify every `<img src="...">` in the HTML points to a file that exists in the project directory. Never deploy a site with broken image references.

---

## Updated Rule 7 (replaces existing):

7. **Never use Unsplash.** Image pipeline is: Firecrawl extraction → Gemini generation with locked briefs → cropped/recoloured client image fallback. Stock photos are permanently removed from the pipeline.

---

# E. QA Script Additions

Add these checks to `~/agency-templates/7thsense-system/scripts/qa-pre-deploy.sh`:

```bash
# ─── LOCKED COMPONENTS (Rules 17-26) ───
echo ""
echo "--- Locked Components ---"

# Rule 18: Google badge must use full wordmark SVG
if grep -q 'viewBox="0 0 272 92"' "$HTML"; then
  pass "Google wordmark SVG (272x92) present"
else
  if grep -qi 'google' "$HTML" && grep -qi 'review\|rating' "$HTML"; then
    fail "Google reviews present but full wordmark SVG (272x92) missing — use locked component"
  fi
fi

# Rule 19: Stars as HTML entities, not SVGs
STAR_SVGS=$(grep -c 'polygon.*points="12 2 15.09' "$HTML" 2>/dev/null || echo "0")
if [ "$STAR_SVGS" -gt 0 ]; then
  fail "Star SVGs detected ($STAR_SVGS instances) — use HTML entities &#9733; instead (Rule 19)"
else
  pass "No star SVG bloat detected"
fi

# Rule 20: No generic review placeholders
for generic in "Excellent service" "always a pleasant experience" "Best dentist in the area" "wonderful and caring" "highly professional team"; do
  if grep -qi "$generic" "$HTML"; then
    warn "Possible generic review text detected: '$generic' — verify this is a real verbatim Google quote"
  fi
done

# Rule 21: Review avatars — two-letter initials
# Check for single-letter avatar content (heuristic: look for avatar divs with 1 char)
SINGLE_INITIAL=$(grep -cP 'avatar">[A-Z]</' "$HTML" 2>/dev/null || echo "0")
DOUBLE_INITIAL=$(grep -cP 'avatar">[A-Z]{2}</' "$HTML" 2>/dev/null || echo "0")
if [ "$SINGLE_INITIAL" -gt 0 ] && [ "$DOUBLE_INITIAL" -eq 0 ]; then
  fail "Review avatars use single-letter initials — must be two letters (Rule 21)"
fi

# Rule 22: Hero rating must be a clickable link
if grep -q 'hero-rating' "$HTML" || grep -q 'hero.*rating' "$HTML"; then
  if grep -q '<a.*hero.*rating\|hero.*rating.*<a\|<a.*Google Rating' "$HTML"; then
    pass "Hero rating is a clickable link"
  else
    fail "Hero rating found but not wrapped in <a> tag — must link to Google Reviews (Rule 22)"
  fi
fi

# Rule 24: No emoji favicons
if grep -q "favicon.*emoji\|'🦷'\|'🏠'\|'⚖'\|'🔧'\|'💈'" "$HTML"; then
  fail "Emoji favicon detected — use SVG with brand colour + initials (Rule 24)"
fi

# Rule 26: Verify image files exist
echo ""
echo "--- Image File Verification ---"
HTML_DIR=$(dirname "$HTML")
MISSING_IMAGES=0
for img_src in $(grep -oP 'src="([^"]+\.(png|jpg|jpeg|webp|svg))"' "$HTML" | grep -oP '"[^"]*"' | tr -d '"' | grep -v '^http' | grep -v '^data:'); do
  if [ ! -f "$HTML_DIR/$img_src" ]; then
    fail "Missing image file: $img_src"
    MISSING_IMAGES=$((MISSING_IMAGES + 1))
  fi
done
if [ "$MISSING_IMAGES" -eq 0 ]; then
  pass "All local image files exist"
fi
```

---

# F. Updated Skill Reading Order

```
1. 7thsense-locked-components  ← NEW — read FIRST, defines what cannot change
2. 7thsense-niche-intelligence — research + design decisions document
3. 7thsense-systems-architect  — technical blueprint
4. 7thsense-visual-system      — design tokens (applied ON TOP of locked components)
5. 7thsense-copy-architect     — copy before layout
6. 7thsense-image-agent        — images before final build
7. ui-ux-pro-max               — international UX standards
8. page-cro                    — conversion pass
9. seo-technical               — SEO pass
```

Note: `bencium-innovative-ux-designer` removed from the mandatory order (it doesn't exist as an installed skill and has caused confusion).

---

# G. Honest Assessment and Revised Score

## Previous Score: 6.5/10
## Revised Score (after locked components implemented): 7.5/10

### What this session adds (+1.0):
- **Locked components skill** eliminates the most damaging regression category (structural components being "differentiated" away)
- **10 new rules** (17-26) close the gaps identified in the previous audit
- **QA script additions** make 6 of the new rules machine-verifiable
- **Regression audit** creates a permanent record of what went wrong and why
- **Updated skill reading order** puts locked components first

### What it doesn't solve (remaining gaps to 10/10):
- **No human visual review step** (-0.5) — still not enforced. The VISUAL-PRE-SEND-CHECKLIST.md hasn't been created yet.
- **Single Tally form** (-0.5) — still breaks at 2 clients. Needs per-client form creation at go-live.
- **Missing operational files** (-0.5) — prospect-tracker.md, build-history.md, invoice template still don't exist.
- **No analytics on demos** (-0.25) — can't tell if prospects view the site.
- **MASTER_BRIEF.md section 13 still stale** (-0.25) — TODO list references solved problems.

### The One Remaining Risk That Could Still Cause Regression:

**Claude Code context window limits.** The locked-components skill is ~400 lines. Combined with CLAUDE.md rules, niche config, 8 other skills, and the HTML being built, a single build session is pushing context limits. If the locked-components skill gets compressed or truncated mid-build, Claude Code will fall back to its own judgement — which is exactly how the regressions happened in the first place.

**Mitigation:** The QA script now catches the most visible regressions (star SVGs, missing Google wordmark, single-letter avatars, emoji favicons, broken images). Even if Claude Code forgets a rule mid-build, the QA script blocks deployment until it's fixed. This is the safety net.
