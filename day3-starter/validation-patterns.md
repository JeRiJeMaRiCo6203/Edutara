# Validation Patterns

**Day 3** · SwiftUI Digital Prototyping · SG Code Campus
Copy-paste ready. Everything here compiles on iOS 17.

---

## The idea in one sentence

> **Validation is not a SwiftUI feature. It is a function you write.**

There is no `.validate()` modifier. There is a function that takes a value in and gives an answer back — exactly the shape you learned on Day 1.

---

## Where validators live

In their **own file**. Right-click the yellow folder ▸ **New File from Template… ▸ iOS ▸ Swift File**, named `Validation`.

```swift
import Foundation      // NOT import SwiftUI
```

Three reasons:

1. Nothing in here draws anything. It holds rules, not screens — the same split as `Destination.swift` on Day 2.
2. You can use the same validator from four different screens.
3. When your form breaks, you know instantly whether the problem is a rule or a view.

**Every function starts at the left edge of the file.** If it is indented, it is inside something, and you will get "Cannot find 'isNotEmpty' in scope".

---

## Pattern 1 · Return a `Bool`

Use this when you only need to know **whether** something is acceptable.

```swift
func isNotEmpty(_ text: String) -> Bool {
    let trimmed = text.trimmingCharacters(in: .whitespaces)
    return trimmed.isEmpty == false
}
```

```swift
isNotEmpty("")        // false
isNotEmpty("   ")     // false  <- this is why we trim
isNotEmpty("Rina")    // true
```

Good for: disabling a button, showing or hiding a section, changing a colour.

---

## Pattern 2 · Return an optional `String`

Use this when you need to tell the user **what** is wrong.

```swift
func nameError(_ name: String) -> String? {
    if isNotEmpty(name) == false {
        return "Please enter your name."
    }
    if isLongEnough(name, minimum: 2) == false {
        return "That is too short."
    }
    return nil
}
```

| It returns | It means |
| --- | --- |
| A sentence | Something is wrong. Show this to the user. |
| `nil` | Nothing is wrong. |

`String?` — the question mark means **"a message, or nothing"**.
`nil` means **nothing there**. Not zero. Not empty text. Nothing.

> **Never return `""` instead of `nil`.** An empty string is still a string, so the message block runs and you get an invisible red `Text` pushing your layout around on every valid form.

---

## Which one do I use?

| Job | Pattern |
| --- | --- |
| Disable a button | `Bool` |
| Show a red message under a field | `String?` |
| Both (normal) | Write the `String?` one, then check `== nil` for the button |

```swift
// The String? version does both jobs
if let message = nameError(name) { /* show it */ }
.disabled(nameError(name) != nil)
```

---

## The three copy-paste validators

### 1 · Non-empty

```swift
func isNotEmpty(_ text: String) -> Bool {
    let trimmed = text.trimmingCharacters(in: .whitespaces)
    return trimmed.isEmpty == false
}
```

**Trim first, always.** Without it, three presses of the spacebar is a valid name.

### 2 · Email-shaped

```swift
func looksLikeEmail(_ text: String) -> Bool {
    let trimmed = text.trimmingCharacters(in: .whitespaces)
    let parts = trimmed.split(separator: "@")
    guard parts.count == 2 else { return false }
    return parts[0].isEmpty == false && parts[1].contains(".")
}
```

Read it in English: *split at the `@`; there must be exactly two pieces; the left piece is not empty and the right piece has a dot in it.*

| Input | Result |
| --- | --- |
| `"rina@example.co"` | `true` |
| `"rina"` | `false` — no `@` |
| `"@example.co"` | `false` — nothing before the `@` |
| `"rina@example"` | `false` — no dot after the `@` |
| `"a@b@c.co"` | `false` — two `@` |

The `guard` is what makes `parts[1]` safe. Without it, an address with no `@` crashes the app.

> This is a **prototype** check, not a real one. Real email validation is a much bigger problem. This is honest, readable and good enough to demo.

### 3 · Minimum length, and minimum age

```swift
func isLongEnough(_ text: String, minimum: Int) -> Bool {
    let trimmed = text.trimmingCharacters(in: .whitespaces)
    return trimmed.count >= minimum
}

func isOldEnough(_ age: Int, minimum: Int = 18) -> Bool {
    return age >= minimum
}
```

Use them:

```swift
isLongEnough(password, minimum: 8)
isOldEnough(Int(ageSlider))              // slider value is a Double
isOldEnough(Int(ageSlider), minimum: 21)
```

`minimum: Int = 18` gives the parameter a default, so `isOldEnough(21)` works too.

---

## Showing the error inline

```swift
Section("Your details") {
    TextField("Name", text: $name)

    if let message = nameError(name) {
        Text(message)
            .font(.caption)
            .foregroundStyle(.red)
    }
}
```

Read `if let` in English: *if there is a message, call it `message` and show it.*

When `nameError` returns `nil`, the whole block is skipped and nothing appears.

### The "it shouts at me before I have typed anything" fix

The message above is correct — an empty field really is invalid — but it is unfriendly. Wait until the user has typed something at least once:

