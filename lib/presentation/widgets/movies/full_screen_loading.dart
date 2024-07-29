import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FullScreenLoading extends StatelessWidget {
  const FullScreenLoading({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Searching Data',
      'Reorganizate Data',
      'Buy Movies'
          'Terminate proyect',
      'Esto tardo mesiado',
    ];

    return Stream.periodic(const Duration(seconds: 2), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    final themeText = Theme.of(context).textTheme;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Loading Data', style: themeText.titleMedium),
          const SizedBox(height: 10),
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text(
                  'Loading',
                  style: themeText.bodyMedium,
                );
              }

              return FadeIn(
                  delay: const Duration(seconds: 1),
                  child: Text(
                    snapshot.data!,
                    style: themeText.bodyMedium,
                  ));
            },
          )
        ],
      ),
    );
  }
}
