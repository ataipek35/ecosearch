import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../utils/validation_utils.dart';
import '../widgets/app_text_field.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/screen_body.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  const VerifyResetCodeScreen({super.key});

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verify() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.newPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: ScreenBody(
        children: [
          const Text('Check your email.', style: AppTextStyles.headline),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'If an account exists for the email you entered, a 6-digit reset '
            'code is on its way.',
            style: AppTextStyles.body.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          Form(
            key: _formKey,
            child: AppTextField(
              label: 'Verification code',
              hint: 'Enter 6-digit code',
              controller: _codeController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              validator: ValidationUtils.validateResetCode,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            "The code expires in 10 minutes. Can't find the email? Check your "
            'spam folder.',
            style: AppTextStyles.body.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: 'Verify code', onPressed: _verify),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: LinkText(
              label: 'Use a different email',
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
