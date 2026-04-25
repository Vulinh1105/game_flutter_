class PasswordValidators {
  static const List<String> basicColors = <String>[
    'red',
    'blue',
    'green',
    'yellow',
    'black',
    'white',
    'orange',
    'purple',
    'pink',
    'brown',
    'gray',
    'grey',
  ];

  static const List<String> weekdays = <String>[
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  static int sumDigits(String text) {
    return text
        .split('')
        .where((String ch) => RegExp(r'\d').hasMatch(ch))
        .fold<int>(0, (int sum, String digit) => sum + int.parse(digit));
  }

  static bool containsCurrentMonth(String text) {
    final int month = DateTime.now().month;
    final String withLeadingZero = month.toString().padLeft(2, '0');
    final String withoutLeadingZero = month.toString();
    return text.contains(withLeadingZero) || text.contains(withoutLeadingZero);
  }

  static bool isPrime(int n) {
    if (n < 2) {
      return false;
    }
    if (n == 2) {
      return true;
    }
    if (n % 2 == 0) {
      return false;
    }

    for (int i = 3; i * i <= n; i += 2) {
      if (n % i == 0) {
        return false;
      }
    }

    return true;
  }

  static bool hasTripleRepeat(String text) {
    if (text.length < 3) {
      return false;
    }

    for (int i = 2; i < text.length; i++) {
      if (text[i] == text[i - 1] && text[i - 1] == text[i - 2]) {
        return true;
      }
    }

    return false;
  }

  static bool hasWeekday(String text) {
    final String lower = text.toLowerCase();
    return weekdays.any(lower.contains);
  }

  static bool hasAtLeastNVowels(String text, int minimum) {
    final int count = RegExp(r'[aeiouAEIOU]').allMatches(text).length;
    return count >= minimum;
  }
}
