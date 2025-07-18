import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: 'Buscar por nombre o correo',
          labelStyle: const TextStyle(color: AppColors.textgrey),
          hintText: 'Buscar por nombre o correo',
          hintStyle: const TextStyle(color: AppColors.secondary),
          prefixIcon: const Icon(Icons.search, color: AppColors.secondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.secondary),
          ),
        ),
      ),
    );
  }
}
