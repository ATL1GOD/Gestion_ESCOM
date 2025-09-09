import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class DocenteInfoCard extends StatelessWidget {
  final DocenteModel docente;
  const DocenteInfoCard({super.key, required this.docente});

  ImageProvider _getAvatarImage() {
    if (docente.sexo == 'M') {
      return const NetworkImage(
        'https://uteycv.escom.ipn.mx/csi/app-horarios/assets/imagenes/docente2.jpg',
      );
    } else if (docente.sexo == 'H') {
      return const NetworkImage(
        'https://uteycv.escom.ipn.mx/csi/app-horarios/assets/imagenes/docente1.jpg',
      );
    } else {
      return const NetworkImage(
        'https://uteycv.escom.ipn.mx/csi/app-horarios/assets/imagenes/tiburon2.png',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 150.0,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(26),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -5,
                  left: -16,
                  right: -16,
                  bottom: -20,
                  child: Opacity(
                    opacity: 1,
                    child: Image.network(
                      'https://uteycv.escom.ipn.mx/csi/app-horarios/assets/imagenes/tiburon3.png',
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 50),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                docente.profesor,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Cubiculo: ${docente.ubicacion}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              docente.correo,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.textPrimary,
                    backgroundImage: _getAvatarImage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
