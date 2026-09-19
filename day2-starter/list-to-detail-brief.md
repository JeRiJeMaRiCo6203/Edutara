# Project Brief · List-to-Detail Prototype

**Day 2 deliverable** · SwiftUI Digital Prototyping · SG Code Campus
**Exercise 2.9** · Time box: 48 minutes · Session 4 (15:15 – 17:00), build starts at 16:00

---

## The task

Build a two-screen prototype about a subject of your own: a **list** of things, and a **detail** screen for whichever one you tap.

This is the shape of most real apps. Messages, Mail, Settings, Spotify, Gojek — all list, then detail.

---

## The brief, in one sentence

> A scrolling list generated from your own data, where tapping any row opens one detail screen that shows that row's information, with a working back button.

---

## Choose your subject now

Ten seconds. Do not spend the session deciding.

Good subjects — five or more items, each with at least four facts:

| Subject | Facts you could show |
| --- | --- |
| Street food dishes | Name, region, main ingredient, spice level, price |
| Islands or cities | Name, province, population, best months, one fact |
| Football clubs | Name, city, founded, stadium, colours |
| Campus buildings | Name, floor count, what happens there, opening hours |
| Coffee varieties | Name, origin, roast, tasting notes, strength |
| Team members | Name, role, city, years of experience, one skill |

If you are still choosing at 16:05, take "Indonesian islands" and start.

---

## Must-haves

All five. Do these before anything decorative.

| # | Requirement | You will use |
| --- | --- | --- |
| 1 | A model `struct` with at least four properties, conforming to `Identifiable` | `struct X: Identifiable`, `let id = UUID()` |
| 2 | At least five samples in a `static let samples` array | `static let samples: [X] = [ ... ]` |
| 3 | A list screen generated from the data | `NavigationStack`, `List`, `ForEach` |
| 4 | Every row taps through to a detail screen carrying **its own** data | `NavigationLink(destination:)`, `let item: X` |
| 5 | A title on each screen, and a working back button | `.navigationTitle(...)` |

### The shape to aim for

```swift
NavigationStack {
    List {
        ForEach(X.samples) { item in
            NavigationLink(destination: DetailView(item: item)) {
                Text(item.name)
            }
        }
    }
    .navigationTitle("Your title")
}
```

**The rule:** one `DetailView`, written **once**. If you are copying it into `DetailView2`, stop and put your sticky note up.

---

## Nice-to-haves

Only start these once all five must-haves work and the project builds. **Pick two, not five.**

| Feature | Hint |
| --- | --- |
| An icon per item | Add `let symbol: String`, then `Image(systemName: item.symbol)` |
| Two lines per row | `VStack(alignment: .leading, spacing: 2)` inside the link |
| Info tiles on the detail screen | Write one small `struct InfoTile: View` and use it twice |
| A colour decided by the data | A computed property with `switch` on one property |
| A long summary that scrolls | Wrap the detail content in `ScrollView { }` |
| A Save star on the detail screen | `@State private var isSaved = false`, then `isSaved.toggle()` in a button |
| A small title on detail screens | `.navigationBarTitleDisplayMode(.inline)` |

---

## Rules for today

- **No `@Binding`, no `ObservableObject`, no `async`.** Not needed, not taught, not today.
- **Use SF Symbols.** No image files to download. Safe names: `star.fill`, `leaf.fill`, `drop.fill`, `mountain.2.fill`, `water.waves`, `building.columns.fill`, `fork.knife`, `cup.and.saucer.fill`, `airplane`, `map.fill`, `camera.fill`, `music.note`, `book.fill`, `tortoise.fill`. If one shows as a blank square, use `star.fill` and move on.
- **One `NavigationStack`**, on the list screen only. The detail screen never gets its own.
- **Pass the whole item** to the detail screen — `let item: Destination` — not five separate strings.

---

## Suggested order of work

Run the app after every step. Do not write twenty minutes of code before pressing Cmd-R.

| Minutes | Clock | Do this |
| --- | --- | --- |
| 0 – 8 | 16:00 | Model struct with **two** samples. Nothing else. |
| 8 – 16 | 16:08 | Detail screen with `let item: X`, showing one property. Preview it. |
| 16 – 24 | 16:16 | List screen: `NavigationStack`, `List`, `ForEach`, plain `Text` rows. Run it. |
| 24 – 30 | 16:24 | Wrap a row in `NavigationLink`. Run it. **Tap.** Come back. |
| 30 – 38 | 16:30 | Three more samples. Titles on both screens. **All five must-haves done.** |
| 38 – 48 | 16:38 | Nice-to-haves. Pick two. |

**Checkpoint at 16:30:** all five must-haves working. Plain is fine at 16:30. Pretty comes after.

Self-check and the share-out are Exercise 2.10, from 16:48.

---

## Stuck?

`projects/04-list-to-detail/STARTER/` has all four files. **They build as they are** and contain nine `// TODO` markers in order. The README in that folder sets the project up in under three minutes.

When a tap does nothing, check for the `NavigationStack` **first**. Every time. No title bar at the top means no container.

---

## Self-check

Run through these yourself before you show anybody. Tick every box.

- [ ] **1.** The project builds with no red errors.
- [ ] **2.** It runs in the **simulator** (Cmd-R), not only in the Canvas.
- [ ] **3.** Every row opens a detail screen showing **that row's** data — check three different rows.
- [ ] **4.** The back button works from every detail screen.
- [ ] **5.** Adding one more sample adds one more working row, with **no other change**. Try it now.
- [ ] **6.** I wrote my detail screen exactly **once**.
- [ ] **7.** Both screens have titles.
- [ ] **8.** Nothing on either screen touches the edge of the phone.

If any box is unticked, fix that first.

Check 5 is the real test of whether you understood `ForEach`. Do it — do not assume.

---

## Share-out

At 16:51 turn your screen to your neighbour.

- Tell them **two things you like**. Be specific: "the icons make the list scannable" beats "nice".
- Ask **one question**: "how did you decide the colour?"

You will not be graded. You will be asked to explain one choice you made, so make choices you can explain.

---

## If you finish everything

The most valuable extra fifteen minutes you can spend:

1. Add a sixth and seventh sample and confirm nothing else needed changing.
2. Write down, in one sentence each, what `@State` does and why a `NavigationLink` needs a `NavigationStack`. If you can write both without looking, you have Day 2.
3. Help the person next to you. Explain — do not type on their keyboard.

---

## What to bring tomorrow

- Your laptop, charged.
- This project, still on your Desktop. **Day 3 builds directly on it** — forms, input, polish, and handing a prototype to a client.
- Your exit ticket answered: one thing that clicked, one thing still fuzzy.

If you did not finish, that is fine. Day 3 starts from a working copy and nobody is left behind.
