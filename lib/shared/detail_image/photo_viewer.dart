import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerScreen extends StatelessWidget {
  final String imagePath;
  final String heroTag;
  final String title;

  const PhotoViewerScreen({
    super.key,
    required this.imagePath,
    required this.heroTag,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      // El fondo del Scaffold también puede ser negro para una experiencia más inmersiva
      backgroundColor: Colors.black,
      body: Hero(
        tag: heroTag,
        child: PhotoView(
          imageProvider: NetworkImage(imagePath),
          // Muestra un indicador de carga mientras la imagen se prepara
          loadingBuilder: (context, event) => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          // Define los límites de zoom
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2.5,
          // Habilita la rotación de la imagen
          enableRotation: true,
        ),
      ),
    );
  }
}
