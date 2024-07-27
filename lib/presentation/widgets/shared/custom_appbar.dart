import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    final themeText = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.movie_filter_outlined, color: themeColor.primary),
              const SizedBox(width: 5),
              Text('Movies App', style: themeText.titleMedium),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
    );
  }
}
