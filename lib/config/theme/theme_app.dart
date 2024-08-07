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

  ThemeApp({
    this.selectedColor = 0,
  });

  ThemeData getTheme() => ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: colorList[selectedColor],
      );
}
