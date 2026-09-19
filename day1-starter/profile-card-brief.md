# Project Brief · Profile Card

**Day 1 deliverable** · SwiftUI Digital Prototyping · SG Code Campus
**Exercise 1.9** · Time box: 45 minutes · Session 4 (15:15 – 17:00), build starts around 15:58

---

## The task

Build one screen: a Profile Card for yourself. Real name, real role, real city.

It does not move. Nothing is tappable. That is correct for today — a prototype screen that looks right is a genuine deliverable, and tomorrow we make it react.

---

## The brief, in one sentence

> A single card, centred on the screen, showing who you are: a picture, your name, what you do, where you are, and one line of text that your own code produced.

---

## Must-haves

All five. Do these before anything decorative.

| # | Requirement | You will use |
| --- | --- | --- |
| 1 | An avatar image, correctly sized and circular | `Image(systemName:)`, `.resizable()`, `.scaledToFit()`, `.frame()`, `.clipShape(Circle())` |
| 2 | Your name and your role, on separate lines | `Text`, `.font()`, `.bold()`, `.foregroundStyle()` |
| 3 | A location row: an icon beside a place name | `HStack`, `Image(systemName: "mappin.and.ellipse")` |
| 4 | One line of text produced by a function you wrote | `func … -> String`, then `Text(yourFunction(...))` |
| 5 | A card look: inner padding, background, rounded corners, outer space | `.padding()`, `.frame(maxWidth: .infinity)`, `.background()`, `.clipShape()`, `.padding()` |

### The card recipe

Apply these after the closing brace of your outer `VStack`:

```swift
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(20)
```

Two paddings: one **inside** the background, one **outside** it. That is modifier order doing real work.

---

## Nice-to-haves

Only start these once all five must-haves are on screen and the project builds.

| Feature | Hint |
| --- | --- |
| An availability line driven by `if/else` | `let isAvailable = true` on the struct, then `if isAvailable { … } else { … }` in `body` |
| A row of skill tags | Write a small `struct SkillTag: View` and use it three times inside an `HStack` |
| A ring and a shadow on the avatar | `.overlay(Circle().stroke(.white, lineWidth: 3))` then `.shadow(radius: 6)` |
| A green status badge on the avatar | `ZStack(alignment: .bottomTrailing)` with a small `Circle().fill(Color.green)` |
| A years-of-experience line with correct singular and plural | `yearsLabel(years:)` from Exercise 1.6 |
| Your own colour scheme | Replace `.blue` and `Color(.systemGray6)` with colours you like |

---

## Rules for today

- **No `@State`.** No buttons. No navigation. Those are Day 2.
- The only control flow in a view is `if/else` on a constant.
- Use SF Symbols for images. You do not need to download or add any files.
- If you want a real photo, add it to `Assets.xcassets` and keep an SF Symbol fallback so the project still builds without it. See the `02-profile-card` README.

---

## Suggested order of work

| Minutes | Clock | Do this |
| --- | --- | --- |
| 0 – 5 | 15:58 | Open your `ProfileCard` project. Start from `STARTER/ContentView.swift` if you have not already. |
| 5 – 15 | 16:03 | Must-have 1 and 2: avatar and two lines of text in a `VStack`. |
| 15 – 22 | 16:13 | Must-have 3: the location `HStack`. |
| 22 – 30 | 16:20 | Must-have 4: bring in a function from this afternoon and feed it into a `Text`. |
| 30 – 37 | 16:28 | Must-have 5: the card recipe. Run it with **Cmd-R**. |
| 37 – 45 | 16:35 | Nice-to-haves. Pick two, not five. |

**Checkpoint at 16:28:** all five must-haves on screen. Ugly is fine at 16:28. Pretty comes after.

Self-check and the share-out are Exercise 1.10, from about 16:43.

---

## Self-check

Run through these yourself before you show anybody. Tick every box.

- [ ] **1.** The project builds with no red errors.
- [ ] **2.** It runs in the **simulator** (Cmd-R), not only in the Canvas.
- [ ] **3.** The avatar is exactly the size I set — not stretched, not squashed, not filling the screen.
- [ ] **4.** At least one line of text comes from a function I wrote.
- [ ] **5.** Changing one constant at the top of the struct visibly changes the card.
- [ ] **6.** No text touches the edge of the card.
- [ ] **7.** The card does not touch the edge of the screen.
- [ ] **8.** My name is spelled correctly. (It happens.)

If any box is unticked, fix that first. If something looks slightly wrong and you cannot say why, **check modifier order** — it is the cause about half the time.

---

## Share-out

At 16:50 turn your screen to your neighbour.

- Tell them **two things you like** about their card. Be specific: "the spacing under the name" beats "nice".
- Ask **one question**: "how did you do the ring?"

You will not be graded. You will be asked to explain one choice you made, so make choices you can explain.

---

## Stretch: make it reusable

If you finish early, this is the most valuable extra twenty minutes you can spend.

Move the card into its own struct with properties instead of hard-coded strings:

```swift
struct ProfileCard: View {
    let name: String
    let role: String
    let city: String

    var body: some View {
        // your card here, using name / role / city
    }
}
```

Then show **two** cards in `ContentView`:

```swift
VStack(spacing: 16) {
    ProfileCard(name: "Aisyah Putri", role: "Product Designer", city: "Jakarta")
    ProfileCard(name: "Budi Santoso", role: "iOS Engineer", city: "Bandung")
}
.padding(20)
```

One view definition, two different cards. That is the idea the whole of Day 2 is built on.

---

## What to bring tomorrow

- Your laptop, charged.
- This project, still on your Desktop.
- Your exit ticket answered: one thing that clicked, one thing still fuzzy.

If you did not finish, that is fine. Day 2 starts from a fresh file and nobody is left behind.
