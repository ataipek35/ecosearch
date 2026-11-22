import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';

class TabHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const TabHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, color: scheme.primary),
        const SizedBox(width: AppSpacing.sm + 4),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.title.copyWith(fontSize: 22),
          ),
        ),
        IconButton.filledTonal(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
          icon: const Icon(Icons.person_outline),
          iconSize: 38,
          tooltip: 'Profile',
          style: IconButton.styleFrom(
            fixedSize: const Size(72, 72),
            backgroundColor: scheme.secondaryContainer,
            foregroundColor: scheme.primary,
          ),
        ),
      ],
    );
  }
}
