import 'package:flutter/material.dart';

void main() {
  runApp(const PasswordGameApp());
}

class PasswordGameApp extends StatelessWidget {
  const PasswordGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Password Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        useMaterial3: true,
      ),
      home: const PasswordGamePage(),
    );
  }
}

class PasswordRule {
  PasswordRule({required this.description, required this.check});

  final String description;
  final bool Function(String) check;
}

class PasswordGamePage extends StatefulWidget {
  const PasswordGamePage({super.key});

  @override
  State<PasswordGamePage> createState() => _PasswordGamePageState();
}

class _PasswordGamePageState extends State<PasswordGamePage> {
  final TextEditingController _controller = TextEditingController();
  late final List<PasswordRule> _rules;
  String _password = '';
  int _activeRuleIndex = 0;
  bool _completed = false;

  static const List<String> _basicColors = <String>[
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

  @override
  void initState() {
    super.initState();
    _rules = <PasswordRule>[
      PasswordRule(
        description: '1) Password co it nhat 5 ky tu.',
        check: (String text) => text.length >= 5,
      ),
      PasswordRule(
        description: '2) Co it nhat 1 chu so.',
        check: (String text) => RegExp(r'\d').hasMatch(text),
      ),
      PasswordRule(
        description: '3) Co it nhat 1 chu cai viet hoa.',
        check: (String text) => RegExp(r'[A-Z]').hasMatch(text),
      ),
      PasswordRule(
        description: '4) Co ky tu dac biet (!@#%^&*...).',
        check: (String text) => RegExp(
          r'''[!@#\$%\^&*(),.?":{}|<>_\-\[\]\\/+=;']''',
        ).hasMatch(text),
      ),
      PasswordRule(
        description: '5) Tong tat ca chu so bang 25.',
        check: (String text) => _sumDigits(text) == 25,
      ),
      PasswordRule(
        description: '6) Chua thang hien tai (01-12 hoac 1-12).',
        check: (String text) => _containsCurrentMonth(text),
      ),
      PasswordRule(
        description: '7) Chua so La Ma (I, V, X, L, C, D, M).',
        check: (String text) => RegExp(r'[IVXLCDM]').hasMatch(text),
      ),
      PasswordRule(
        description: '8) Chua ten 1 mau co ban (vi du: red, blue, green).',
        check: (String text) {
          final String lower = text.toLowerCase();
          return _basicColors.any(lower.contains);
        },
      ),
      PasswordRule(
        description: '9) Do dai password la so nguyen to.',
        check: (String text) => _isPrime(text.length),
      ),
      PasswordRule(
        description: '10) Khong co 3 ky tu giong nhau lien tiep.',
        check: (String text) => !_hasTripleRepeat(text),
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _password = value;
    });
  }

  void _createPassword() {
    final int firstFailedRuleIndex = _firstFailedRuleIndex(_password);

    setState(() {
      if (firstFailedRuleIndex == -1) {
        _completed = true;
        _activeRuleIndex = _rules.length - 1;
        return;
      }

      _completed = false;
      _activeRuleIndex = firstFailedRuleIndex;
    });
  }

  void _reset() {
    setState(() {
      _controller.clear();
      _password = '';
      _activeRuleIndex = 0;
      _completed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PasswordRule currentRule = _rules[_activeRuleIndex];
    final bool currentRulePassed = currentRule.check(_password);

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Password Game'),
        actions: <Widget>[
          IconButton(
            onPressed: _reset,
            tooltip: 'Reset',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nhap password, sau do bam "Tao mat khau" de kiem tra rule hien tai.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _controller,
                    onChanged: _onPasswordChanged,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Vi du: AredV!799',
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      FilledButton.icon(
                        onPressed: _createPassword,
                        icon: const Icon(Icons.auto_fix_high),
                        label: const Text('Tao mat khau'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _reset,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_completed)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.green.withValues(alpha: 0.14),
                      ),
                      child: const Text(
                        'Chuc mung! Ban da hoan thanh tat ca rule.',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF166534),
                        ),
                      ),
                    ),
                  if (!_completed) ...<Widget>[
                    _RuleProgressHeader(
                      activeRuleIndex: _activeRuleIndex,
                      totalCount: _rules.length,
                      password: _password,
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          _RuleTile(
                            ruleNumber: _activeRuleIndex + 1,
                            description: currentRule.description,
                            isSatisfied: currentRulePassed,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static int _sumDigits(String text) {
    return text
        .split('')
        .where((String ch) => RegExp(r'\d').hasMatch(ch))
        .fold<int>(0, (int sum, String digit) => sum + int.parse(digit));
  }

  static bool _containsCurrentMonth(String text) {
    final int month = DateTime.now().month;
    final String withLeadingZero = month.toString().padLeft(2, '0');
    final String withoutLeadingZero = month.toString();
    return text.contains(withLeadingZero) || text.contains(withoutLeadingZero);
  }

  static bool _isPrime(int n) {
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

  static bool _hasTripleRepeat(String text) {
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

  int _firstFailedRuleIndex(String password) {
    for (int i = 0; i < _rules.length; i++) {
      if (!_rules[i].check(password)) {
        return i;
      }
    }

    return -1;
  }
}

class _RuleProgressHeader extends StatelessWidget {
  const _RuleProgressHeader({
    required this.activeRuleIndex,
    required this.totalCount,
    required this.password,
  });

  final int activeRuleIndex;
  final int totalCount;
  final String password;

  @override
  Widget build(BuildContext context) {
    final double progress = totalCount == 0
        ? 0
        : (activeRuleIndex + 1) / totalCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Rule hien tai: ${activeRuleIndex + 1}/$totalCount',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: progress),
        const SizedBox(height: 8),
        Text(
          'Trang thai: ${_ruleStatusText(password, activeRuleIndex)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  static String _ruleStatusText(String password, int ruleIndex) {
    return password.isEmpty
        ? 'chua co du lieu'
        : 'dang kiem tra rule ${ruleIndex + 1}';
  }
}

class _RuleTile extends StatelessWidget {
  const _RuleTile({
    required this.ruleNumber,
    required this.description,
    required this.isSatisfied,
  });

  final int ruleNumber;
  final String description;
  final bool isSatisfied;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isSatisfied
        ? Colors.green.withValues(alpha: 0.12)
        : Colors.red.withValues(alpha: 0.10);
    final Color borderColor = isSatisfied
        ? const Color(0xFF16A34A)
        : const Color(0xFFDC2626);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            isSatisfied ? Icons.check_circle : Icons.cancel,
            color: borderColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$ruleNumber) $description',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
