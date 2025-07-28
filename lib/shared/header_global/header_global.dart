// lib/ui/home/widgets/header_fijo.dart

import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class HeaderFijo extends StatelessWidget {
  const HeaderFijo({super.key});

  @override
  Widget build(BuildContext context) {
    // Se usa ClipPath para darle una forma personalizada al contenedor del fondo.
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 200,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.textPrimary, AppColors.textSecondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/escudo_ESCOM_blanco.png',
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}

// Clase que define la forma de la curva para el ClipPath.
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
      0,
      size.height - 50,
    ); // Inicia un poco más arriba en la izquierda.

    // Crea la curva Bezier para el efecto de ola.
    var firstControlPoint = Offset(
      size.width / 4,
      size.height,
    ); // Punto de control de la curva.
    var firstEndPoint = Offset(
      size.width / 2,
      size.height - 30.0,
    ); // Punto final de la curva.
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(
      //
      size.width - (size.width / 4),
      size.height - 65,
    );
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0); // Línea hacia la esquina superior derecha.
    path.close(); // Cierra el camino.

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
