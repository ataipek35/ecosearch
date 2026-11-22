import 'package:flutter/material.dart';

import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/screen_body.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Product not found')),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: 0,
        onSelected: (tab) => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
          arguments: tab,
        ),
      ),
      body: ScreenBody(
        children: [
          const SizedBox(height: AppSpacing.xl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'No data',
                    style: AppTextStyles.caption.copyWith(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm + 4),
                Text(
                  'Unrecognized barcode',
                  style: AppTextStyles.title.copyWith(color: scheme.primary),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'No verified product record, impact score, or certified '
                  'alternative is available for this scan.',
                  style: AppTextStyles.body.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            label: 'Search by name',
            icon: Icons.search,
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.results,
              (route) => false,
            ),
          ),
        ],
      ),
    );
  }
}
