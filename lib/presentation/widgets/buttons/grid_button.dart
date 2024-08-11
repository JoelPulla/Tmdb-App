import 'package:flutter/material.dart';

class LinearGradientButton extends StatelessWidget {
  const LinearGradientButton({super.key});

  @override
  Widget build(BuildContext context) {

    final themeText = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 7, 5, 152),
            Color.fromARGB(255, 0, 134, 243),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Row(
          children: [
            const Icon(Icons.play_arrow_rounded),
            const SizedBox(width: 5),
            Text(
              'Ver Ahora',
              style: themeText.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
