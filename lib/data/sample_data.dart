import 'package:flutter/material.dart';
import '../models/history_entry.dart';
import '../models/product.dart';

class SampleData {
  static const Product originalSoap = Product(
    id: 'soap-original',
    name: 'Everyday Liquid Hand Soap',
    subtitle: '500 mL · Liquid soap',
    category: 'Soap',
    imageAsset: 'assets/images/soap_original.jpg',
    score: 42,
    carbon: '0.90–1.50 kg',
    plastic: '35–45 g',
    packaging: 'Pump bottle',
    barcode: 1234567890123,
  );

  static const Product kindred = Product(
    id: 'soap-kindred',
    name: 'Kindred Hand Wash Refill',
    subtitle: 'Refill pouch · 500 mL',
    category: 'Soap',
    imageAsset: 'assets/images/soap_kindred_refill.jpg',
    score: 78,
    carbon: '0.45–0.75 kg',
    plastic: '6–10 g',
    potential: '−0.60 kg CO₂e · −32 g plastic',
    packaging: 'Refill pouch',
    explanation: 'The refill example has a lower estimated plastic range '
        '(6–10 g vs 35–45 g). Its carbon estimate also falls below the '
        'original. This comparison assumes bottle reuse.',
  );

  static const Product loop = Product(
    id: 'soap-loop',
    name: 'Loop Glass Hand Wash',
    subtitle: 'Glass bottle · 500 mL',
    category: 'Soap',
    imageAsset: 'assets/images/soap_loop_glass.jpg',
    score: 68,
    carbon: '0.63–1.05 kg',
    plastic: '10–14 g',
    potential: '−0.36 kg CO₂e · −28 g plastic',
    packaging: 'Glass bottle',
    explanation: 'The Loop Glass Hand Wash example has a lower estimated '
        'plastic range (10–14 g vs 35–45 g). Its carbon estimate also falls '
        'below the original. The product is in a glass bottle, which has a '
        'lower environmental impact.',
  );

  static const Product paper = Product(
    id: 'soap-paper',
    name: 'Pure Paper Hand Wash Refill',
    subtitle: 'Paper carton · 500 mL',
    category: 'Soap',
    imageAsset: 'assets/images/soap_paper_carton.jpg',
    score: 84,
    carbon: '0.36–0.60 kg',
    plastic: '3–5 g',
    potential: '−0.72 kg CO₂e · −36 g plastic',
    packaging: 'Paper carton',
    explanation: 'The Pure Paper Hand Wash Refill example has the lowest '
        'estimated plastic range (3–5 g vs 35–45 g). Its carbon estimate also '
        'falls below the original. The product comes in a paper carton, which '
        'lowers plastic use.',
  );

  static const List<Product> alternatives = [kindred, loop, paper];

  static const List<Product> searchResults = [
    originalSoap,
    Product(
      id: 'soap-kindred-search',
      name: 'Kindred Hand Wash Refill',
      subtitle: '500 mL · Refill pouch',
      category: 'Soap',
    ),
    Product(
      id: 'detergent-everyday',
      name: 'Everyday Laundry Detergent',
      subtitle: '1 L · Liquid detergent',
      category: 'Soap',
    ),
  ];


  static List<Product> initialFavorites() => [kindred, paper];

  static const List<HistoryEntry> history = [
    HistoryEntry(
      title: 'Everyday Liquid Hand Soap',
      detail: '500 mL · Barcode · 9:38 AM',
      recentDetail: '500 mL · Liquid soap',
      category: 'Soap',
      group: 'Liquid soap & detergent',
      dayLabel: 'Today',
      date: 'October 19',
      icon: Icons.water_drop_outlined,
    ),
    HistoryEntry(
      title: 'Everyday Cotton T-shirt',
      detail: '1 item · Text search · 9:12 AM',
      recentDetail: '1 item · T-shirts',
      category: 'T-shirts',
      group: 'T-shirts',
      dayLabel: 'Today',
      date: 'October 19',
      icon: Icons.checkroom_outlined,
    ),
    HistoryEntry(
      title: 'Harvest Oat Crackers',
      detail: '200 g · Text search · 5:24 PM',
      recentDetail: '200 g · Packaged food',
      category: 'Food',
      group: 'Packaged food',
      dayLabel: 'Yesterday',
      date: 'October 18',
      icon: Icons.inventory_2_outlined,
    ),
    HistoryEntry(
      title: 'Everyday Laundry Liquid',
      detail: '1 L · Text search · 11:06 AM',
      recentDetail: '1 L · Liquid detergent',
      category: 'Soap',
      group: 'Liquid soap & detergent',
      dayLabel: 'Yesterday',
      date: 'October 18',
      icon: Icons.water_drop_outlined,
    ),
  ];
}
