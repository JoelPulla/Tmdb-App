import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/config/theme/theme_app.dart';
import 'package:tmdb_app_dio/presentation/providers/theme_provider.dart';
import 'package:tmdb_app_dio/presentation/screens/screens.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDark = ref.watch(isDarkModeProvider);
    final int colors = ref.watch(selectedColorProvider);

    return MaterialApp(
      theme: ThemeApp(selectedColor: colors, isDarkMode: isDark).getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'TMDB APP',
      home: const HomePage(),
    );
  }
}
