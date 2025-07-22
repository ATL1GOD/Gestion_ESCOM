import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';

// Este widget muestra la imagen centrada con diseño atractivo
class CustomLoginCard extends StatelessWidget {
  const CustomLoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(70),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(128),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/login_imagen.png',
              width: 125,
              height: 125,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
