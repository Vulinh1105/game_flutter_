import 'package:flutter/material.dart';

class RuleProgressCard extends StatelessWidget {
  const RuleProgressCard({
    super.key,
    required this.activeRule,
    required this.totalRules,
  });

  final int activeRule;
  final int totalRules;

  @override
  Widget build(BuildContext context) {
    final double progress = totalRules == 0 ? 0 : activeRule / totalRules;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFFEEF7F5), Color(0xFFE8F3FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFC1DCD8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Rule $activeRule of $totalRules',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0B5568),
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: progress,
              backgroundColor: const Color(0xFFD8E9E6),
            ),
          ),
        ],
      ),
    );
  }
}
