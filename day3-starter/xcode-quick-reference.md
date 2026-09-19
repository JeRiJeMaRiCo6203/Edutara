# Xcode Quick Reference

**Day 1** · SwiftUI Digital Prototyping · SG Code Campus
Keep this open on your desk. You will need it every day this week.

---

## 1. The Xcode window

```
┌──────────────────────────────────────────────────────────────┐
│  TOOLBAR      ▶ Run   ■ Stop   [ iPhone 16 ▾ ]               │
├────────────┬──────────────────────────┬──────────────────────┤
│            │                          │                      │
│ NAVIGATOR  │        EDITOR            │      CANVAS          │
│            │                          │                      │
│ your files │   where you type code    │   live preview of    │
│            │                          │   your screen        │
│            │                          │                      │
│            ├──────────────────────────┤──────────────────────┤
│            │  CONSOLE                 │   INSPECTOR          │
│            │  print() output and      │   settings for the   │
│            │  runtime messages        │   selected thing     │
└────────────┴──────────────────────────┴──────────────────────┘
```

| Area | What it is for |
| --- | --- |
| **Navigator** (left) | Your project's files. Click a file to open it. |
| **Editor** (middle) | Where you type. |
| **Canvas** (right) | Live preview, driven by `#Preview`. |
| **Inspector** (far right) | Settings for whatever is selected. Rarely needed this week. |
| **Console** (bottom) | Where `print()` output and error messages appear. |
| **Toolbar** (top) | Run, Stop, and the run destination (which simulator). |

---

## 2. Shortcuts worth memorising

### Every day

