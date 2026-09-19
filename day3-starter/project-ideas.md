# 07 · Six Project Ideas

**Day 3 · Session 3 (13:00 – 15:00)** · SwiftUI Digital Prototyping · SG Code Campus

Six briefs, each fully specified: the three screens, the data shape, the controls, a realistic two-hour cut line, and which shipped project to fork.

**Taking one of these is not cheating.** Choosing a subject is worth less than two minutes of your afternoon, and the skills are identical whichever you pick. If you are undecided at 13:26, take one and go.

---

## How to read a brief

| Part | What it is for |
| --- | --- |
| **Concept** | Your one-sentence demo opening |
| **Three screens** | Copy these straight onto your planning worksheet |
| **Data shape** | Paste this into `Item.swift` and rename |
| **Controls** | Which input control satisfies required element 4 |
| **The 2-hour cut line** | What you build **first**, and what you drop without regret |
| **Stretch** | Only after 14:30, and only if everything else runs |
| **Start from** | The shipped project whose working code is closest |

---

## 1 · Habit Tracker

**Concept:** a list of the habits you are trying to keep, and how many days in a row you have managed each one.

**Who it is for:** someone who keeps a paper tally on their fridge and keeps losing it.

### Three screens

| # | Screen | What is on it |
| --- | --- | --- |
| 1 | **Habit list** | Every habit, with its icon, its streak count, and a green tick if it is done today |
| 2 | **Habit detail** | The habit's name, its streak, why you started it, and a big "Mark done today" button |
| 3 | **Add habit** | Name, why, an icon picker, a slider for "target days per week", a reminder toggle |

### Data shape

```swift
struct Habit: Identifiable {
    let id = UUID()
    let name: String            // "Morning walk"
    let reason: String          // "Because my back hurts at a desk"
    let symbol: String          // "figure.walk"
    let streak: Int             // 12
    let targetPerWeek: Int      // 5
    let isDoneToday: Bool
}
```

Five samples: Morning walk, Read 20 pages, No sugar after 8pm, Call my mother, Stretch before bed.
Symbols: `figure.walk`, `book.fill`, `takeoutbag.and.cup.and.straw.fill`, `phone.fill`, `figure.flexibility`.

### Controls

`TextField` for the name and reason · `Slider` for target days (0...7, step 1 — remember `Int(...)` in the `Text`) · `Toggle` for the reminder · `Picker` for the icon.

### The 2-hour cut line

**Build first:** the list with streak counts, and the detail screen. That alone is a complete, demonstrable prototype.
**Then:** the Add screen.
**Cut without regret:** anything involving real dates, calendars, a weekly grid, or the streak actually counting up. Those need date maths you have not been taught.

> `isDoneToday` is a `Bool` you set in the sample data. Do **not** try to make it real. A prototype shows the idea.

**Stretch:** a `switch` that colours the streak number — red under 3, orange under 7, green above.

**Start from:** `06-final-project-starter` — it is almost exactly this shape.

---

## 2 · Recipe Box

**Concept:** the ten dishes you actually cook, with the method, so you stop searching for them.

**Who it is for:** someone who cooks the same things and keeps forgetting the timings.

### Three screens

| # | Screen | What is on it |
| --- | --- | --- |
| 1 | **Recipe list** | Every recipe, with its icon, name, region and a star if it is a favourite |
| 2 | **Recipe detail** | Icon, name, region, cooking time, and the method as a paragraph |
| 3 | **Add recipe** | Name, region, a method field that grows, an icon picker, a time slider, a favourite toggle |

### Data shape

```swift
struct Recipe: Identifiable {
    let id = UUID()
    let name: String            // "Nasi Goreng"
    let origin: String          // "Java"
    let symbol: String          // "flame.fill"
    let method: String          // a paragraph
    let minutes: Int            // 25
    let isFavourite: Bool
}
```

Five samples: Nasi Goreng, Soto Ayam, Rendang, Gado-Gado, Martabak.
Symbols: `flame.fill`, `cup.and.saucer.fill`, `fork.knife`, `leaf.fill`, `birthday.cake.fill`.

### Controls

`TextField` for name and region · `TextField(..., axis: .vertical)` for the method · `Slider` for minutes (0...180, step 5) · `Toggle` for favourite · `Picker` for the icon.

### The 2-hour cut line

**Build first:** the list and the detail screen with the method paragraph. That is the app.
**Then:** the Add screen.
**Cut without regret:** an ingredients list (that is a list inside a list — a whole extra idea), photos, servings maths, shopping lists.

