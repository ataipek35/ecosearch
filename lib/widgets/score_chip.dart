import 'package:flutter/material.dart';

import '../core/app_text_styles.dart';

/// Small pill showing "78/100".
class ScoreChip extends StatelessWidget {
  final int score;

  const ScoreChip({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        '$score/100',
        style: AppTextStyles.caption.copyWith(
          color: scheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
