import 'package:flutter/material.dart';

import 'package:tmdb_app_dio/presentation/screens/screens.dart';
import 'package:tmdb_app_dio/presentation/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: AppButtonNavigatorBar(),
    );
  }
}
