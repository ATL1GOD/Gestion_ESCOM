import 'package:flutter/material.dart';
import 'package:gestion_escom/shared/detail_image/fullscreen_image.dart';

class CalendarioSection extends StatelessWidget {
  const CalendarioSection({super.key});

  @override
  Widget build(BuildContext context) {
    const String imagePath = 'assets/images/calendarioipn.png';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conoce el calendario académico para el ciclo escolar actual:',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 8),

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalleImagenScreen(
                  imagePath: imagePath,
                  title: 'Calendario Académico IPN',
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Hero(
              tag: imagePath,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
