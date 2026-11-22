import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav.dart';
import 'favorites_tab.dart';
import 'history_tab.dart';
import 'search_tab.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  bool _readArguments = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_readArguments) {
      _readArguments = true;
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int && args >= 0 && args <= 2) {
        _index = args;
      }
    }
  }

  void _goTo(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          SearchTab(onViewHistory: () => _goTo(2)),
          const FavoritesTab(),
          const HistoryTab(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: _index,
        onSelected: _goTo,
      ),
    );
  }
}
