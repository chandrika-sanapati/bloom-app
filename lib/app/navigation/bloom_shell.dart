import 'package:bloom/features/discover/presentation/discover_screen.dart';
import 'package:bloom/features/plants/presentation/plants_screen.dart';
import 'package:bloom/features/settings/presentation/settings_screen.dart';
import 'package:bloom/features/today/presentation/today_screen.dart';
import 'package:flutter/material.dart';

/// App shell with Today / My Plants / Discover. Settings opens from the app bar.
class BloomShell extends StatefulWidget {
  const BloomShell({super.key});

  @override
  State<BloomShell> createState() => _BloomShellState();
}

class _BloomShellState extends State<BloomShell> {
  int _index = 0;

  static const _titles = ['Today', 'My Plants', 'Discover'];

  void _openDiscover() {
    setState(() => _index = 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
              );
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: [
          const TodayScreen(),
          PlantsScreen(onAddPlant: _openDiscover),
          const DiscoverScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() => _index = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.wb_sunny_outlined),
            selectedIcon: Icon(Icons.wb_sunny),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_florist_outlined),
            selectedIcon: Icon(Icons.local_florist),
            label: 'My Plants',
          ),
          NavigationDestination(
            icon: Icon(Icons.travel_explore_outlined),
            selectedIcon: Icon(Icons.travel_explore),
            label: 'Discover',
          ),
        ],
      ),
    );
  }
}
