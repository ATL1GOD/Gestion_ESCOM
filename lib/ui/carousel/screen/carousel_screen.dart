import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/carousel/model/carousel_model.dart';
import 'package:gestion_escom/ui/home/widgets/sliver_appbar.dart';
import 'package:gestion_escom/ui/home/widgets/info_body.dart';

class CarouselScreen extends StatelessWidget {
  final CarouselItem infoItem;

  const CarouselScreen({super.key, required this.infoItem});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el color de fondo del tema para que el degradado funcione
    // tanto en modo claro como en modo oscuro.
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      body: Stack(
        children: [
          // Contenido principal que se puede desplazar
          CustomScrollView(
            slivers: [
              // El AppBar y el cuerpo ahora reciben el objeto completo
              CustomSliverAppBar(infoItem: infoItem),
              SliverToBoxAdapter(child: InfoDetailsBody(infoItem: infoItem)),
            ],
          ),

          // Degradado superpuesto en la parte inferior para un efecto de desvanecimiento
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120, // Altura del degradado
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    scaffoldBackgroundColor, // Color sólido del tema
                    scaffoldBackgroundColor.withOpacity(0), // Transparente
                  ],
                  stops: const [
                    0.2,
                    1.0,
                  ], // Controla la transición del degradado
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
