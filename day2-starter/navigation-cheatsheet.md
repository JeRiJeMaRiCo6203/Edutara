# Cheat Sheet · Navigation

**Day 2** · SwiftUI Digital Prototyping · SG Code Campus
Keep this beside your keyboard for the afternoon.

---

## A note on the name, before anything else

Your course outline — and almost every tutorial written before 2023 — calls the navigation container **`NavigationView`**.

Apple deprecated `NavigationView` in iOS 16 and replaced it with **`NavigationStack`**.

> **Same idea. New name.** Everything inside the braces stays the same.

| Name | Status | What to do |
| --- | --- | --- |
| `NavigationView` | Old, deprecated since iOS 16 | Recognise it in old code |
| `NavigationStack` | Current | Write this |

`NavigationView` still compiles, so old projects keep working — Xcode shows a yellow warning, not a red error. When you follow an older tutorial and it says `NavigationView`, type `NavigationStack` instead and carry on.

---

## Navigation is exactly two pieces

```
NavigationStack               THE CONTAINER
  |    owns the stack of screens
  |    draws the bar, the title, the back button
  |
  +-- your screen
        |
        +-- NavigationLink    THE LINK
              "push this destination, please"
```

**The link does not push anything.** It has no stack. It asks the nearest `NavigationStack` above it. No stack above it, nobody to ask, nothing happens.

---

## The container

```swift
struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Home screen")
            }
            .navigationTitle("Home")
        }
    }
}
```

- One `NavigationStack` per flow. Wrap the **first** screen only.
- Screens you navigate **to** do not get their own stack.
- `.navigationTitle` goes on the content **inside** the stack, not on the stack itself.

---

## The link — three forms you will use

### 1 · Simple, with a text label

```swift
NavigationLink(destination: DetailView()) {
    Text("See the detail")
}
```

### 2 · With data passed to the destination

```swift
NavigationLink(destination: DetailView(place: place)) {
    Label(place.name, systemImage: place.symbol)
}
```

### 3 · Inside a `List` and a `ForEach` — the list-to-detail shape

```swift
NavigationStack {
    List {
        ForEach(Destination.samples) { place in
            NavigationLink(destination: DetailView(place: place)) {
                Text(place.name)
            }
        }
    }
    .navigationTitle("Destinations")
}
```

Inside a `List`, the grey chevron on the right appears by itself. Nobody writes it.

---

## Titles

```swift
.navigationTitle("Home")                        // a fixed title
.navigationTitle(place.name)                    // a title from data
.navigationTitle("\(place.name) · \(region)")   // interpolated
.navigationBarTitleDisplayMode(.inline)         // small, centred
```

- Each screen sets **its own** title.
- The **back button** is drawn for you and labelled with the **previous** screen's title.
- You never write a back button.
- Large title (the default) suits the first screen. `.inline` suits detail screens.

---

## Passing data to a detail view

A `let` with no value is a **slot**. Whoever creates the view must fill it.

**The detail screen:**

```swift
struct DetailView: View {
    let place: Destination

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: place.symbol)
                .font(.system(size: 70))
            Text(place.name)
                .font(.largeTitle)
                .bold()
            Text(place.summary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle(place.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailView(place: Destination.samples[0])
    }
}
```

**The link that fills the slot:**

```swift
NavigationLink(destination: DetailView(place: place)) {
    Text(place.name)
}
```

### Pass the whole item, not its parts

```swift
let place: Destination        // good — one slot
```

```swift
let name: String              // works, but fragile
let island: String
let symbol: String
let summary: String
```

With one slot, adding a new fact to the model costs one line in one file. With five slots, it costs an edit in the model, the link, the detail screen and the preview.

### It is `let`, not `@State`

The detail screen **shows** the value. It never changes it. Only use `@State` for something this screen itself changes.

---

## The three navigation errors beginners hit

### 1 · Tapping does nothing, and there is no bar at the top

**Cause:** the `NavigationLink` is not inside any `NavigationStack`.

**It builds with no errors.** That is why this one is hard.

```swift
// WRONG — no container
var body: some View {
    NavigationLink(destination: DetailView()) {
        Text("See the detail")
    }
}
```

```swift
// RIGHT
var body: some View {
    NavigationStack {
        NavigationLink(destination: DetailView()) {
            Text("See the detail")
        }
    }
}
```

**How to spot it:** look at the top of the screen. No title bar means no container.

---

### 2 · "Cannot find 'DetailView' in scope"

**Cause:** either the new file was created **outside the target**, or the struct was typed **inside another struct's braces**.

**Fix:**
- Check the struct is at file level — same indentation as `struct ContentView`, not nested.
- If the file is the problem, delete it and add it again: right-click the yellow folder ▸ **New File from Template… ▸ iOS ▸ SwiftUI View**, and make sure your app's target is **ticked** in the dialog.

---

### 3 · The title does not appear

**Cause:** `.navigationTitle` is attached to the `NavigationStack` instead of the content inside it.

```swift
// WRONG — nothing appears, and no error
NavigationStack {
    VStack {
        Text("Home")
    }
}
.navigationTitle("Home")
```

```swift
// RIGHT
NavigationStack {
    VStack {
        Text("Home")
    }
    .navigationTitle("Home")
}
```

**Also normal:** a `#Preview` of a detail view on its own shows no bar, because that preview has no container. Wrap the preview in `NavigationStack { }` if you want to see the title while previewing.

---

## Diagnosis order

When navigation misbehaves, check in this order:

1. **The container.** Is there a `NavigationStack` above the link?
2. **The file.** Is the destination struct at file level, in the target?
3. **The modifier.** Is `.navigationTitle` inside the stack, on the content?

---

## Two more things worth knowing

**Do not nest stacks.** A screen you navigate to must not have its own `NavigationStack`. Two stacks means two title bars stacked on top of each other.

**A link is a button.** It accepts `.buttonStyle(.borderedProminent)` like any button. Inside a `List`, leave it plain — the `List` styles the row for you.

---

## The one sentence

> A `NavigationLink` cannot push a screen by itself. It asks the nearest `NavigationStack` above it, so if there is no stack, nothing happens.
