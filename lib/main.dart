import 'package:flutter/material.dart';
import 'core/app_routes.dart';
import 'core/app_theme.dart';
import 'data/app_state.dart';
import 'screens/alternative_screen.dart';
import 'screens/analysis_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_shell.dart';
import 'screens/login_screen.dart';
import 'screens/new_password_screen.dart';
import 'screens/not_found_screen.dart';
import 'screens/password_updated_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/results_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/scorecard_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/verify_reset_code_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const EcoSearchApp());
}

class EcoSearchApp extends StatelessWidget {
  const EcoSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppState.themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'EcoSearch',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          initialRoute: AppRoutes.welcome,
          routes: {
            AppRoutes.welcome: (context) => const WelcomeScreen(),
            AppRoutes.login: (context) => const LoginScreen(),
            AppRoutes.signup: (context) => const SignUpScreen(),
            AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
            AppRoutes.verifyResetCode: (context) =>
                const VerifyResetCodeScreen(),
            AppRoutes.newPassword: (context) => const NewPasswordScreen(),
            AppRoutes.passwordUpdated: (context) =>
                const PasswordUpdatedScreen(),
            AppRoutes.home: (context) => const HomeShell(),
            AppRoutes.results: (context) => const ResultsScreen(),
            AppRoutes.scan: (context) => const ScanScreen(),
            AppRoutes.notFound: (context) => const NotFoundScreen(),
            AppRoutes.analysis: (context) => const AnalysisScreen(),
            AppRoutes.scorecard: (context) => const ScorecardScreen(),
            AppRoutes.alternative: (context) => const AlternativeScreen(),
            AppRoutes.profile: (context) => const ProfileScreen(),
            AppRoutes.settings: (context) => const SettingsScreen(),
          },
        );
      },
    );
  }
}
