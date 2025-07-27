import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';

class DocenteListItemWidget extends StatelessWidget {
  final DocenteModel docente;
  final int index;
  final bool startAnimation;
  final double screenWidth;

  const DocenteListItemWidget({
    super.key,
    required this.docente,
    required this.index,
    required this.startAnimation,
    required this.screenWidth,
  });

  // Método para obtener la imagen del avatar según el género del docente
  AssetImage _getAvatarImage() {
    if (docente.sexo == 'M') {
      return const AssetImage(
        "assets/images/card2.png",
      ); // Path to your female avatar
    } else if (docente.sexo == 'H') {
      return const AssetImage(
        "assets/images/card3.png",
      ); // Path to your male avatar
    } else {
      return const AssetImage(
        "assets/images/fondo1.png",
      ); // A default/fallback image
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          '/docentes/${docente.numEmpleado}',
        ); // Navega a la pantalla de detalle del docente
      },
      child: AnimatedContainer(
        height: 80, // Aumentamos la altura para más contenido
        width: screenWidth, // Ancho completo de la pantalla
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300 + (index * 200)),
        transform: Matrix4.translationValues(
          startAnimation ? 0 : screenWidth,
          0,
          0,
        ),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withAlpha(100),
              spreadRadius: 1, // Aumenta el spread para una sombra más difusa
              blurRadius: 5, // Aumenta el blur para una sombra más suave
              offset: const Offset(0, 4), // Cambia la dirección de la sombra
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          leading: CircleAvatar(
            backgroundImage: _getAvatarImage(),
            radius: 25, // Aumenta el radio para un avatar más grande
          ),
          title: Text(
            docente.profesor,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          subtitle: Text(
            docente.correo,
            style: TextStyle(color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
