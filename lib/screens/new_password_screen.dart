import 'package:flutter/material.dart';

import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../utils/validation_utils.dart';
import '../widgets/app_text_field.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/screen_body.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _update() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.passwordUpdated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('New password')),
      body: ScreenBody(
        children: [
          const Text('Create a new password.', style: AppTextStyles.headline),
          const SizedBox(height: AppSpacing.sm),
          Text(
            "Choose a strong password that you haven't used before.",
            style: AppTextStyles.body.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  label: 'New password',
                  hint: 'Enter new password',
                  controller: _passwordController,
                  isPassword: true,
                  validator: ValidationUtils.validateNewPassword,
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  label: 'Confirm password',
                  hint: 'Re-enter new password',
                  controller: _confirmController,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) => ValidationUtils.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Use at least 8 characters, including a letter and a number.',
            style: AppTextStyles.body.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: 'Update password', onPressed: _update),
        ],
      ),
    );
  }
}
