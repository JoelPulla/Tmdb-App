import 'package:flutter/material.dart';

class UiGradient extends StatelessWidget {
  final Alignment data;
  final double sizeHgrid;

  const UiGradient({
    super.key,
    required this.data,
    this.sizeHgrid = 0.61,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * sizeHgrid,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: data,
          colors: [
            scaffoldBackgroundColor,
            scaffoldBackgroundColor,
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
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.6,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: data,
          colors: [
            scaffoldBackgroundColor,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
