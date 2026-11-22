import 'package:flutter/material.dart';

import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';

/// Filled dark-green button (uses the shared elevatedButtonTheme).
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool iconAfterLabel;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconAfterLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final text = Flexible(
      child: Text(label, overflow: TextOverflow.ellipsis, maxLines: 1),
    );
    final iconWidget = icon == null ? null : Icon(icon, size: 18);
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconWidget != null && !iconAfterLabel) ...[
            iconWidget,
            const SizedBox(width: AppSpacing.sm),
          ],
          text,
          if (iconWidget != null && iconAfterLabel) ...[
            const SizedBox(width: AppSpacing.sm),
            iconWidget,
          ],
        ],
      ),
    );
  }
}

/// Light-green tonal button ("Continue without signing in", "Scan barcode").
class TonalButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const TonalButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.secondaryContainer,
        foregroundColor: scheme.primary,
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Text(label, overflow: TextOverflow.ellipsis, maxLines: 1),
          ),
        ],
      ),
    );
  }
}

/// White outlined button ("Sign in with Google", "Sign out").
class OutlinedPillButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  /// Custom leading widget (e.g. the Google "G"); wins over [icon].
  final Widget? leading;

  const OutlinedPillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        foregroundColor: scheme.onSurface,
        side: BorderSide(color: scheme.outline),
        textStyle: AppTextStyles.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppSpacing.sm),
          ] else if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Text(label, overflow: TextOverflow.ellipsis, maxLines: 1),
          ),
        ],
      ),
    );
  }
}

/// Small text-only link button ("Forgot password?", "View history").
class LinkText extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const LinkText({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        minimumSize: const Size(0, 36),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: AppTextStyles.button,
      ),
      child: Text(label),
    );
  }
}
