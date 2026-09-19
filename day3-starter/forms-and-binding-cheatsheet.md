# Forms and Binding · Cheat Sheet

**Day 3** · SwiftUI Digital Prototyping · SG Code Campus
Keep this next to your keyboard all day.

---

## The one rule

> **Does the control CHANGE the value?**
> **Yes → `$name`.  No → `name`.**

| You write | You get | Used by |
| --- | --- | --- |
| `name` | The value itself. Read only. | `Text`, `Image`, anything that displays |
| `$name` | A two-way wire to the value. | `TextField`, `Toggle`, `Slider`, `Picker`, `.sheet` |

```swift
@State private var name = ""

TextField("Your name", text: $name)   // changes it  -> $
Text("Hello, \(name)")                // reads it    -> no $
```

**If an error message contains the word `Binding`, it is the dollar sign. Every time. Nothing else.**

---

## TextField

```swift
@State private var name = ""

TextField("Your name", text: $name)
    .textFieldStyle(.roundedBorder)
```

| Piece | Meaning |
| --- | --- |
| `"Your name"` | Placeholder — the grey hint. Disappears when you type. **Not** the value. |
| `text: $name` | The wire to your `@State`. |
| `.textFieldStyle(.roundedBorder)` | Makes it look like a box. **Leave it out inside a `Form`.** |

---

## SecureField

Identical to `TextField`. It draws dots.

```swift
@State private var password = ""

SecureField("Password", text: $password)
    .textFieldStyle(.roundedBorder)
```

> This is a prototype. Nothing here is real security. Never type a password you actually use.

---

## Toggle

```swift
@State private var wantsReminders = false

Toggle("Send me reminders", isOn: $wantsReminders)

Text(wantsReminders ? "Reminders on" : "Reminders off")
```

The argument is `isOn:`, not `value:`. Read the ternary as *"if reminders, this, otherwise that."*

With an icon instead of a plain label:

```swift
Toggle(isOn: $wantsReminders) {
    Label("Reminders", systemImage: "bell.fill")
}
```

---

## Slider

```swift
@State private var years = 1.0                         // Double. POINT ZERO.

Text("Experience: \(Int(years)) years")                // Int only HERE
Slider(value: $years, in: 0...40, step: 1)
```

| Argument | Meaning |
| --- | --- |
| `value: $years` | The wire. Must be a `Double`. |
| `in: 0...40` | The two ends. |
| `step: 1` | Move in whole numbers. Leave it out and it slides smoothly. |

**The two problems, kept apart:**

| Problem | Where you fix it |
| --- | --- |
| "...requires that 'Int' conform to 'BinaryFloatingPoint'" | The `@State` line: `1.0`, not `1` |
| The screen says `12.000000` | The `Text` line: `\(Int(years))` |

**Keep the `Double` for the machine. Show an `Int` to the human.**
Never "fix" the display by changing the `@State` to an `Int`. That breaks the slider and gives you two problems.

---

## Picker

```swift
let plans = ["Basic", "Standard", "Pro"]
@State private var plan = "Basic"

Picker("Plan", selection: $plan) {
    ForEach(plans, id: \.self) { option in
        Text(option)
    }
}
.pickerStyle(.segmented)
```

| Style | Use when |
| --- | --- |
| `.segmented` | Three or fewer options |
| `.menu` | Four or more options |
| `.wheel` | A long list, inside a `Form` |

- `id: \.self` is needed because plain strings have no `id` of their own.
- The starting value of the `@State` **must be one of the options, spelled identically**, or the picker looks empty and nothing is wrong with your code.

---

## Form and Section

```swift
NavigationStack {
    Form {
        Section("Your details") {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
        }

        Section {
            SecureField("Password", text: $password)
        } header: {
            Text("Security")
        } footer: {
            Text("At least 8 characters.")
        }
    }
    .navigationTitle("Sign up")
}
```

- A `Form` is a `List` dressed for input. Grey background, grouped rows, correct spacing, for free.
- `NavigationStack` goes **outside** the `Form`. `.navigationTitle` goes **on** the `Form`.
- **No bar at the top means no container.** Same rule as Day 2.
- Drop `.textFieldStyle(.roundedBorder)` inside a `Form`.

