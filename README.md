# The Password Game - Flutter Edition

A challenging password creation game built with Flutter. Create a password that satisfies 15 progressively complex rules, one rule at a time.

## 📋 Features

- **Single Rule at a Time**: Focus on one rule per step
- **Smart Backtracking**: If your password violates an earlier rule, the game resets to that rule
- **16 Unique Rules**: Mix of length, character types, math, dates, and pattern rules
- **Real-time Validation**: Instant feedback on whether your password passes the current rule
- **Modern UI**: Clean design with gradient backgrounds and smooth animations
- **Responsive Layout**: Works on web, mobile, and desktop

## 🏗️ Project Architecture

The project follows a **feature-first, layered architecture** for scalability and maintainability:

```
lib/
├── main.dart                          # App entrypoint (just runApp)
├── app/
│   └── password_game_app.dart         # MaterialApp configuration & theme
└── features/
    └── password_game/
        ├── models/
        │   └── password_rule.dart     # PasswordRule data class
        ├── data/
        │   └── password_rules.dart    # All 15 rule definitions
        ├── utils/
        │   └── password_validators.dart # Reusable validation logic
        ├── components/
        │   ├── password_input_card.dart
        │   ├── rule_progress_card.dart
        │   ├── active_rule_card.dart
        │   └── completion_card.dart
        └── page/
            └── password_game_page.dart # Main game logic & state
```

### Layer Explanation

1. **App Layer** (`app/`): Bootstraps the entire Flutter app with theme and routing.
2. **Models** (`models/`): Pure data classes (no logic) representing domain entities.
3. **Data Layer** (`data/`): Rule definitions and initial data.
4. **Utils** (`utils/`): Reusable validation functions without UI dependency.
5. **Components** (`components/`): Stateless UI widgets that receive data via constructor.
6. **Page** (`page/`): Stateful widget managing game state and orchestrating components.

## 🎮 How to Play

1. Type a password in the input field
2. Press **"Create password"** to validate
3. If your password fails the current rule, you stay on that rule
4. If it violates an earlier rule, you are taken back to that earlier rule
5. If all rules pass, you see the victory screen

## 📱 Running the App

### Prerequisites

- Flutter 3.11.4+ installed ([Get Flutter](https://flutter.dev/docs/get-started/install))
- A supported device or emulator

### Run on Web (Browser)

```bash
flutter run -d edge    # or chrome, firefox
```

### Run on Android Emulator

```bash
# Make sure an emulator is running
flutter emulators
flutter run -d <emulator_id>
```

### Run on iOS Simulator

```bash
flutter run -d macos
```

### Run on Windows Desktop

```bash
# Requires Visual Studio with C++ build tools
flutter run -d windows
```

### Build for Release

```bash
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
flutter build windows      # Windows
```

## 📝 The 16 Rules

| # | Rule | Description |
|---|------|-------------|
| 1 | At least 5 characters | Password must be 5+ chars long |
| 2 | Contains a digit | Include one number (0-9) |
| 3 | Contains uppercase | Include one letter A-Z |
| 4 | Special character | Use one symbol: !@#%^&*(),.?":{}..etc |
| 5 | Sum of digits = 25 | Add all digits in password, total must be 25 |
| 6 | Contains current month | Include current month as MM or M |
| 7 | Roman numeral | Include I, V, X, L, C, D, or M |
| 8 | Basic color name | Include red, blue, green, yellow, etc. |
| 9 | Prime length | Password length must be a prime number (2,3,5,7,11,13...) |
| 10 | No triple repeat | No character can appear 3+ times in a row |
| 11 | Lowercase letter | Include one letter a-z |
| 12 | No whitespace | Cannot contain spaces or tabs |
| 13 | Weekday name | Include monday, tuesday, wednesday...sunday |
| 14 | At least 2 vowels | Must contain a,e,i,o,u at least twice |
| 15 | No leading digit | First character must not be a number |
| 16 | Maximum 20 characters | Password must not exceed 20 characters |

## 💡 Understanding Dart Naming Conventions: The Underscore (`_`)

In Dart, the underscore prefix `_` has a specific meaning:

### Private Members

Any class member, method, or variable prefixed with `_` is **private to that file**:

```dart
class MyClass {
  String _privateField = "only visible in this file";  // Private variable
  
  void _privateMethod() {                              // Private method
    // can only be called from within this file
  }
  
  void publicMethod() {                                // Public method
    _privateMethod();  // OK: calling from same file
  }
}

// In another file:
// _privateMethod()  ❌ ERROR: Not accessible
// publicMethod()    ✅ OK: Accessible
```

### Examples in This Codebase

1. **`_firstFailedRuleIndex()`** in `password_game_page.dart`
   - Prefixed with `_` because it's a helper method used only within the page
   - Not intended to be called from other files
   - Keeps the public interface clean

2. **`_controller`** in `password_game_page.dart`
   - A private TextEditingController used only in this widget
   - Hidden from outside files

3. **`_sumDigits()`, `_isPrime()`, `_hasTripleRepeat()`** in `password_validators.dart`
   - Private static methods used internally by the validation logic
   - Implementation details that users don't need to know about

4. **`_rules`** in `password_game_page.dart`
   - Private list of rules; initialized in `initState()`
   - Managed only by the page state

5. **`_RuleTile`, `_RuleProgressHeader`** (widget classes)
   - These are private stateless widgets used internally within the page
   - Not exported for use in other parts of the app

### Why Use `_`?

✅ **Encapsulation**: Hide internal implementation details  
✅ **Clean API**: Show only what's necessary to users of the class  
✅ **Avoid Confusion**: Signals to developers "don't use this outside"  
✅ **Safer Refactoring**: Can change private members without breaking other code  

## 🧪 Testing

Run the test suite:

```bash
flutter test
```

The test in `test/widget_test.dart` validates:
- App boots correctly
- First rule is displayed
- Action button is present
- Progress indicator shows correct rule count

## 🔧 Development Workflow

### Add a New Rule

1. Open `lib/features/password_game/data/password_rules.dart`
2. Add a new `PasswordRule` to the list in `PasswordRules.build()`
3. If you need a new validator, add it to `password_validators.dart`
4. Update tests if necessary

### Modify UI

1. Edit the component in `lib/features/password_game/components/`
2. Or adjust the main page layout in `password_game_page.dart`
3. Test with hot reload: Press `r` in the terminal during `flutter run`

### Change Theme

Edit `lib/app/password_game_app.dart` to modify colors, fonts, and Material 3 theme.

## 📚 Further Reading

- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Widget Catalog](https://flutter.dev/docs/development/ui/widgets)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

## 📄 License

This project is open source and available under the MIT License.
