import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:gestion_escom/shared/navigation_navbar/navbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart'; // Necesario para el provider del índice

// Provider para el índice de la barra de navegación que estaba en navbar.dart
final navIndexProvider = StateProvider<int>((ref) => 0);

class ScaffoldWithNavBar extends ConsumerWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // El cuerpo de la pantalla es el 'navigationShell', que muestra la vista correcta.
      body: navigationShell,
      // La barra de navegación se coloca aquí de forma centralizada.
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavBar(
            // Le pasamos el índice actual a la NavBar.
            currentIndex: navigationShell.currentIndex,
            // Le pasamos una función para manejar el tap.
            onTap: (index) => _onTap(index, ref),
          ),
          Container(
            color: AppColors.ipn,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 0.5,
            ), // Espaciado vertical.
            child: Center(
              child: Text(
                '~~~  Instituto Politecnico Nacional  ~~~',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 11.0,
                  fontStyle: GoogleFonts.montserrat().fontStyle,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método que se ejecuta al presionar un ícono de la NavBar
  void _onTap(int index, WidgetRef ref) {
    // Actualizamos el provider con el nuevo índice.
    ref.read(navIndexProvider.notifier).state = index;

    // Usamos 'goBranch' para cambiar de pestaña sin perder el estado.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
