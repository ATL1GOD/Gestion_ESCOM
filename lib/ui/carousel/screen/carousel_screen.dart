import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/carousel/model/carousel_model.dart';
import 'package:gestion_escom/ui/carousel/widgets/sliver_appbar.dart';
import 'package:gestion_escom/ui/carousel/widgets/info_body.dart';

class CarouselScreen extends StatelessWidget {
  final CarouselItem infoItem;

  const CarouselScreen({super.key, required this.infoItem});

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      body: Stack(
        children: [
          // Contenido principal que se puede desplazar
          CustomScrollView(
            slivers: [
              // El AppBar se mantiene igual
              CustomSliverAppBar(infoItem: infoItem),

              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        scaffoldBackgroundColor, // El color del fondo del lienzo
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: InfoDetailsBody(
                    infoItem: infoItem,
                  ), // El contenido va adentro
                ),
              ),
            ],
          ),

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
                    scaffoldBackgroundColor,
                    scaffoldBackgroundColor.withAlpha(0),
                  ],
                  stops: const [0.2, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
