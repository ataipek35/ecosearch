import 'package:flutter/material.dart';

import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../models/product.dart';
import 'custom_buttons.dart';
import 'eco_card.dart';
import 'icon_badge.dart';
import 'score_chip.dart';

/// Search result card: icon, name, subtitle and "Select to analyze".
class ProductResultCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAnalyze;

  const ProductResultCard({
    super.key,
    required this.product,
    required this.onAnalyze,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return EcoCard(
      borderColor: scheme.secondaryContainer,
      radius: 18,
      child: Column(
        children: [
          Row(
            children: [
              IconBadge(icon: product.icon),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.cardTitle,
                    ),
                    Text(
                      product.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            label: 'Select to analyze',
            icon: Icons.arrow_forward,
            iconAfterLabel: true,
            onPressed: onAnalyze,
          ),
        ],
      ),
    );
  }
}

/// Alternative card used on the Scorecard screen (Figma "Analysis-1/2").
/// Tapping the card selects it; the round arrow button opens the details.
class AlternativeCard extends StatelessWidget {
  final Product product;
  final bool highlighted;
  final VoidCallback onSelect;
  final VoidCallback onOpen;

  const AlternativeCard({
    super.key,
    required this.product,
    required this.onSelect,
    required this.onOpen,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return EcoCard(
      outlined: true,
      highlighted: highlighted,
      onTap: onSelect,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(asset: product.imageAsset, size: 64, height: 84),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        product.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              if (product.score != null) ScoreChip(score: product.score!),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Approx. ${product.carbon} CO₂e · ${product.plastic} plastic',
                  style: AppTextStyles.caption.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Material(
                color: scheme.secondaryContainer,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onOpen,
                  child: SizedBox(
                    width: 52,
                    height: 52,
                    child: Icon(
                      Icons.chevron_right,
                      size: 30,
                      color: scheme.primary,
                      semanticLabel: 'Open ${product.name}',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(Icons.trending_down, size: 18, color: scheme.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Potential: ${product.potential}',
                      style: AppTextStyles.caption.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Per 500 mL · Example midpoint savings',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Local asset image with a safe fallback.
class ProductImage extends StatelessWidget {
  final String? asset;
  final double size;
  final double? height;

  const ProductImage({
    super.key,
    required this.asset,
    this.size = 64,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: size,
        height: height ?? size,
        child: asset == null
            ? ColoredBox(
                color: scheme.secondaryContainer,
                child: Icon(Icons.image_outlined, color: scheme.primary),
              )
            : Image.asset(asset!, fit: BoxFit.cover),
      ),
    );
  }
}
