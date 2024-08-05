import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppButtonNavigatorBar extends StatelessWidget {
  final int currentIndex;

  const AppButtonNavigatorBar({
    super.key,
    required this.currentIndex,
  });

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      elevation: 0,
      selectedItemColor: colors.primary,
      onTap: (value) => onItemTapped(context, value),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.live_tv_rounded),
          label: 'Tv',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_suggest_outlined),
          label: 'Settings',
        ),
      ],
    );
  }
}
