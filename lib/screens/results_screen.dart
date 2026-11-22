import 'package:flutter/material.dart';

import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../data/sample_data.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/product_widgets.dart';
import '../widgets/screen_body.dart';
import '../widgets/tab_header.dart';


class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final _searchController = TextEditingController();
  bool _readArguments = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_readArguments) {
      _readArguments = true;
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String) _searchController.text = args;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
    final scheme = Theme.of(context).colorScheme;
    final products = SampleData.searchResults;

    return Scaffold(
      body: ScreenBody(
        children: [
          const TabHeader(icon: Icons.eco_outlined, title: 'EcoSearch'),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search a product or brand',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                borderSide: BorderSide(color: scheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                borderSide: BorderSide(color: scheme.primary, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              const Expanded(
                child: Text('Matching products', style: AppTextStyles.title),
              ),
              Text(
                '${products.length} examples',
                style: AppTextStyles.caption.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm + 4),
          for (final product in products) ...[
            ProductResultCard(
              product: product,
              onAnalyze: () => Navigator.pushNamed(
                context,
                AppRoutes.analysis,
                arguments: product,
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
