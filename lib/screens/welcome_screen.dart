import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/info_banner.dart';
import '../widgets/screen_body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: ScreenBody(
        children: [
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Icon(Icons.eco_outlined, color: scheme.primary),
              const SizedBox(width: AppSpacing.sm + 4),
              const Text('EcoSearch', style: AppTextStyles.title),
            ],
          ),
          const SizedBox(height: AppSpacing.xl * 2),
          const InfoBanner(
            icon: Icons.search,
            title: 'Discover. Compare. Choose.',
            text: 'No account is needed to search products, save favorites '
                'or view your local activity.',
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Welcome to EcoSearch', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.md),
          OutlinedPillButton(
            label: 'Sign in with Google',
            leading: const Text(
              'G',
              style: TextStyle(
                fontFamily: AppTextStyles.fontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.googleBlue,
                height: 1,
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Google sign-in will be added in a later step.'),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.sm + 4),
          PrimaryButton(
            label: 'Login with email',
            icon: Icons.mail_outline,
            onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  'or',
                  style: AppTextStyles.caption.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          TonalButton(
            label: 'Continue without signing in',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.home),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'New to EcoSearch?',
                style: AppTextStyles.body.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              LinkText(
                label: 'Create account',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
