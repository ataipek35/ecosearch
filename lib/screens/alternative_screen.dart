import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../data/app_state.dart';
import '../data/sample_data.dart';
import '../models/product.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/eco_card.dart';
import '../widgets/info_banner.dart';
import '../widgets/screen_body.dart';

class AlternativeScreen extends StatefulWidget {
  const AlternativeScreen({super.key});

  @override
  State<AlternativeScreen> createState() => _AlternativeScreenState();
}

class _AlternativeScreenState extends State<AlternativeScreen> {

  Product _product = SampleData.kindred;
  bool _readArguments = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_readArguments) {
      _readArguments = true;
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Product) _product = args;
    }
  }

  void _toggleFavorite() {
    final wasFavorite = AppState.isFavorite(_product);
    if (wasFavorite) {
      AppState.removeFavorite(_product);
    } else {
      AppState.addFavorite(_product);
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            wasFavorite ? 'Removed from favorites' : 'Saved to favorites',
          ),
        ),
      );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isFavorite = AppState.isFavorite(_product);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: ScreenBody(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.recycling, size: 16, color: scheme.primary),
                          const SizedBox(width: AppSpacing.xs),
                          Flexible(
                            child: Text(
                              _product.packaging,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.caption.copyWith(
                                color: scheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Text(
                            '${_product.score ?? '-'}',
                            style: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              fontSize: 44,
                              fontWeight: FontWeight.w600,
                              color: scheme.primary,
                              height: 1.1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              '/100',
                              style: AppTextStyles.body.copyWith(
                                color: scheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: _product.imageAsset == null
                            ? ColoredBox(
                            color: scheme.secondaryContainer,
                            child: Icon(Icons.image_outlined, color: scheme.primary),
                            ) : Image.asset(_product.imageAsset!, fit: BoxFit.cover),
                    ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(_product.name, style: AppTextStyles.headline.copyWith(fontSize: 22)),
          Text(
            _product.subtitle,
            style: AppTextStyles.body.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Impact values', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Column(
              children: [
                _ValueRow(
                  label: 'Approx. / 500 mL',
                  value: _product.name.split(' ').first,
                ),
                _ValueRow(
                  label: 'CO₂e (kg)',
                  value: _product.carbon.replaceAll(' kg', ''),
                ),
                _ValueRow(
                  label: 'Plastic',
                  value: _product.plastic,
                  showDivider: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Data & methodology', style: AppTextStyles.title),
          const SizedBox(height: AppSpacing.sm),
          EcoCard(
            outlined: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.description_outlined, color: scheme.primary),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Open Products Facts · Planned source',
                        style: AppTextStyles.cardTitle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(Icons.open_in_new, size: 20, color: scheme.primary),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkWarningBackground
                        : AppColors.lightWarningBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'No certification data',
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 11,
                      color: isDark
                          ? AppColors.darkWarningText
                          : AppColors.lightWarningText,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Packaging fields + category averages. AI explanations must '
                  'stay within retrieved data.',
                  style: AppTextStyles.caption.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const InfoBanner(
            muted: true,
            icon: Icons.info_outline,
            text: 'Example products and approximate ranges. Percentages '
                'compare midpoints. EU Ecolabel matching is planned for later.',
          ),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            label: isFavorite ? 'Saved to favorites' : 'Save to favorites',
            icon: isFavorite ? Icons.favorite : Icons.favorite_border,
            onPressed: _toggleFavorite,
          ),
        ],
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const _ValueRow({
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(bottom: BorderSide(color: scheme.outline))
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.caption.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
