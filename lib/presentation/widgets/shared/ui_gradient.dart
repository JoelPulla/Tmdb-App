import 'package:flutter/material.dart';

class UiGradient extends StatelessWidget {
  final Alignment data;

  const UiGradient({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: data,
          colors: [
            themeColors.surface,
            themeColors.surface,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class UiGradientTop extends StatelessWidget {
  final Alignment data;

  const UiGradientTop({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: data,
          colors: [
            themeColors.surface,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
