import 'package:flutter/material.dart';
import 'sample_data.dart';
import '../models/product.dart';

class AppState {
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  static final ValueNotifier<List<Product>> favorites =
      ValueNotifier<List<Product>>(SampleData.initialFavorites());

  static bool isFavorite(Product p) => favorites.value.any((f) => f.id == p.id);

  static void addFavorite(Product p) {
    if (isFavorite(p)) return;
    favorites.value = [...favorites.value, p];
  }

  static void removeFavorite(Product p) {
    favorites.value = favorites.value.where((f) => f.id != p.id).toList();
  }
}