| Shortcut | Does |
| --- | --- |
| **Cmd-R** | Run in the simulator |
| **Cmd-.** | Stop |
| **Cmd-S** | Save |
| **Cmd-Z** | Undo (your best friend) |
| **Cmd-/** | Comment or uncomment the selected lines |
| **Ctrl-I** | Re-indent the selected code |
| **Cmd-A** then **Ctrl-I** | Tidy the whole file — makes brace errors obvious |

### Showing and hiding panes

| Shortcut | Does |
| --- | --- |
| **Cmd-0** | Navigator on / off |
| **Cmd-Shift-Y** | Console on / off |
| **Option-Cmd-Return** | Canvas on / off |
| **Option-Cmd-P** | Resume the Canvas |
| **Cmd-Option-0** | Inspector on / off |

### Finding things

| Shortcut | Does |
| --- | --- |
| **Cmd-Shift-O** | Open Quickly — type a file name and jump to it |
| **Cmd-F** | Find in this file |
| **Cmd-Shift-F** | Find in the whole project |
| **Option-click a name** | Show its type and documentation |
| **Cmd-click a name** | Jump to where it is defined |

### When things go wrong

| Shortcut | Does |
| --- | --- |
| **Shift-Cmd-K** | Clean Build Folder — clears stale build results |
| **Cmd-B** | Build without running |
| **Cmd-Q** | Quit Xcode (the universal fix) |

---

## 3. Canvas controls

The Canvas is the live preview on the right. It is driven by the `#Preview` block at the bottom of your file.

```swift
#Preview {
    ContentView()
}
```

| Control | Where | Does |
| --- | --- | --- |
| **Resume** | Top right of the Canvas | Restarts a paused preview |
| **Play / Live** ▶ | Top of the Canvas | Makes the preview interactive |
| **Device selector** | Top of the Canvas | Preview on a different iPhone |
| **+ / −** | Bottom of the Canvas | Zoom in and out |
| **Light / Dark** | Canvas toolbar | Check your colours in both appearances |

**If the Canvas says "Automatic preview updating paused":** click **Resume**, or press **Option-Cmd-P**. If it pauses again straight away, there is a build error in the file — fix the topmost red error first.

**If the Canvas is blank and Resume does nothing:**
1. Check `#Preview { ContentView() }` is still at the bottom of the file.
2. **Shift-Cmd-K** (Clean Build Folder), then Resume.
3. Quit Xcode with **Cmd-Q** and reopen the project. This takes a minute and fixes it nearly every time.

---

## 4. Simulator basics

The simulator is a real iPhone running on your Mac. It is not a picture.

### Getting there

- Choose an **iPhone 16** (or any iPhone) in the toolbar destination menu.
- Press **Cmd-R**.
- The first launch of the day takes 30–90 seconds. After that it is fast.

### Controlling it

| Action | How |
| --- | --- |
| Home | **Cmd-Shift-H** |
| Rotate | **Cmd-←** / **Cmd-→** |
| Resize the window | **Cmd-1**, **Cmd-2**, **Cmd-3**, or Window ▸ Physical Size |
| Screenshot | **Cmd-S** (saves to the Desktop) |
| Shake | Device ▸ Shake |
| Dark mode | Features ▸ Toggle Appearance |

### Housekeeping

- You do not need to quit the simulator between runs. Leave it open.
- If the app behaves strangely, long-press its icon on the simulated home screen and delete it, then Cmd-R again.
- If the simulator itself is stuck: Device ▸ Restart, or quit the Simulator app.

---

## 5. Creating a project, correctly

**File ▸ New ▸ Project…**

| Setting | Choose |
| --- | --- |
| Platform | **iOS** |
| Template | **App** |
| Product Name | as given in the README |
| Team | **None** (fine for simulator work) |
| Organization Identifier | `com.sgcodecampus` |
| Interface | **SwiftUI** |
| Language | **Swift** |
| Storage | **None** |
| Include Tests | **unchecked** |

Save it to your **Desktop** so the facilitator can find it when you need help.

> If Interface says **Storyboard**, go back. Storyboard is the old way and nothing in this course will match your screen.

---

## 6. Adding an image to Assets.xcassets

You do not need this for Day 1 — we use SF Symbols — but here is the process.

1. Click **Assets** in the Navigator.
2. Drag your image file into the empty area on the left.
3. Click the name under the image and rename it, for example `profilePhoto`.
4. Use it in code with exactly that name: `Image("profilePhoto")`.

The name is case-sensitive. `Image("ProfilePhoto")` will not find `profilePhoto`, and it fails **silently** — you see nothing, with no error.

---

## 7. The four errors you will hit on day one

### 1. "Cannot find 'x' in scope"

**What you see:** a red mark next to a name you just typed.
**What it means:** Swift has never heard of that word. Almost always a typo, or you used something before you created it.
**Fix:** check the spelling, character by character. Swift is case-sensitive: `myName` and `myname` are two different things.

### 2. "Automatic preview updating paused"

**What you see:** the Canvas greys out and stops responding.
**What it means:** Xcode stopped rebuilding the preview, usually because the file did not compile a moment ago.
**Fix:** click **Resume** (or **Option-Cmd-P**). If it pauses immediately again, scroll up and fix the topmost red error first, then Resume.

### 3. The image fills the entire screen

**What you see:** one giant stretched icon and nothing else.
**What it means:** you wrote `.resizable()` without telling the image what size to be.
**Fix:** three lines, always in this order:

```swift
Image(systemName: "star.fill")
    .resizable()
    .scaledToFit()
    .frame(width: 80, height: 80)
```

### 4. Red everywhere after one edit

**What you see:** ten errors appear after you deleted or typed one character.
**What it means:** you broke a brace pair. Everything after it is now nonsense to the compiler.
**Fix:** **Cmd-Z** until the red clears. Then select all (**Cmd-A**) and re-indent (**Ctrl-I**) — badly nested braces jump out visually. Click any `{` and Xcode highlights its partner.

---

## 8. Habits that save you hours

- **Save often.** Cmd-S is free.
- **Fix the topmost error first.** One real problem often produces five messages.
- **Read the error out loud.** Most people solve it while reading it.
- **Type, do not paste.** Pasted quotes from chat apps are curly and Swift rejects them.
- **Keep the Console open.** Silent failures are usually explained down there.
- **Sticky note up after two minutes stuck.** Nobody sits stuck in silence.
