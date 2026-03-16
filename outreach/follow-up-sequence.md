# Follow-Up Sequence — After Demo Sent, No Response

## Timing Rules
- Clock starts from the FIRST message (WhatsApp or email)
- If they replied at any point (even "thanks"), reset the clock and adjust tone
- If they said "not interested" — stop immediately, no follow-up
- All follow-ups via WhatsApp unless first touch was email-only

## Tally Demo Notifications
During the demo phase, all form submissions go to maxhurrellsa@gmail.com — NOT to the prospect. If someone submits a contact form on a demo site, that's a sales signal for Max to use in follow-up.

---

## Day 1 — Soft Nudge

**Channel:** WhatsApp

> Hi [FIRST NAME] — just checking the link came through okay. Sometimes WhatsApp buries things.
>
> [DEMO URL]
>
> No rush at all.

**Why:** Gives them an excuse instead of implying they ignored you. Re-sends the link.

---

## Day 3 — Add a Hook

**Channel:** WhatsApp

**If a Tally form submission came in (Max received it):**

> Hi [FIRST NAME] — just a heads up, someone actually tried to contact [BUSINESS NAME] through the demo site I built. I got the notification on my end since it's still a demo.
>
> That's exactly the kind of lead a proper site catches for you. Worth a quick chat?

**If no form submission — use a niche-specific hook:**

> Hi [FIRST NAME], one thing I noticed — [BUSINESS NAME] has [X] Google reviews at [X] stars. That's really strong.
>
> The site I built shows those front and centre so new customers see that trust immediately. Happy to chat for 5 mins if you're interested.

**Niche alternates:**
- **Dentist/Medical:** "I noticed you accept [X] medical aids — the site lists all of them so patients can check before calling."
- **Insurance:** "The site shows your FSP number and compliance details up front — builds trust before they even call."
- **Plumber/Trades:** "The site has a click-to-call button for mobile — for emergencies, that's the difference between getting the job or not."
- **Beauty/Spa:** "The site makes it easy for people to book without having to call during your busy hours."

---

## Day 7 — Last Genuine Attempt

**Channel:** WhatsApp

> Hi [FIRST NAME] — last message from me, I promise.
>
> The demo for [BUSINESS NAME] is still live: [DEMO URL]
>
> If the timing's not right, no stress. Drop me a message whenever — the offer stands.
>
> All the best with [BUSINESS NAME].

**Why:** Shows respect. "Last message" creates honest urgency. Open door means they can come back in months without awkwardness.

---

## Day 14 — Archive

**No message sent.** Internal step only.

1. Update `prospect-tracker.md` — status: `archived — no response`
2. Keep demo live 90 days (Vercel free tier, zero cost)
3. Repurpose decision:
   - Can this demo become a niche template for the next business in that category?
   - Can it be shown to a different business in the same niche? (Swap name/details, redeploy)
4. If repurposing: duplicate folder, update config, rebuild with new data

---

## Reply Handling

**Positive ("looks great", "how much", "can we talk"):**
- Respond within 1 hour
- Move to a 5-minute phone call — don't sell over text
- Walk them through the site on their phone during the call
- Send package summary AFTER the call, not before

**Neutral ("I'll have a look", "thanks"):**
- Reply: "No rush — let me know what you think when you've had a chance."
- Wait 3 days, then send Day 3 hook

**Negative ("not interested", "we're sorted"):**
- Reply: "No problem at all, [FIRST NAME]. All the best with [BUSINESS NAME]."
- Update prospect-tracker: `declined`
- No further follow-up

**Price question ("how much?"):**
- Reply: "Depends on what you need — packages start from R7,500. Can I call you for 5 minutes to figure out what makes sense?"
- If they insist on text: send package summary, then follow up with a call offer
