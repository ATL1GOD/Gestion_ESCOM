import 'package:flutter/material.dart';

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
    this.iconSize = 24.0,
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
      color: color ?? themeColors.onSurface,
      style: IconButton.styleFrom(
        // Usamos el color de fondo provisto, o uno semi-transparente del tema
        backgroundColor:
            backgroundColor ?? themeColors.onSurface.withOpacity(0.1),
        shape: const CircleBorder(),
      ),
    );
  }
}
