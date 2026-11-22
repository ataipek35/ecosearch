import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  final IconData icon;
  final double size;

  const IconBadge({super.key, required this.icon, this.size = 44});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: scheme.primary, size: size * 0.55),
    );
  }
}
