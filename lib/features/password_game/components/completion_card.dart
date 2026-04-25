import 'package:flutter/material.dart';

class CompletionCard extends StatelessWidget {
  const CompletionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F8EE),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF159957), width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.emoji_events, color: Color(0xFF159957)),
              const SizedBox(width: 8),
              Text(
                'All rules completed',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0B6B3B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Great work. Your password satisfies all 15 rules.'),
        ],
      ),
    );
  }
}
