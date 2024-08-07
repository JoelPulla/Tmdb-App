import 'package:flutter/material.dart';
import 'package:tmdb_app_dio/presentation/widgets/widgets.dart';

class ChanelsView extends StatelessWidget {
  static const name = 'chanels_view';
  const ChanelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const IsEmtyData(
      iconData: Icons.live_tv_rounded,
      description: 'Por el Momento no estan activos los canales',
      textButton: 'Regresar a las Movies',
    );
  }
}
