# The 3-Minute Demo

**Day 3 · Session 4** · SwiftUI Digital Prototyping · SG Code Campus

You demo twice: once to your group of five at 15:40, and — if your group nominates you — once to the whole room at 16:25. Same structure both times.

---

## The structure

| Part | Time | What you say |
| --- | --- | --- |
| **1 · What it is** | 20 sec | One sentence. "This is a ___ for people who ___." |
| **2 · Who it is for** | 10 sec | One real person. Not "everyone". |
| **3 · Show one path** | 90 sec | Drive the app. Talk while you tap. |
| **4 · One thing I am proud of** | 30 sec | A decision you made, not a feature you added. |
| **5 · One thing I would add next** | 30 sec | Straight from your cut list. |
| | **3:00** | |

---

## Part 1 · What it is (20 seconds)

Fill this in and say it exactly:

> "This is a **_____________________** for people who **_____________________**."

Examples:

- "This is a **packing list** for people who **travel for work every week**."
- "This is a **study flashcard app** for people who **are learning kanji**."
- "This is an **expense log** for people who **share a house and split bills**."

Write it down and say it word for word. The first ten seconds are where people freeze, and a memorised sentence removes that entirely.

---

## Part 2 · Who it is for (10 seconds)

One person. Ideally a real one.

> "It is for my sister, who runs a small catering business and keeps her orders on paper."

Naming one person makes every design choice you made look deliberate. Saying "everyone" makes them all look arbitrary.

---

## Part 3 · Show one path (90 seconds)

**One** path. Start to finish. The path you rehearsed at 14:50.

A good path is usually:

```
open on the list  ->  tap one row  ->  show the detail  ->  come back
                  ->  add something  ->  show it appear in the list
```

**Talk while you tap.** Narrate what you are doing and why:

> "So here is the list of my recipes. Each one has a region and an icon. I tap Rendang… and this is the detail screen, with the method underneath. Back… and now I will add a new one. Notice the Save button is grey — it will not let me save without a name. I type one… and there it is, at the bottom."

**Do not:**

- Show code, unless someone asks.
- Show more than one path. You do not have time and nobody needs it.
- Scroll through every screen you built. Depth beats breadth.
- Explain how it works internally. Show what it does.

---

## Part 4 · One thing you are proud of (30 seconds)

A **decision**, not a feature.

| Weak | Strong |
| --- | --- |
| "I added a slider." | "I used a slider instead of a text field so you cannot type a nonsense number." |
| "It has icons." | "Each category gets its own icon, so you can find things without reading." |
| "Validation works." | "The Save button stays off rather than showing an error. It felt less like being told off." |

This is the part that makes a prototype look like design work rather than an exercise. Prepare it. Do not improvise it.

---

## Part 5 · One thing you would add next (30 seconds)

Take it straight from your cut list on the planning worksheet.

> "The next thing would be saving the data, so it is still there when you close the app. That is `UserDefaults`, which is week three on my next-steps list."

Naming what you would build next shows you understand the boundary of what you made. It is a strength, not an admission.

---

## Before you stand up

- [ ] The app is **already running** in the simulator. Not Xcode.
- [ ] Xcode itself is minimised or behind the simulator.
- [ ] Your simulator is on a phone-sized device, not an iPad.
- [ ] Your screenshot from 14:55 is open in a second window, in case.
- [ ] Your one sentence is written down where you can see it.
- [ ] You have said it out loud once, quietly, to your own screen.

**Never open Xcode in a demo.** The first thing the audience sees should be the app.

---

## The four rules

### 1 · Do not apologise

Every prototype in this room is missing something. That is what a prototype is. Saying "sorry, it is not finished" in the first ten seconds teaches the audience to look for faults.

Say what it **does**. Let the gaps be gaps.

### 2 · If it crashes, keep talking

Do not debug in front of people. Ever.

> "It has just crashed — that is a prototype for you. Let me show you the screenshot and walk you through the same path."

Then talk over your screenshot with exactly the same five parts. Every professional demo has been given over a still image at some point. Nobody who matters will hold it against you.

### 3 · Watch the clock

Three minutes is short. Your first rehearsal will run to six. That is normal.

The usual fix is Part 3: pick **one** path, not three.

### 4 · Take one question

One. Then stop and hand over. Questions are where three minutes becomes eight.

---

## Plenary showcase — the extra rules (16:25)

If your group nominates you:

- **Set up while the person before you demos.** Get your simulator running and your app open before you stand up. This is how six demos fit in twenty-five minutes.
- Your slot is **4 minutes**: the same three-minute structure, plus one question from the room.
- The facilitator will raise a hand silently at 30 seconds left. Start wrapping up.
- At 4:00 you will be thanked and stopped. It is not a judgement, it is arithmetic.

---

## A worked example — the full three minutes

> **[App already running, showing a list of dishes]**
>
> "This is a **recipe box** for people who **cook the same ten dishes and keep forgetting the details**. It is for my flatmate, who calls me every Sunday to ask how long the rendang takes.
>
> Here is the list — six recipes, each with the region it comes from and an icon for the type of dish. I tap Soto Ayam… and this is the detail screen: the region again at the top, then the method underneath. There is a star because I marked it as a favourite. Back.
>
> Now I will add one. Plus button, top right. The Save button is grey — it will not let me save without a name. I type 'Gado-Gado', pick an icon, turn on the favourite switch… Save is blue now… and there it is at the bottom of the list.
>
> The thing I am most pleased with is that Save button. My first version showed a red error when you pressed it with an empty name. Turning the button off instead felt much less like being told off, and it was one line of code.
>
> The next thing I would add is saving the data properly, so the recipes are still there when you close the app. That is `UserDefaults`, and it is week three on my list.
>
> Thank you."

Two minutes fifty. Five parts. One path. No apology.
