import 'package:flutter/material.dart';

import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/screen_body.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  void _backToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => route.settings.name == AppRoutes.welcome,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _backToLogin(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Password updated'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to login',
            onPressed: () => _backToLogin(context),
          ),
        ),
        body: ScreenBody(
          children: [
            const Text("You're all set.", style: AppTextStyles.headline),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your password has been updated. You can now sign in with your '
              'new password.',
              style: AppTextStyles.body.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: 'Back to login',
              onPressed: () => _backToLogin(context),
            ),
          ],
        ),
      ),
    );
  }
}
