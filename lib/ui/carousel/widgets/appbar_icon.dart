import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class AppBarIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double iconSize;
  final Color? color;
  final Color? backgroundColor;

  const AppBarIcon({
    super.key,
    required this.icon,
    this.onTap,
    this.iconSize = 20.0,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Obtenemos el esquema de colores del tema actual
    final themeColors = Theme.of(context).colorScheme;

    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
      iconSize: iconSize,
      // Usamos el color provisto, o el color 'onSurface' del tema si es nulo
      color: AppColors.background,
      style: IconButton.styleFrom(
        // Usamos el color de fondo provisto, o uno semi-transparente del tema
        backgroundColor:
            backgroundColor ?? themeColors.onSurface.withAlpha(128),
        shape: const CircleBorder(),
      ),
    );
  }
}