**Stretch:** filter the list by region with a `Picker` at the top, using `Picker` plus a filtered array.

**Start from:** `06-final-project-starter`. This is the subject used in Demo 12, so pick a different one if you want yours to stand out.

---

## 3 · Packing List

**Concept:** what to pack for a trip, ticked off as it goes in the bag.

**Who it is for:** someone who travels for work and always forgets the same two things.

### Three screens

| # | Screen | What is on it |
| --- | --- | --- |
| 1 | **Packing list** | Every item, grouped by category, with a tick for packed |
| 2 | **Item detail** | The item, its category, why it is on the list, and a "mark packed" button |
| 3 | **Add item** | Name, a category picker, a notes field, an essential toggle |

### Data shape

```swift
struct PackItem: Identifiable {
    let id = UUID()
    let name: String            // "Passport"
    let category: String        // "Documents"
    let symbol: String          // "doc.text.fill"
    let notes: String           // "Check it is valid for 6 months"
    let isEssential: Bool
    let isPacked: Bool
}
```

Six samples: Passport, Laptop charger, Adapter, Running shoes, Medication, Umbrella.
Symbols: `doc.text.fill`, `bolt.fill`, `powerplug.fill`, `figure.run`, `pills.fill`, `umbrella.fill`.

### Controls

`TextField` for name and notes · `Picker` for the category (Documents / Tech / Clothes / Health) · `Toggle` for essential.

### The 2-hour cut line

**Build first:** the list with packed ticks, and the detail screen.
**Then:** the Add screen.
**Cut without regret:** multiple trips, actually toggling `isPacked` from the list row, progress bars, sharing.

> Toggling `isPacked` from a row needs a `@Binding` into an array element, which is fiddly. Set it in the sample data and show it. If you have spare time at 14:30, add the toggle on the **detail** screen only.

**Stretch:** a `Section` per category in the `List`, instead of one flat list.

**Start from:** `06-final-project-starter`.

---

## 4 · Study Flashcards

**Concept:** cards with a question on one side and an answer on the other, for whatever you are learning.

**Who it is for:** anyone revising vocabulary, formulas or definitions.

### Three screens

| # | Screen | What is on it |
| --- | --- | --- |
| 1 | **Deck list** | Every card, showing the question only, with a difficulty dot |
| 2 | **Card detail** | The question, a **Show answer** button, and the answer that appears |
| 3 | **Add card** | Question, answer, a subject picker, a difficulty slider |

### Data shape

```swift
struct Card: Identifiable {
    let id = UUID()
    let question: String        // "What does @State do?"
    let answer: String          // "It keeps a value outside the view..."
    let subject: String         // "SwiftUI"
    let symbol: String          // "swift"
    let difficulty: Int         // 1 to 5
}
```

Six samples — use this course. "What does `@State` do?", "When do you need a `$`?", "What does `ForEach` need?", "Where does `.navigationTitle` go?", "What is a `Binding`?", "What type must a `Slider` use?"
Symbols: `questionmark.circle.fill`, `star.fill`, `book.fill`, `pencil`, `lightbulb.fill`, `brain.head.fit`.

### Controls

`TextField` for question and answer · `Picker` for the subject · `Slider` for difficulty (1...5, step 1) · and a `@State` **Show answer** toggle on the detail screen.

### The 2-hour cut line

**Build first:** the list, and the detail screen with the **Show answer** button. That button is a `@State` `Bool` and an `if` — it is required element 3 and it demos beautifully.
**Then:** the Add screen.
**Cut without regret:** shuffling, scoring, spaced repetition, swiping between cards, timers.

**Stretch:** a `switch` on `difficulty` that colours a dot in the row — green 1–2, orange 3, red 4–5.

**Start from:** `06-final-project-starter`, plus the `@State` reveal pattern from Day 2's counter.

> This idea has the best demo of the six, because the reveal is visible and instant.

---

## 5 · Expense Log

**Concept:** what you spent, on what, so the month stops being a mystery.

**Who it is for:** someone sharing a house, or tracking a small business's small costs.

### Three screens

| # | Screen | What is on it |
| --- | --- | --- |
| 1 | **Expense list** | Every expense with its category icon, what it was, and the amount |
| 2 | **Expense detail** | Amount large at the top, category, a note, and who paid |
| 3 | **Add expense** | What, an amount slider, a category picker, a "shared" toggle |

### Data shape

