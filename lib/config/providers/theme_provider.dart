import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app_dio/config/theme/theme_app.dart';

// isDarkMode
final isDarkModeProvider = StateProvider((ref) => false);

//theme Colors
final themeColorprovider = Provider((ref) => colorList);
final selectedColorProvider = StateProvider((ref) => 0);
