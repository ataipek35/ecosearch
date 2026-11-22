import 'package:flutter/material.dart';
import '../core/app_routes.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../data/app_state.dart';
import '../models/product.dart';
import '../widgets/eco_card.dart';
import '../widgets/product_widgets.dart';
import '../widgets/score_chip.dart';
import '../widgets/tab_header.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  void _remove(BuildContext context, Product product) {
    AppState.removeFavorite(product);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${product.name} removed'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => AppState.addFavorite(product),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: ValueListenableBuilder<List<Product>>(
            valueListenable: AppState.favorites,
            builder: (context, favorites, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.screenPadding,
                      AppSpacing.sm,
                      AppSpacing.screenPadding,
                      AppSpacing.lg,
                    ),
                    child: TabHeader(
                      icon: Icons.favorite_border,
                      title: 'Favorites',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Saved alternatives',
                            style: AppTextStyles.title,
                          ),
                        ),
                        Text(
                          '${favorites.length} saved',
                          style: AppTextStyles.caption.copyWith(
                            color: scheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: favorites.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.lg),
                              child: Text(
                                'No saved alternatives yet.\n'
                                'Save one from a scorecard.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.screenPadding,
                              0,
                              AppSpacing.screenPadding,
                              AppSpacing.md,
                            ),
                            itemCount: favorites.length,
                            itemBuilder: (context, index) {
                              final product = favorites[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.md,
                                ),
                                child: FavoriteCard(
                                  key: ValueKey(product.id),
                                  product: product,
                                  onRemove: () => _remove(context, product),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;

  const FavoriteCard({super.key, required this.product, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return EcoCard(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.alternative,
        arguments: product,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(asset: product.imageAsset, size: 70, height: 92),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardTitle.copyWith(fontSize: 17),
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
              IconButton(
                tooltip: 'Remove from favorites',
                icon: Icon(Icons.favorite, color: scheme.primary),
                onPressed: onRemove,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm + 4),
          Row(
            children: [
              if (product.score != null) ...[
                ScoreChip(score: product.score!),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: Text(
                  'Approx. ${product.carbon} CO₂e · ${product.plastic} plastic',
                  style: AppTextStyles.caption.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
