# Swift Basics Cheat Sheet

**Day 1** · SwiftUI Digital Prototyping · SG Code Campus
Print double-sided. Keep it beside your laptop all three days.

---

## 1. Constants and variables

```swift
let country = "Indonesia"    // constant — cannot change
var score = 0                // variable — can change

score = 10                   // fine
score = score + 5            // score is now 15

// country = "Singapore"     // ERROR: cannot assign to a let
```

**Rule of thumb:** start with `let`. Change it to `var` only when the compiler complains.

| You want | Use |
| --- | --- |
| A value that never changes | `let` |
| A value that must change later | `var` |

---

## 2. The core types

```swift
let name: String = "Aisyah"       // text, always in double quotes
let years: Int = 4                // whole number: 4, 0, -12
let rating: Double = 4.8          // decimal number: 4.8, 0.5
let isAvailable: Bool = true      // true or false only
```

Swift can usually work out the type by itself — this is **type inference**:

```swift
let city = "Bandung"    // String
let count = 7           // Int
let price = 19.99       // Double
let flag = false        // Bool
```

Option-click any name in Xcode to see the type Swift chose.

### Things that catch people out

```swift
let a = "42"        // String, not Int — quotes make it text
let e = 10 / 3      // 3, not 3.33 — Int division drops the remainder
let f = 10.0 / 3.0  // 3.3333333333333335 — Double division

let n = 5
let d = 2.5
// let sum = n + d           // ERROR: Int and Double do not mix
let sum = Double(n) + d      // 7.5 — convert first
```

---

## 3. String interpolation

Put a value inside text with **backslash, open bracket, value, close bracket**.

```swift
let name = "Budi"
let years = 4

let bio = "\(name) has \(years) years of experience."
print(bio)
// Budi has 4 years of experience.
```

The backslash is `\` — on most Mac keyboards it sits just above the Return key.

### Useful String things

```swift
let shout = "selamat pagi".uppercased()   // SELAMAT PAGI
let quiet = "JAKARTA".lowercased()        // jakarta
let joined = "Hello, " + "world"          // Hello, world
let letters = "Putri".count               // 5
let first = "Putri".prefix(1)             // P
```

> `+` joins two Strings only. To mix in a number, use `\( )`.

---

## 4. Making decisions with `if` / `else`

```swift
let years = 4

if years >= 5 {
    print("Senior")
} else if years >= 2 {
    print("Mid-level")
} else {
    print("Junior")
}
// Mid-level
```

Swift checks each condition from the top and stops at the first one that is true.

### Comparison and logic

| Symbol | Means | Example |
| --- | --- | --- |
| `==` | is equal to | `years == 4` |
| `!=` | is not equal to | `city != "Jakarta"` |
| `>` `<` | greater / less than | `years > 2` |
| `>=` `<=` | greater / less than or equal | `years >= 5` |

Combining conditions:

```swift
let years = 4
let isLead = false

// && means AND — both sides must be true
if years > 2 && isLead == false {
    print("Mid-level, not a lead")
}

// || means OR — either side can be true
if years > 9 || isLead {
    print("Senior or leading")
}

// ! means NOT — it flips true and false
if !isLead {
    print("Not a lead")
}
```

**One equals sign assigns. Two equals signs compare.** `=` and `==` are the most common typo in your first week.

---

## 5. Functions

```swift
func greeting(name: String) -> String {
    return "Selamat datang, \(name)!"
}

let message = greeting(name: "Aisyah")
print(message)
// Selamat datang, Aisyah!
```

| Piece | Meaning |
| --- | --- |
| `func` | I am making a function |
| `greeting` | its name |
| `(name: String)` | what it needs, and the type |
| `-> String` | what it gives back |
| `return` | the answer |

### Two inputs

```swift
func tagline(role: String, city: String) -> String {
    return "\(role) · \(city)"
}

print(tagline(role: "Designer", city: "Jakarta"))
// Designer · Jakarta
```

**Labels are required when you call it.** `tagline("Designer", "Jakarta")` will not compile, and the order must match the definition.

### A function that decides

```swift
func yearsLabel(years: Int) -> String {
    if years == 1 {
        return "1 year of experience"
    } else {
        return "\(years) years of experience"
    }
}
```

Every path out of a function that promises `-> String` must `return` a String. An `if` with no `else` is the usual cause of *"Missing return in a function expected to return 'String'"*.

### Hiding the label

```swift
func shout(_ text: String) -> String {
    return text.uppercased() + "!"
}

print(shout("selamat pagi"))   // SELAMAT PAGI!
```

The underscore goes in the **definition**, never in the call. Labels are never wrong — use the underscore only when the function name already says everything.

---

## 6. Comments

```swift
// One line of explanation

/*
   Several lines.
   Useful for turning code off temporarily.
*/
```

Select lines and press **Cmd-/** to comment or uncomment them.

---

## 7. Error messages, translated

| Swift says | It means | Fix |
| --- | --- | --- |
| Cannot find 'x' in scope | Typo, or used before it was made | Check the spelling |
| Cannot assign to value: 'x' is a 'let' constant | You changed a constant | `let` → `var` |
| Cannot convert value of type 'Int' to expected argument type 'String' | Number where text belongs | Wrap it: `"\(n)"` |
| Binary operator '+' cannot be applied to 'Int' and 'Double' | Mixed number types | `Double(n) + d` |
| Missing return in a function expected to return 'String' | A branch with no `return` | Add `else` and `return` |
| Expected expression / unterminated string literal | Missing quote or bracket | Count your quotes |
| Extra argument in call | Label or order wrong | Compare with the definition |

**Always fix the topmost error first**, then rebuild. One missing bracket often produces five errors.

---

## 8. The shape of every SwiftUI file

```swift
import SwiftUI

// functions live here, at file level

struct ContentView: View {
    // constants live here

    var body: some View {
        // views live here
    }
}

#Preview {
    ContentView()
}
```

`body` holds **views**, not statements. `print()` does not belong inside it.
