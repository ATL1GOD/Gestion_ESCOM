import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademiaSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const AcademiaSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/academia0.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withAlpha(100),
            spreadRadius: 1, // Aumenta el spread para una sombra más difusa
            blurRadius: 5, // Aumenta el blur para una sombra más suave
            offset: const Offset(0, 4), // Cambia la dirección de la sombra
          ),
        ],
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Para que la tarjeta no ocupe toda la pantalla
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Busca tu \n        academia',
            style: GoogleFonts.comicNeue(
              fontSize: 29,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            onChanged: onChanged,
            cursorColor: AppColors.textPrimary,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 12.0,
              ),
              filled: true,
              fillColor: AppColors.white,
              hintText: 'Buscar por materia o academia',
              hintStyle: const TextStyle(color: AppColors.secondary),
              prefixIcon: const Icon(Icons.search, color: AppColors.secondary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: AppColors.secondary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: AppColors.secondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
