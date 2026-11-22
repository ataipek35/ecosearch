import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/eco_card.dart';
import '../widgets/icon_badge.dart';
import '../widgets/screen_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _openTab(BuildContext context, int tab) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
      arguments: tab,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ScreenBody(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: scheme.surfaceContainerHighest,
                  child: Text(
                    'DB',
                    style: AppTextStyles.title.copyWith(color: scheme.primary),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Dan Brown', style: AppTextStyles.title),
                      Text(
                        'dan.brown@example.com',
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        'Signed in',
                        style: AppTextStyles.caption.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Your EcoSearch', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.sm + 4),
          EcoCard(
            outlined: true,
            borderColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            child: Column(
              children: [
                _MenuRow(
                  icon: Icons.favorite_border,
                  label: 'Favorites',
                  onTap: () => _openTab(context, 1),
                ),
                _MenuRow(
                  icon: Icons.history,
                  label: 'Search history',
                  onTap: () => _openTab(context, 2),
                ),
                _MenuRow(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  showDivider: false,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedPillButton(
            label: 'Sign out',
            icon: Icons.logout,
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.welcome,
              (route) => false,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Browsing as a guest?',
                        style: AppTextStyles.cardTitle,
                      ),
                      Text(
                        'Your local tools are always available.',
                        style: AppTextStyles.caption.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                LinkText(
                  label: 'Sign in',
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;

  const _MenuRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: IconBadge(icon: icon),
          title: Text(label, style: AppTextStyles.cardTitle),
          trailing: Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
          onTap: onTap,
        ),
        if (showDivider) Divider(height: 1, color: scheme.outline),
      ],
    );
  }
}
