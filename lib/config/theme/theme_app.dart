import 'package:flutter/material.dart';

final colorList = <Color>[
  const Color.fromARGB(255, 0, 140, 255),
  Colors.green,
  Colors.amber,
  Colors.red,
  Colors.cyan,
];

class ThemeApp {
  final int selectedColor;
  final bool isDarkMode;

  ThemeApp({
    this.selectedColor = 0,
    this.isDarkMode = false,
  });

  ThemeData getTheme() => ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorList[selectedColor],
      );
}