```swift
@State private var name = ""
@State private var nameTouched = false

TextField("Name", text: $name)
    .onChange(of: name) {
        nameTouched = true
    }

if nameTouched, let message = nameError(name) {
    Text(message)
        .font(.caption)
        .foregroundStyle(.red)
}
```

`if nameTouched, let message = ...` reads as *"if they have typed, and there is a message"*. Both must be true.

> `.onChange(of:)` with a no-argument closure is the iOS 17 form. This is polish — add it once everything else works.

### One error line, written once

Four fields means four copies of that block, unless you write a small helper:

```swift
@ViewBuilder
func errorLine(_ message: String?) -> some View {
    if let message {
        Text(message)
            .font(.caption)
            .foregroundStyle(.red)
    }
}
```

Then each field is two lines:

```swift
TextField("Email", text: $email)
errorLine(emailError(email))
```

---

## Disabling submit

```swift
var formIsValid: Bool {
    nameError(name) == nil
        && emailError(email) == nil
        && passwordError(password) == nil
        && agreedToTerms
}

Button("Create account") {
    showConfirmation = true
}
.buttonStyle(.borderedProminent)
.disabled(formIsValid == false)
```

**Rules for this block:**

- **One clause per line.** Adding a rule is adding a line.
- **`.disabled` goes after the closing brace**, attached to the button. Inside the braces it is an error.
- **Write `== false`, not `!`.** `.disabled(formIsValid == false)` reads left to right. `.disabled(!formIsValid)` hides the meaning in one easy-to-miss character.
- **Every red message should have a matching clause here.** If a rule is not in `formIsValid`, its message is decoration.

> **The best error message is a button the user cannot press yet.**

---

## When the button never turns blue

This is the most common validation bug, and it has no error message. Do **not** stare at it.

1. Comment out the **first** clause of `formIsValid`. Run. Look at the button.
2. Still grey? Comment out the next one. Run. Look again.
3. When the button turns blue, **the last clause you removed is the broken one**.
4. Put them all back and fix that one.

```swift
var formIsValid: Bool {
    nameError(name) == nil
//      && emailError(email) == nil     <- comment out, one at a time
        && passwordError(password) == nil
}
```

It is almost always the email rule, and almost always because the test address has no dot after the `@`.

Its mirror image is **the button that is always blue**, which is always `.disabled(formIsValid)` missing the `== false`.

---

## Validation faults at a glance

| Symptom | Cause | Fix |
| --- | --- | --- |
| Button never turns blue | One rule can never pass | Comment out rules one at a time |
| Button always blue | `.disabled(formIsValid)` | Add `== false` |
| "Cannot find 'isNotEmpty' in scope" | Function inside a struct, or file outside the target | Cmd-A, Ctrl-I. Check the target is ticked |
| "Value of optional type 'String?' must be unwrapped" | `String?` used directly in a `Text` | Wrap it in `if let` |
| Red message on a valid form | A validator returns `""` instead of `nil` | Return `nil` |
| `"   "` passes as a name | No trim | `trimmingCharacters(in: .whitespaces)` |
| Message appears before any typing | Correct, but unfriendly | Add the `nameTouched` flag |
| Crash on a weird email | `parts[1]` with no guard | `guard parts.count == 2 else { return false }` |

---

## The complete starting file

Paste this into `Validation.swift` and change the rules to fit your form.

```swift
import Foundation

// ---- building blocks ----

func isNotEmpty(_ text: String) -> Bool {
    let trimmed = text.trimmingCharacters(in: .whitespaces)
    return trimmed.isEmpty == false
}

func isLongEnough(_ text: String, minimum: Int) -> Bool {
    let trimmed = text.trimmingCharacters(in: .whitespaces)
    return trimmed.count >= minimum
}

func looksLikeEmail(_ text: String) -> Bool {
    let trimmed = text.trimmingCharacters(in: .whitespaces)
    let parts = trimmed.split(separator: "@")
    guard parts.count == 2 else { return false }
    return parts[0].isEmpty == false && parts[1].contains(".")
}

func isOldEnough(_ age: Int, minimum: Int = 18) -> Bool {
    return age >= minimum
}

// ---- messages for the user ----

func nameError(_ name: String) -> String? {
    if isNotEmpty(name) == false {
        return "Please enter your name."
    }
    if isLongEnough(name, minimum: 2) == false {
        return "That is too short."
    }
    return nil
}

func emailError(_ email: String) -> String? {
    if isNotEmpty(email) == false {
        return "Please enter your email."
    }
    if looksLikeEmail(email) == false {
        return "That does not look like an email address."
    }
    return nil
}

func passwordError(_ password: String) -> String? {
    if isNotEmpty(password) == false {
        return "Please choose a password."
    }
    if isLongEnough(password, minimum: 8) == false {
        return "At least 8 characters, please."
    }
    return nil
}
```

**Order your checks from most basic to most specific.** An empty field should say "please enter your email", not "that does not look like an email address". Message quality comes from the ordering, not from clever code.
