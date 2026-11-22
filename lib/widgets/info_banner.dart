import 'package:flutter/material.dart';

import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';

/// Information box with an optional leading icon.
/// Tonal green by default; pass [muted] for the quieter surface variant
/// (scan, analysis, settings and alternative screens).
class InfoBanner extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String? title;
  final bool muted;

  const InfoBanner({
    super.key,
    required this.text,
    this.icon,
    this.title,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: muted ? scheme.surfaceContainerHighest : scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: scheme.primary),
            const SizedBox(width: AppSpacing.sm + 4),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: AppTextStyles.cardTitle.copyWith(
                      color: icon == null ? scheme.onSurface : scheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                ],
                Text(
                  text,
                  style: AppTextStyles.caption.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
