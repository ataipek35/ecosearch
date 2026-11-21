import 'package:flutter/material.dart';

class HistoryEntry {
  final String title;
  final String detail;
  final String recentDetail;
  final String category;
  final String group;
  final String dayLabel;
  final String date;
  final IconData icon;

  const HistoryEntry({
    required this.title,
    required this.detail,
    required this.recentDetail,
    required this.category,
    required this.group,
    required this.dayLabel,
    required this.date,
    required this.icon,
  });
}