```swift
struct Expense: Identifiable {
    let id = UUID()
    let name: String            // "Groceries"
    let category: String        // "Food"
    let symbol: String          // "cart.fill"
    let note: String            // "Weekly shop at the market"
    let amount: Int             // 185000   (rupiah, whole numbers)
    let isShared: Bool
}
```

Six samples: Groceries, Bus pass, Coffee, Internet bill, Lunch, Phone credit.
Symbols: `cart.fill`, `bus`, `cup.and.saucer.fill`, `wifi`, `fork.knife`, `phone.fill`.

### Controls

`TextField` for name and note · `Slider` for the amount · `Picker` for the category · `Toggle` for shared.

> **The amount is the teaching point of this idea.** A `Slider` gives you a `Double`, your model wants an `Int`, and the user wants to read `185,000`. Convert with `Int(amount)` at the point you create the expense, and only there.

### The 2-hour cut line

**Build first:** the list and the detail screen. Put a **total** at the bottom of the list — one `Text`, one line of Swift:

```swift
Text("Total: \(expenses.reduce(0) { $0 + $1.amount })")
```

If `reduce` looks unfamiliar, add up the samples yourself and hard-code the number. A prototype may lie about arithmetic.

**Then:** the Add screen.
**Cut without regret:** dates, monthly grouping, charts, currency formatting, splitting between people, budgets.

**Stretch:** colour the amount red when it is over 100000, using an `if` or a computed property.

**Start from:** `06-final-project-starter`.

---

## 6 · Campus Directory

**Concept:** who is where, and what they do — a small directory for an office, campus or team.

**Who it is for:** a new joiner on their first week who does not know anyone.

### Three screens

| # | Screen | What is on it |
| --- | --- | --- |
| 1 | **People list** | Every person, with an icon, name and role |
| 2 | **Person detail** | Icon, name, role, department, room and a short bio |
| 3 | **Add person** | Name, role, a department picker, a room field, an icon picker |

### Data shape

```swift
struct Person: Identifiable {
    let id = UUID()
    let name: String            // "Dewi Rahayu"
    let role: String            // "Facilities Manager"
    let department: String      // "Operations"
    let symbol: String          // "person.fill"
    let room: String            // "B2-14"
    let bio: String
    let isOnSite: Bool
}
```

Six samples — invent them, or use six people in this room, with their permission.
Symbols: `person.fill`, `person.crop.circle.fill`, `graduationcap.fill`, `wrench.and.screwdriver.fill`, `stethoscope`, `books.vertical.fill`.

### Controls

`TextField` for name, role and room · `Picker` for the department · `Toggle` for on site today.

### The 2-hour cut line

**Build first:** the list and the detail screen. This is the simplest of the six briefs and the fastest to finish.
**Then:** the Add screen, and — because you will have time — `.searchable(text: $query)` on the list.
**Cut without regret:** photos, phone links, email links, an org chart, a map.

**Stretch:** a search bar. On the `List`, add `.searchable(text: $query)` and filter the array:

```swift
@State private var query = ""

var filtered: [Person] {
    if query.isEmpty {
        return people
    }
    return people.filter { $0.name.contains(query) }
}
```

Then use `ForEach(filtered)` instead of `ForEach(people)`.

**Start from:** `04-list-to-detail` (Day 2) if you want the simplest possible base, or `06-final-project-starter` if you want the Add screen for free.

---

## Comparison — pick in thirty seconds

| Idea | Hardest part | Best demo moment | Start from |
| --- | --- | --- | --- |
| **Habit tracker** | Resisting real dates | The coloured streak numbers | `06-final-project-starter` |
| **Recipe box** | Resisting an ingredients list | The method paragraph | `06-final-project-starter` |
| **Packing list** | Resisting a tick on every row | Grouping by category | `06-final-project-starter` |
| **Study flashcards** | Nothing. This is the easiest | **Show answer** — instant and visible | `06-final-project-starter` |
| **Expense log** | The `Double` to `Int` amount | A running total at the bottom | `06-final-project-starter` |
| **Campus directory** | Nothing. This is the fastest | The search bar | `04-list-to-detail` or `06` |

**Fastest to a working prototype:** campus directory, then flashcards.
**Best demo:** flashcards, then habit tracker.
**Most likely to run over:** recipe box, because everybody wants the ingredients.

---

## The same four rules apply whichever you choose

1. **Three screens.** Not five.
2. **Five to eight samples**, typed by hand.
3. **Fork the starter.** Do not start from File ▸ New.
4. **Plain and working at 15:00** beats beautiful and broken at 15:00.

And whatever you cut, write it on your cut list. Those are good ideas — they are week two.
