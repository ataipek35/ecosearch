import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../data/sample_data.dart';
import '../models/product.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/info_banner.dart';
import '../widgets/product_widgets.dart';
import '../widgets/screen_body.dart';


class ScorecardScreen extends StatefulWidget {
  const ScorecardScreen({super.key});

  @override
  State<ScorecardScreen> createState() => _ScorecardScreenState();
}

class _ScorecardScreenState extends State<ScorecardScreen> {
  static const String _explanationNote =
      ' AI should explain only retrieved product fields and '
      'category-average estimates.';

  int _selected = 0;

  void _openTab(int tab) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
      arguments: tab,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final product = args is Product && args.score != null
        ? args
        : SampleData.originalSoap;
    final alternatives = SampleData.alternatives;

    return Scaffold(
      appBar: AppBar(title: const Text('Scorecard')),
      body: ScreenBody(
        children: [
          _ScoreHeader(product: product),
          const SizedBox(height: AppSpacing.md),
          InfoBanner(
            title: 'AI explanation',
            text: alternatives[_selected].explanation + _explanationNote,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '${alternatives.length} lighter-impact options found',
            style: AppTextStyles.title,
          ),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < alternatives.length; i++) ...[
            AlternativeCard(
              product: alternatives[i],
              highlighted: i == _selected,
              onSelect: () => setState(() => _selected = i),
              onOpen: () => Navigator.pushNamed(
                context,
                AppRoutes.alternative,
                arguments: alternatives[i],
              ),
            ),
            const SizedBox(height: AppSpacing.sm + 4),
          ],
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: 0,
        onSelected: _openTab,
      ),
    );
  }
}

class _ScoreHeader extends StatelessWidget {
  final Product product;

  const _ScoreHeader({required this.product});

  @override
  Widget build(BuildContext context) {
    const textColor = AppColors.scoreCardText;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.scoreCardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ProductImage(asset: product.imageAsset, size: 56, height: 72),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.cardTitle.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${product.packaging} · 500 mL',
                      style: AppTextStyles.caption.copyWith(color: textColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${product.score}',
                style: const TextStyle(
                  fontFamily: AppTextStyles.fontFamily,
                  fontSize: 56,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              Text(
                '/100',
                style: AppTextStyles.body.copyWith(color: textColor),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Text(
                  'Room to improve',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cardTitle.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  icon: Icons.cloud_outlined,
                  value: product.carbon,
                  label: 'CO₂e · Approximate',
                ),
              ),
              Expanded(
                child: _Stat(
                  icon: Icons.inventory_2_outlined,
                  value: product.plastic,
                  label: 'Plastic · Approximate',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _Stat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.scoreCardText),
        const SizedBox(height: AppSpacing.xs),
        Text(value, style: AppTextStyles.title.copyWith(color: Colors.white)),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: AppColors.scoreCardText),
        ),
      ],
    );
  }
}
