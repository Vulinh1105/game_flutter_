import 'package:flutter/material.dart';
import 'package:game_flutter/features/password_game/models/password_rule.dart';

class ActiveRuleCard extends StatelessWidget {
  const ActiveRuleCard({super.key, required this.rule, required this.isPassed});

  final PasswordRule rule;
  final bool isPassed;

  @override
  Widget build(BuildContext context) {
    final Color tone = isPassed
        ? const Color(0xFF0F9D58)
        : const Color(0xFFD94343);
    final Color background = isPassed
        ? const Color(0xFFE9F8EF)
        : const Color(0xFFFDEEEE);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tone, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(isPassed ? Icons.task_alt : Icons.rule, color: tone),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Rule ${rule.id}: ${rule.title}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: tone,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(rule.detail, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          Text(
            isPassed ? 'Status: currently valid' : 'Status: not valid yet',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: tone,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
