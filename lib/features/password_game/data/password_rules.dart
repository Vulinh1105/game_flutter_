import 'package:game_flutter/features/password_game/models/password_rule.dart';
import 'package:game_flutter/features/password_game/utils/password_validators.dart';

class PasswordRules {
  static List<PasswordRule> build() {
    return <PasswordRule>[
      PasswordRule(
        id: 1,
        title: 'At least 5 characters',
        detail: 'Password must have at least 5 characters.',
        check: (String text) => text.length >= 5,
      ),
      PasswordRule(
        id: 2,
        title: 'Contains a digit',
        detail: 'At least one numeric character is required.',
        check: (String text) => RegExp(r'\d').hasMatch(text),
      ),
      PasswordRule(
        id: 3,
        title: 'Contains an uppercase letter',
        detail: 'Include one uppercase letter from A-Z.',
        check: (String text) => RegExp(r'[A-Z]').hasMatch(text),
      ),
      PasswordRule(
        id: 4,
        title: 'Contains a special character',
        detail: 'Use one symbol such as ! @ # % ^ & *.',
        check: (String text) => RegExp(
          r'''[!@#\$%\^&*(),.?":{}|<>_\-\[\]\\/+=;']''',
        ).hasMatch(text),
      ),
      PasswordRule(
        id: 5,
        title: 'Sum of digits equals 25',
        detail: 'Add all digits in the password, the total must be 25.',
        check: (String text) => PasswordValidators.sumDigits(text) == 25,
      ),
      PasswordRule(
        id: 6,
        title: 'Contains current month',
        detail: 'Include the current month as M or MM.',
        check: (String text) => PasswordValidators.containsCurrentMonth(text),
      ),
      PasswordRule(
        id: 7,
        title: 'Contains a Roman numeral',
        detail: 'Include one of I, V, X, L, C, D, M.',
        check: (String text) => RegExp(r'[IVXLCDM]').hasMatch(text),
      ),
      PasswordRule(
        id: 8,
        title: 'Contains a basic color name',
        detail: 'Example: red, blue, green, yellow.',
        check: (String text) {
          final String lower = text.toLowerCase();
          return PasswordValidators.basicColors.any(lower.contains);
        },
      ),
      PasswordRule(
        id: 9,
        title: 'Length is prime',
        detail: 'The password length must be a prime number.',
        check: (String text) => PasswordValidators.isPrime(text.length),
      ),
      PasswordRule(
        id: 10,
        title: 'No triple repeated characters',
        detail: 'The same character must not appear 3 times in a row.',
        check: (String text) => !PasswordValidators.hasTripleRepeat(text),
      ),
      PasswordRule(
        id: 11,
        title: 'Contains a lowercase letter',
        detail: 'Include at least one lowercase letter from a-z.',
        check: (String text) => RegExp(r'[a-z]').hasMatch(text),
      ),
      PasswordRule(
        id: 12,
        title: 'No whitespace',
        detail: 'Password cannot contain spaces or tabs.',
        check: (String text) => !RegExp(r'\s').hasMatch(text),
      ),
      PasswordRule(
        id: 13,
        title: 'Contains a weekday name',
        detail: 'Include one weekday name like monday or friday.',
        check: (String text) => PasswordValidators.hasWeekday(text),
      ),
      PasswordRule(
        id: 14,
        title: 'At least 2 vowels',
        detail: 'Password needs two or more vowels (a, e, i, o, u).',
        check: (String text) => PasswordValidators.hasAtLeastNVowels(text, 2),
      ),
      PasswordRule(
        id: 15,
        title: 'Cannot start with a digit',
        detail: 'First character must not be numeric.',
        check: (String text) =>
            text.isNotEmpty && !RegExp(r'^\d').hasMatch(text),
      ),
      PasswordRule(
        id: 16,
        title: 'Maximum 20 characters',
        detail: 'Password must not exceed 20 characters.',
        check: (String text) => text.length <= 20,
      ),
    ];
  }
}
