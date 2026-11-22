import 'package:flutter/material.dart';

import '../core/app_spacing.dart';

/// Rounded Card used for list items and grouped content.
///
/// - default:   "surface" fill, no border
/// - outlined:  "field" fill (white in light mode) with an outline border
/// - [color] / [borderColor] override the fill and the border when a screen
///   needs a different combination (e.g. tonal border on search results).
/// - highlighted: primary-colored border (selected card)
class EcoCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool outlined;
  final bool highlighted;
  final Color? color;
  final Color? borderColor;
  final double radius;
  final EdgeInsetsGeometry padding;

  const EcoCard({
    super.key,
    required this.child,
    this.onTap,
    this.outlined = false,
    this.highlighted = false,
    this.color,
    this.borderColor,
    this.radius = AppSpacing.cardRadius,
    this.padding = const EdgeInsets.all(AppSpacing.md),
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final shapeRadius = BorderRadius.circular(radius);
    final Color side = highlighted
        ? scheme.primary
        : (borderColor ?? (outlined ? scheme.outline : Colors.transparent));
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: color ??
          (outlined
              ? scheme.surfaceContainerLow
              : scheme.surfaceContainerHighest),
      shape: RoundedRectangleBorder(
        borderRadius: shapeRadius,
        side: BorderSide(color: side, width: highlighted ? 1.5 : 1),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
