import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String subtitle;
  final String category;
  final IconData icon;
  final String? imageAsset;
  final int? score;
  final String carbon;
  final String plastic;
  final String potential;
  final String packaging;
  final String explanation;
  final int? barcode;
  const Product({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.category,
    this.barcode = null,
    this.icon = Icons.water_drop_outlined,
    this.imageAsset,
    this.score,
    this.carbon = '',
    this.plastic = '',
    this.potential = '',
    this.packaging = '',
    this.explanation = '',

  });
}
