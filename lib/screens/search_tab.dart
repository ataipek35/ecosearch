import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../data/sample_data.dart';
import '../models/history_entry.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/eco_card.dart';
import '../widgets/icon_badge.dart';
import '../widgets/screen_body.dart';
import '../widgets/tab_header.dart';

class SearchTab extends StatefulWidget {
  final VoidCallback onViewHistory;

  const SearchTab({super.key, required this.onViewHistory});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Type a product or brand to search.')),
      );
      return;
    }
    Navigator.pushNamed(context, AppRoutes.results, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final recent = SampleData.history.take(3).toList();
    return ScreenBody(
      children: [
        const TabHeader(icon: Icons.eco_outlined, title: 'EcoSearch'),
        const SizedBox(height: AppSpacing.xl * 2),
        TextField(
          controller: _searchController,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _search(),
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
        const SizedBox(height: AppSpacing.sm + 4),
        TonalButton(
          label: 'Scan barcode',
          icon: Icons.qr_code_scanner,
          onPressed: () => Navigator.pushNamed(context, AppRoutes.scan),
        ),
        const SizedBox(height: AppSpacing.xl + AppSpacing.lg),
        Row(
          children: [
            const Expanded(
              child: Text('Recent searches', style: AppTextStyles.title),
            ),
            LinkText(label: 'View history', onPressed: widget.onViewHistory),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        EcoCard(
          outlined: true,
          borderColor: scheme.outlineVariant,
          radius: 18,
          child: Column(
            children: [
              _RecentRow(entry: recent.first),
              const SizedBox(height: AppSpacing.sm + 4),
              TonalButton(
                label: 'Continue comparison',
                icon: Icons.arrow_forward,
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.analysis,
                  arguments: SampleData.originalSoap,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _RecentRow(entry: recent[1]),
        const Divider(height: AppSpacing.lg),
        _RecentRow(entry: recent[2]),
      ],
    );
  }
}

class _RecentRow extends StatelessWidget {
  final HistoryEntry entry;

  const _RecentRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        IconBadge(icon: entry.icon),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.cardTitle,
              ),
              Text(
                entry.recentDetail,
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
    );
  }
}
