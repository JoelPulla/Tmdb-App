import 'package:flutter/material.dart';

class ItemsSetting {
  final IconData iconData;
  final String label;

  const ItemsSetting({
    required this.iconData,
    required this.label,
  });
}

const itemSettings = <ItemsSetting>[
  ItemsSetting(
    iconData: Icons.mail_outline,
    label: 'joel.pulla@outlook.com',
  ),
  ItemsSetting(
    iconData: Icons.code,
    label: 'JoelPulla',
  ),
  ItemsSetting(
    iconData: Icons.location_city,
    label: 'Ecuador/ Azuay/ Cuenca',
  ),
  ItemsSetting(
    iconData: Icons.camera_alt_outlined,
    label: '@JoelDev',
  ),
];
