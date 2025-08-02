import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapaScreen extends StatelessWidget {
  const MapaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Scaffold(
      backgroundColor:
          Colors.white, // Color de fondo para la sección de la galería
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.vertical,
        // Se reemplaza InfoSection por tu nuevo widget FotosSection
        children: const [
          RandomCardSection(),
          // Se envuelve FotosSection en un SingleChildScrollView
          // para permitir el scroll si la galería es muy larga.
          SingleChildScrollView(child: FotosSection()),
        ],
      ),
    );
  }
}

// --- PRIMERA PANTALLA (SIN CAMBIOS) ---
class RandomCardSection extends StatelessWidget {
  const RandomCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final cards = CardListModel.cards;
    final card = cards[random.nextInt(cards.length)];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Transform.scale(
              scale: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(card.assetPath, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withAlpha(75),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              '',
              textAlign: TextAlign.center,
              style: GoogleFonts.blackOpsOne(
                fontSize: 45.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
          ),
          const Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 40,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// --- SEGUNDA PANTALLA (CON LA MODIFICACIÓN) ---
class FotosSection extends StatelessWidget {
  const FotosSection({super.key});

  // Hacemos que la lista de fotos sea constante
  static const List<Map<String, String>> photos = [
    {
      'imagenAsset': 'assets/images/escom_edificio1.png',
      'title': 'Edificio 1',
      'author': 'ESCOM',
    },
    {
      'imagenAsset': 'assets/images/escom_edificio2.png',
      'title': 'Edificio 2',
      'author': 'ESCOM',
    },
    {
      'imagenAsset': 'assets/images/escom_edificio3.png',
      'title': 'Edificio 3',
      'author': 'ESCOM',
    },
    {
      'imagenAsset': 'assets/images/escom_edificio4.png',
      'title': 'Edificio 4',
      'author': 'ESCOM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          const Text(
            '', // Título de la sección
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ubica tu salón con esta guía visual para reconocer y ubicar fácilmente los salones, laboratorios y puntos clave de la escuela', // Título de la sección
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          // GridView para mostrar las fotos
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Número de columnas
              crossAxisSpacing: 12.0, // Espacio entre columnas
              mainAxisSpacing: 12.0, // Espacio entre filas
              childAspectRatio: 0.8, // Ajusta la proporción de las tarjetas
            ),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return GestureDetector(
                onTap: () {
                  _openFullScreenImage(context, photo['imagenAsset']!);
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Imagen
                      Expanded(
                        child: Image.asset(
                          photo['imagenAsset']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Pie de foto
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              photo['title']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Por ${photo['author']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _openFullScreenImage(BuildContext context, String imagenAsset) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // Cierra el diálogo al tocar fuera
          },
          child: Dialog.fullscreen(
            backgroundColor: Colors.black.withOpacity(0.8),
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(
                child: GestureDetector(
                  onTap:
                      () {}, // Evita que el toque en la imagen cierre el diálogo
                  child: Image.asset(imagenAsset),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CardListModel {
  final String assetPath;
  CardListModel(this.assetPath);

  static final cards = [CardListModel('assets/images/mapa_escom.png')];
}
