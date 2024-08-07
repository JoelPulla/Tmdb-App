import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tmdb_app_dio/config/menu/items/items_settings.dart';
import 'package:tmdb_app_dio/config/providers/theme_provider.dart';

class SettingsView extends ConsumerWidget {
  static const String name = 'config_screen';

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textThemeApp = Theme.of(context).textTheme;
    final themeApp = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text Title
              const SizedBox(height: 40),
              Text('Configuracion', style: textThemeApp.titleLarge),

              //Profile
              const SizedBox(height: 5),
              const _ProfileCard(),

              //CardContacts
              const SizedBox(height: 15),
              SizedBox(
                height: 198,
                child: Card(
                  color: themeApp.surfaceContainerLowest,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(10),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemSettings.length,
                      itemBuilder: (context, index) {
                        final data = itemSettings[index];

                        return __DetailOptions(data: data);
                      },
                    ),
                  ),
                ),
              ),

              //CardColors
              const SizedBox(height: 15),
              const CarColors(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends ConsumerWidget {
  const _ProfileCard();

  static const imageAvatar =
      'https://img.freepik.com/free-photo/3d-illustration-boy-with-backpack-looking-camera_1142-42845.jpg?t=st=1721840094~exp=1721843694~hmac=8672fe1daaf2551c9339184b9e65a5f0f45534b73c390c8a75717409faa29a6a&w=740';

  @override
  Widget build(BuildContext context, ref) {
    final themeApp = Theme.of(context).colorScheme;
    //final isDarkMode = ref.watch(isDarkModeProvider);
    final textThemeApp = Theme.of(context).textTheme;
    return Card(
      color: themeApp.surfaceContainerLowest,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: NetworkImage(imageAvatar)),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Joel Pulla M.',
                      style: textThemeApp.bodyMedium,
                    ),
                    Text(
                      'Joel Dev',
                      style: TextStyle(
                        color: themeApp.onSurface,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // IconButton(

                //   // icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                //   // onPressed: () {
                //   //   ref
                //   //       .read(isDarkModeProvider.notifier)
                //   //       .update((state) => !state);
                //   // },
                // ),
              ],
            ),
            const Divider(),
            const Row(
              children: [
                Icon(Icons.person_outline_rounded),
                SizedBox(width: 10),
                Text('Avatar'),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class __DetailOptions extends StatelessWidget {
  const __DetailOptions({
    required this.data,
  });

  final ItemsSetting data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                data.iconData,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(data.label),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CarColors extends ConsumerWidget {
  const CarColors({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeApp = Theme.of(context).colorScheme;
    final List<Color> colors = ref.watch(themeColorprovider);
    final int indexProvider = ref.watch(selectedColorProvider);

    return SizedBox(
      height: 200,
      child: Card(
        color: themeApp.surfaceContainerLowest,
        child: ListView.builder(
          itemCount: colors.length,
          itemBuilder: (context, index) {
            final Color color = colors[index];

            return RadioListTile(
              title: Text('The color: ', style: TextStyle(color: color)),
              subtitle: Text(color.value.toString()),
              activeColor: color,
              value: index,
              groupValue: indexProvider,
              onChanged: (value) {
                ref.read(selectedColorProvider.notifier).state = index;
              },
            );
          },
        ),
      ),
    );
  }
}
