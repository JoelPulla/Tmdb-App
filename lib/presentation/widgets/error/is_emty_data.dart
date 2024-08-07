import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IsEmtyData extends StatelessWidget {
  final IconData iconData;
  final String description;
  final String textButton;
  final String? routeF;

  const IsEmtyData({
    super.key,
    required this.iconData,
    required this.description,
    required this.textButton,
    this.routeF = '/home/0',
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    //final themeText = Theme.of(context).textTheme;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: themeColor.primary,
            size: 70,
          ),
          Text(
            'Ohhh no!!!',
            style: TextStyle(color: themeColor.primary, fontSize: 30),
          ),
          Text(
            description,
            style: TextStyle(
              color: themeColor.inverseSurface,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => context.go(routeF!),
            child: Text(textButton),
          )
        ],
      ),
    );
  }
}
