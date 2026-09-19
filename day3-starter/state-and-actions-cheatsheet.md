# Cheat Sheet · State and Actions

**Day 2** · SwiftUI Digital Prototyping · SG Code Campus
Keep this beside your keyboard. Everything on it is used today.

---

## The mental model

```
        You change a VALUE.
        SwiftUI rebuilds the SCREEN.

   value            body runs            screen
  ---------        -----------          --------
  count = 0   -->   Text("0")     -->   shows 0

            [ you tap Plus ]

  count = 1   -->   Text("1")     -->   shows 1

            [ you tap Plus ]

  count = 2   -->   Text("2")     -->   shows 2


  The view struct is THROWN AWAY and built again each time.
  The @State value is held by SwiftUI, OUTSIDE the struct,
  so it survives.

        THE VIEW IS REBUILT. THE STATE SURVIVES.
```

You never reach into the screen and change a label. There is nothing to reach into. You change the value, and your `body` recipe runs again.

---

## The three shapes

| Write this | When | Example |
| --- | --- | --- |
| `let name = value` | Never changes while the app runs | `let title = "Counter"` |
| `let name: Type` | Given from outside when the view is created | `let place: Destination` |
| `@State private var name = value` | This view changes it, and the screen must react | `@State private var count = 0` |

**A plain `var` inside a view is almost always a mistake.** If it changes, it needs `@State`.

---

## `@State` — the line to memorise

```swift
@State private var count = 0
```

| Rule | Why |
| --- | --- |
| Always `var`, never `let` | Its whole purpose is to change |
| Always a starting value | `= 0`, not `: Int` |
| Always `private` | It belongs to this view only |
| Always on the struct, above `var body` | Never inside `body` |

### Where it goes

```swift
struct ContentView: View {
    @State private var count = 0      // here

    var body: some View {
        // not here
    }
}
```

### Changing it

```swift
count += 1          // add one
count -= 1          // take one away
count = 0           // set it
isOn.toggle()       // flip a Bool
```

---

## Buttons

### Short form — use this one

```swift
Button("Save") {
    print("Tapped")
}
```

### Long form — when the label is more than text

```swift
Button {
    print("Tapped")
} label: {
    Label("Save", systemImage: "square.and.arrow.down")
}
```

### Styling — always **after** the closing brace

```swift
Button("Save") {
    count += 1
}
.buttonStyle(.borderedProminent)
.controlSize(.large)
.tint(.green)
```

| Modifier | Effect |
| --- | --- |
| `.buttonStyle(.borderedProminent)` | Filled capsule |
| `.buttonStyle(.bordered)` | Soft grey capsule |
| `.buttonStyle(.plain)` | No decoration |
| `.controlSize(.large)` | Bigger tap target |
| `.tint(.green)` | Button colour |
| `.disabled(count == 0)` | Greys it out and stops taps |

### Two buttons, one style

Put the modifier on the **stack**. One line instead of two.

```swift
HStack(spacing: 16) {
    Button("Minus") { count -= 1 }
    Button("Plus")  { count += 1 }
}
.buttonStyle(.borderedProminent)
.controlSize(.large)
```

---

## Control flow inside a view

### `if` / `else` — choose between two views

```swift
if count == 0 {
    Text("Tap plus to start")
} else {
    Text("Count is \(count)")
}
```

### `if` on its own — show a view only sometimes

```swift
if count >= 10 {
    Label("Double figures", systemImage: "star.fill")
}
```

No `else` needed. When the condition is false, nothing is drawn.

### Computed property — turn a value into a value

Put it on the struct, next to `@State`, **not** inside `body`.

```swift
var countColor: Color {
    if count < 0 {
        return .red
    } else if count == 0 {
        return .gray
    } else if count < 10 {
        return .blue
    } else {
        return .green
    }
}
```

Use it like any value:

```swift
Text("\(count)")
    .foregroundStyle(countColor)
```

**Order matters.** The first true branch wins. If a band never shows, check the order.

### `switch` — three or more cases

```swift
var message: String {
    switch count {
    case ..<0:
        return "Below zero"
    case 0:
        return "Tap plus to start"
    case 1...9:
        return "Keep going"
    default:
        return "Excellent"
    }
}
```

| Pattern | Means |
| --- | --- |
| `case 0:` | Exactly zero |
| `case 1...9:` | 1 to 9, including both |
| `case ..<0:` | Anything below zero |
| `default:` | Everything else — **required** |

Swift needs no `break`. It stops at the end of a case by itself.

**Rule of thumb:** two branches, use `if/else`. Three or more, use `switch`.

---

## Errors you will meet today

| Error | Cause | Fix |
| --- | --- | --- |
| "Cannot assign to property: 'self' is immutable" | Plain `var` in a view | Add `@State private` |
| "Cannot assign to value: ... is a 'let' constant" | `@State private let` | Change `let` to `var` |
| "Return from initializer without initializing all stored properties" | `@State private var count: Int` | Give it a value: `= 0` |
| Strange errors all over the file | `@State` declared inside `body` | Move it above `var body` |
| "Switch must be exhaustive" | No `default:` case | Add one |
| "Cannot find type 'Color' in scope" | Missing `import SwiftUI` | Add it at the top |
| "Value of type '()' has no member 'tint'" | Modifier inside the button's braces | Move it after the closing brace |
| Nothing prints anywhere | Looking at the Canvas | `print` goes to the **console**: Cmd-R, then Cmd-Shift-Y |

---

## Shortcuts

```
Cmd-R          Run
Cmd-.          Stop
Cmd-Z          Undo
Cmd-Shift-Y    Show / hide the console
Option-Cmd-P   Resume the Canvas
Cmd-A, Ctrl-I  Select all, re-indent (makes broken braces obvious)
```

---

## The one sentence

> `@State` gives a view a value that survives being rebuilt, and tells SwiftUI to redraw the screen whenever that value changes.
