import 'package:flutter/material.dart';

import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../utils/validation_utils.dart';
import '../widgets/app_text_field.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/screen_body.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendCode() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        AppRoutes.verifyResetCode,
        arguments: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: ScreenBody(
        children: [
          const Text('Forgot your password?', style: AppTextStyles.headline),
          const SizedBox(height: AppSpacing.sm),
          Text(
            "Enter your email address and we'll help you create a new password.",
            style: AppTextStyles.body.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          Form(
            key: _formKey,
            child: AppTextField(
              label: 'Email address',
              hint: 'you@example.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: ValidationUtils.validateEmail,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            "If an account exists for this email, we'll send a 6-digit reset code.",
            style: AppTextStyles.body.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: 'Send reset code', onPressed: _sendCode),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: LinkText(
              label: 'Back to login',
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