---

## Keyboard types and input behaviour

```swift
TextField("Email", text: $email)
    .keyboardType(.emailAddress)
    .textInputAutocapitalization(.never)
    .autocorrectionDisabled()
```

| Modifier | Effect |
| --- | --- |
| `.keyboardType(.emailAddress)` | An `@` key on the keyboard |
| `.keyboardType(.numberPad)` | Digits only |
| `.keyboardType(.decimalPad)` | Digits and a decimal point |
| `.keyboardType(.phonePad)` | Phone keypad |
| `.textInputAutocapitalization(.never)` | No capital first letter |
| `.textInputAutocapitalization(.words)` | Capital on every word — good for names |
| `.autocorrectionDisabled()` | Stops iOS "fixing" what they typed |
| `.submitLabel(.done)` | Changes the blue return key's word |

> **Keyboard types are invisible in the Canvas.** Press Cmd-R and check in the simulator.

**The standard email field, every time:**

```swift
.keyboardType(.emailAddress)
.textInputAutocapitalization(.never)
.autocorrectionDisabled()
```

---

## @State, @Binding, let — the three keywords

| Keyword | Means | Example |
| --- | --- | --- |
| `@State` | **I own this value.** It survives rebuilds. | `@State private var name = ""` |
| `@Binding` | **Somebody lends me this value and I may change it.** | `@Binding var isPresented: Bool` |
| `let` | **I was given a copy. I only read it.** | `let place: Destination` |

```swift
// The child view
struct NameField: View {
    @Binding var text: String

    var body: some View {
        TextField("Name", text: $text)
    }
}

// The parent
@State private var name = ""
NameField(text: $name)
```

One `@State` somewhere. Everyone else gets a wire to it.

**Ask yourself:** does this child need to **change** the parent's value?
Yes → `@Binding`. No → `let`.

**In a preview, a `@Binding` needs a fake wire:**

```swift
#Preview {
    NameField(text: .constant("Rina"))
}
```

---

## The four input errors beginners hit

### 1. Missing `$`

```
Cannot convert value of type 'String' to expected argument type 'Binding<String>'
```

You handed over the value. It wanted the wire.

```swift
TextField("Name", text: name)    // wrong
TextField("Name", text: $name)   // right
```

### 2. Extra `$`

```
No exact matches in call to initializer
```

You handed over the wire. It wanted the value.

```swift
Text($name)   // wrong
Text(name)    // right
```

### 3. No `@State`

```
Cannot assign to property: 'self' is immutable
```

Yesterday's error, new place.

```swift
var name = ""                    // wrong
@State private var name = ""     // right
```

### 4. Two variables, one field

**No error at all.** You type and nothing changes on screen.

The field is wired to one variable and the `Text` reads a different one. Read both names out loud, character for character.

```swift
@State private var name = ""
@State private var userName = ""

TextField("Name", text: $name)
Text("Hello, \(userName)")     // wrong variable. Silent failure.
```

---

## Quick fault-finding order

1. Does the error message contain the word **`Binding`**? → it is the dollar sign.
2. Does it say **`Double`** or **`Int`**? → it is the slider's `@State` line.
3. Does it say **immutable**? → `@State` is missing.
4. Does it say **cannot find ... in scope**? → Cmd-A, Ctrl-I, and look at the left edge.
5. No error, but nothing happens? → the field and the `Text` are on different variables.

---

## Safe SF Symbols for forms

```
person.fill       envelope.fill      lock.fill        bell.fill
bell.slash        calendar           creditcard.fill  checkmark.seal.fill
star.fill         heart.fill         flag.fill        tag.fill
gearshape.fill    location.fill      phone.fill       globe
```

A blank square means that name does not exist. Swap it for `star.fill` and move on. Never spend build time hunting symbol names.

---

## Shortcuts

```
Cmd-R          Run                   Cmd-Shift-Y    Console
Cmd-.          Stop                  Cmd-Shift-F    Find in workspace
Cmd-Z          Undo                  Option-Cmd-P   Resume Canvas
Cmd-A, Ctrl-I  Tidy the file         Cmd-S          Screenshot (in the simulator)
```
