import 'package:flutter/material.dart';

import 'package:tmdb_app_dio/presentation/screens/screens.dart';
import 'package:tmdb_app_dio/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_page';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: AppButtonNavigatorBar(),
    );
  }
}
