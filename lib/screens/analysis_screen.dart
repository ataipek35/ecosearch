import 'dart:async';

import 'package:flutter/material.dart';

import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../data/sample_data.dart';
import '../models/product.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/eco_card.dart';
import '../widgets/info_banner.dart';
import '../widgets/product_widgets.dart';

enum _StepState { complete, inProgress, upNext }


class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  static const List<String> _titles = [
    'Identify product',
    'Estimate carbon & plastic',
    'Explain & compare',
  ];

  static const List<List<List<String>>> _stageText = [
    [
      ['Identifying the product.', 'In progress'],
      ['Estimates use product fields and category averages.', 'Up next'],
      ['AI uses only retrieved product data.', 'Up next'],
    ],
    [
      ['Liquid soap · 500 mL example', 'Complete'],
      ['Estimating approximate carbon and plastic ranges.', 'In progress'],
      ['AI uses only retrieved product data.', 'Up next'],
    ],
    [
      ['Liquid soap · 500 mL example', 'Complete'],
      ['Estimated the carbon and plastic ranges.', 'Complete'],
      ['AI uses only retrieved product data.', 'In progress'],
    ],
  ];

  static const List<double> _progress = [0.30, 0.70, 0.90];

  Timer? _timer;
  int _stage = 0;
  Product _product = SampleData.originalSoap;
  bool _readArguments = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1600), (timer) {
      if (!mounted) return;
      if (_stage < 2) {
        setState(() => _stage++);
      } else {
        timer.cancel();
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.scorecard,
          arguments: _product,
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_readArguments) {
      _readArguments = true;
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Product) _product = args;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _StepState _stateOf(int step) {
    if (step < _stage) return _StepState.complete;
    if (step == _stage) return _StepState.inProgress;
    return _StepState.upNext;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Product analysis')),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_stage >= 1) _IdentifiedHeader(product: _product),
                        SizedBox(
                          height: _stage >= 1 ? AppSpacing.md : AppSpacing.xl,
                        ),
                        _ProgressRing(value: _progress[_stage]),
                        const SizedBox(height: AppSpacing.sm + 4),
                        Center(
                          child: Text(
                            'Building your scorecard',
                            style: AppTextStyles.caption.copyWith(
                              color: scheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        for (var i = 0; i < _titles.length; i++)
                          _StepRow(
                            title: _titles[i],
                            description: _stageText[_stage][i][0],
                            statusText: _stageText[_stage][i][1],
                            state: _stateOf(i),
                          ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding,
                    AppSpacing.sm,
                    AppSpacing.screenPadding,
                    AppSpacing.md,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const InfoBanner(
                        muted: true,
                        icon: Icons.info_outline,
                        text: 'Example analysis state. Estimates use product '
                            'fields and category averages.',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      TonalButton(
                        label: 'Cancel analysis',
                        onPressed: () => confirmCancelAnalysis(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IdentifiedHeader extends StatelessWidget {
  final Product product;

  const _IdentifiedHeader({required this.product});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return EcoCard(
      radius: 20,
      child: Row(
        children: [
          ProductImage(asset: product.imageAsset, size: 68, height: 85),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: scheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, size: 14, color: scheme.primary),
                      const SizedBox(width: AppSpacing.xs),
                      Flexible(
                        child: Text(
                          'Product identified',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 11,
                            color: scheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                ),
                Text(
                  '${product.packaging} · 500 mL · Example',
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
    );
  }
}

class _ProgressRing extends StatelessWidget {
  final double value;

  const _ProgressRing({required this.value});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: SizedBox(
        width: 112,
        height: 112,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 112,
              height: 112,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: value),
                duration: const Duration(milliseconds: 500),
                builder: (context, animated, _) => CircularProgressIndicator(
                  value: animated,
                  strokeWidth: 7,
                  backgroundColor: scheme.secondaryContainer,
                ),
              ),
            ),
            Icon(Icons.manage_search, size: 34, color: scheme.primary),
          ],
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String title;
  final String description;
  final String statusText;
  final _StepState state;

  const _StepRow({
    required this.title,
    required this.description,
    required this.statusText,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isInProgress = state == _StepState.inProgress;
    final icon = switch (state) {
      _StepState.complete => Icons.check,
      _StepState.inProgress => Icons.autorenew,
      _StepState.upNext => Icons.schedule,
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 19,
            backgroundColor:
                isInProgress ? scheme.primary : scheme.secondaryContainer,
            child: Icon(
              icon,
              size: 20,
              color: isInProgress ? scheme.onPrimary : scheme.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.cardTitle),
                Text(
                  description,
                  style: AppTextStyles.caption.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  statusText,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isInProgress
                        ? scheme.primary
                        : scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
