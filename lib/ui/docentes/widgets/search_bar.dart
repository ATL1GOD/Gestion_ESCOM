import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/card5.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Para que la tarjeta no ocupe toda la pantalla
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Busca a\ntu profesor',
            style: GoogleFonts.comicNeue(
              fontSize: 25,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
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
              hintText: 'Buscar por nombre o correo',
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
