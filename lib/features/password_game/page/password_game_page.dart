import 'package:flutter/material.dart';
import 'package:game_flutter/features/password_game/components/active_rule_card.dart';
import 'package:game_flutter/features/password_game/components/completion_card.dart';
import 'package:game_flutter/features/password_game/components/password_input_card.dart';
import 'package:game_flutter/features/password_game/components/rule_progress_card.dart';
import 'package:game_flutter/features/password_game/data/password_rules.dart';
import 'package:game_flutter/features/password_game/models/password_rule.dart';

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

  @override
  void initState() {
    super.initState();
    _rules = PasswordRules.build();
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

  void _validateAndAdvance() {
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
          TextButton.icon(
            onPressed: _reset,
            icon: const Icon(Icons.replay),
            label: const Text('Reset'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFF4FAF9),
              Color(0xFFEAF4F9),
              Color(0xFFF8F4EC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    PasswordInputCard(
                      controller: _controller,
                      onChanged: _onPasswordChanged,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: _validateAndAdvance,
                            icon: const Icon(Icons.verified),
                            label: const Text('Create password'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (_completed)
                      const CompletionCard()
                    else ...<Widget>[
                      RuleProgressCard(
                        activeRule: _activeRuleIndex + 1,
                        totalRules: _rules.length,
                      ),
                      const SizedBox(height: 14),
                      ActiveRuleCard(
                        rule: currentRule,
                        isPassed: currentRulePassed,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
