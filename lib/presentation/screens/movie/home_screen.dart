import 'package:flutter/material.dart';

import 'package:tmdb_app_dio/presentation/widgets/widgets.dart';
import 'package:tmdb_app_dio/presentation/views/views.dart';

class HomeScreen extends StatelessWidget {
  static const String name = '/';
  final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex,
  });

  final viewRoutes = const <Widget>[
    HomeView(),
    ChanelsView(),
    FavoritesView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: AppButtonNavigatorBar(currentIndex: pageIndex),
    );
  }
}
