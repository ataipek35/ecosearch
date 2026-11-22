import 'package:flutter/material.dart';

import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../utils/validation_utils.dart';
import '../widgets/app_text_field.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/screen_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: ScreenBody(
        children: [
          const Text('Welcome back.', style: AppTextStyles.headline),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Sign in with your email and password to continue to EcoSearch.',
            style: AppTextStyles.body.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  label: 'Email address',
                  hint: 'you@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationUtils.validateEmail,
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: LinkText(
              label: 'Forgot password?',
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.forgotPassword),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(label: 'Sign in', onPressed: _submit),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: AppTextStyles.body.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              LinkText(
                label: 'Create account',
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.signup),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          TonalButton(
            label: 'Continue without signing in',
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            ),
          ),
        ],
      ),
    );
  }
}
