typedef PasswordRuleCheck = bool Function(String text);

class PasswordRule {
  const PasswordRule({
    required this.id,
    required this.title,
    required this.detail,
    required this.check,
  });

  final int id;
  final String title;
  final String detail;
  final PasswordRuleCheck check;
}
