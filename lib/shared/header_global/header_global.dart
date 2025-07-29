import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class HeaderFijo extends StatelessWidget {
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  final Color colorini;
  final Color colorfin;

  const HeaderFijo({
    super.key,
    required this.imagePath,
    this.imageWidth = 150,
    this.imageHeight = 150,
    this.colorini = AppColors.textSecondary,
    this.colorfin = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorini, colorfin],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset(imagePath, width: imageWidth, height: imageHeight),
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
