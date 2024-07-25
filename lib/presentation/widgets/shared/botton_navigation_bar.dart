import 'package:flutter/material.dart';
import 'package:tmdb_app_dio/presentation/screens/screens.dart';

class AppButtonNavigatorBar extends StatefulWidget {
  const AppButtonNavigatorBar({super.key});

  @override
  State<AppButtonNavigatorBar> createState() => _AppButtonNavigatorBarState();
}

class _AppButtonNavigatorBarState extends State<AppButtonNavigatorBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: selectedIndex,
        selectedItemColor: colors.primary,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_suggest_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  final screens = [
    const HomeView(),
    const ConfigScreen(),
  ];
}
