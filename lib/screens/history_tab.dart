import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../data/sample_data.dart';
import '../models/history_entry.dart';
import '../widgets/eco_card.dart';
import '../widgets/icon_badge.dart';
import '../widgets/screen_body.dart';
import '../widgets/tab_header.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  static const List<String> _filters = ['All', 'Soap', 'T-shirts', 'Food'];
  String _selected = 'All';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final entries = SampleData.history
        .where((e) => _selected == 'All' || e.category == _selected)
        .toList();

    final children = <Widget>[];
    String? lastDay;
    String? lastGroup;
    for (final entry in entries) {
      if (entry.dayLabel != lastDay) {
        lastDay = entry.dayLabel;
        lastGroup = null;
        children.add(
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.xs,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    entry.dayLabel,
                    style: AppTextStyles.title.copyWith(fontSize: 16),
                  ),
                ),
                Text(
                  entry.date,
                  style: AppTextStyles.caption.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      }
      if (entry.group != lastGroup) {
        lastGroup = entry.group;
        children.add(
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.sm,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              entry.group,
              style: AppTextStyles.caption.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
      children.add(_HistoryCard(entry: entry));
      children.add(const SizedBox(height: AppSpacing.sm));
    }

    return ScreenBody(
      children: [
        const TabHeader(icon: Icons.history, title: 'History'),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final filter in _filters)
              ChoiceChip(
                label: Text(_selected == filter ? '✓ $filter' : filter),
                selected: _selected == filter,
                onSelected: (_) => setState(() => _selected = filter),
              ),
          ],
        ),
        if (entries.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Center(
              child: Text(
                'No searches in this category.',
                style: AppTextStyles.body.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ...children,
      ],
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final HistoryEntry entry;

  const _HistoryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return EcoCard(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.analysis,
        arguments: SampleData.originalSoap,
      ),
      child: Row(
        children: [
          IconBadge(icon: entry.icon),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cardTitle,
                ),
                Text(
                  entry.detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
