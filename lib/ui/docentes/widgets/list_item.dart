import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 80, // Aumentamos la altura para más contenido
      width: screenWidth,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (index * 200)),
      transform: Matrix4.translationValues(
        startAnimation ? 0 : screenWidth,
        0,
        0,
      ),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF222431),
          child: Text(
            docente.nombre[0], // Muestra la inicial del nombre
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          docente.nombreCompleto,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          docente.correo,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
