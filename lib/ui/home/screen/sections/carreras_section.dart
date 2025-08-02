import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/home/model/home_model.dart';

class CarrerasSection extends StatelessWidget {
  final CarreraItem carreraItem;

  const CarrerasSection({super.key, required this.carreraItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity, // Ocupa todo el ancho disponible
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ), // Espaciado interno
          decoration: BoxDecoration(
            color: AppColors.textSecondary, // Fondo azul
            borderRadius: BorderRadius.circular(16.0), // Esquinas redondeadas
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(
                  77,
                ), // Sombra para simular el bisel
                offset: const Offset(
                  4,
                  4,
                ), // Dirección de la sombra (abajo y derecha)
                blurRadius: 6, // Difuminado
                spreadRadius: 1, // Extensión de la sombra
              ),
              BoxShadow(
                color: AppColors.white.withAlpha(
                  179,
                ), // Luz superior para bisel
                offset: const Offset(
                  -4,
                  -4,
                ), // Dirección opuesta (arriba y izquierda)
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            "Objetivo",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 25.0),
        Text(
          carreraItem.objectivo,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16.0,
            fontFamily: 'ExtraLight',
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 25.0),

        Container(
          width: double.infinity, // Ocupa todo el ancho disponible
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ), // Espaciado interno
          decoration: BoxDecoration(
            color: AppColors.textSecondary, // Fondo azul
            borderRadius: BorderRadius.circular(16.0), // Esquinas redondeadas
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(
                  77,
                ), // Sombra para simular el bisel
                offset: const Offset(
                  4,
                  4,
                ), // Dirección de la sombra (abajo y derecha)
                blurRadius: 6, // Difuminado
                spreadRadius: 1, // Extensión de la sombra
              ),
              BoxShadow(
                color: AppColors.white.withAlpha(
                  179,
                ), // Luz superior para bisel
                offset: const Offset(
                  -4,
                  -4,
                ), // Dirección opuesta (arriba y izquierda)
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            "Perfil de Ingreso",
            textAlign: TextAlign.center, // Centra el texto horizontalmente
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.white, // Color del texto
              fontWeight: FontWeight.bold, // Negrita para destacar
            ),
          ),
        ),
        const SizedBox(height: 25.0),
        Text(
          carreraItem.perfilIngreso,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16.0,
            fontFamily: 'ExtraLight',
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 25.0),

        Container(
          width: double.infinity, // Ocupa todo el ancho disponible
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ), // Espaciado interno
          decoration: BoxDecoration(
            color: AppColors.textSecondary, // Fondo azul
            borderRadius: BorderRadius.circular(16.0), // Esquinas redondeadas
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(
                  77,
                ), // Sombra para simular el bisel
                offset: const Offset(
                  4,
                  4,
                ), // Dirección de la sombra (abajo y derecha)
                blurRadius: 6, // Difuminado
                spreadRadius: 1, // Extensión de la sombra
              ),
              BoxShadow(
                color: AppColors.white.withAlpha(
                  179,
                ), // Luz superior para bisel
                offset: const Offset(
                  -4,
                  -4,
                ), // Dirección opuesta (arriba y izquierda)
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            "Perfil de Egreso",
            textAlign: TextAlign.center, // Centra el texto horizontalmente
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.white, // Color del texto
              fontWeight: FontWeight.bold, // Negrita para destacar
            ),
          ),
        ),

        const SizedBox(height: 25.0),
        Text(
          carreraItem.perfilEgreso,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16.0,
            fontFamily: 'ExtraLight',
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 25.0),
        Container(
          width: double.infinity, // Ocupa todo el ancho disponible
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ), // Espaciado interno
          decoration: BoxDecoration(
            color: AppColors.textSecondary, // Fondo azul
            borderRadius: BorderRadius.circular(16.0), // Esquinas redondeadas
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withAlpha(
                  77,
                ), // Sombra para simular el bisel
                offset: const Offset(
                  4,
                  4,
                ), // Dirección de la sombra (abajo y derecha)
                blurRadius: 6, // Difuminado
                spreadRadius: 1, // Extensión de la sombra
              ),
              BoxShadow(
                color: AppColors.white.withAlpha(
                  179,
                ), // Luz superior para bisel
                offset: const Offset(
                  -4,
                  -4,
                ), // Dirección opuesta (arriba y izquierda)
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            "Campo Laboral",
            textAlign: TextAlign.center, // Centra el texto horizontalmente
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.white, // Color del texto
              fontWeight: FontWeight.bold, // Negrita para destacar
            ),
          ),
        ),
        const SizedBox(height: 25.0),
        Text(
          carreraItem.campoLaboral,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16.0,
            fontFamily: 'ExtraLight',
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 25.0),
      ],
    );
  }
}
