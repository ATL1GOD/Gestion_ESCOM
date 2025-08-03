import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/home/model/home_model.dart';
import 'package:gestion_escom/shared/detail_image/photo_viewer.dart';

class MapaSection extends StatelessWidget {
  const MapaSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return const SizedBox.shrink();
    }
    final MapaPhoto featuredPhoto = photos.first;
    final List<MapaPhoto> gridPhotos = photos.sublist(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ubica tu salón con esta guía visual para reconocer y ubicar fácilmente los salones, laboratorios y puntos clave de la escuela.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoViewerScreen(
                  imagePath: featuredPhoto.imagenmapa,
                  heroTag: featuredPhoto.imagenmapa,
                  title: featuredPhoto.title,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Hero(
              tag: featuredPhoto.imagenmapa,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(featuredPhoto.imagenmapa, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'En esta sección encontrarás una serie de imágenes que te ayudarán a identificar los salones y laboratorios de la escuela.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.8,
          ),
          itemCount: gridPhotos.length,
          itemBuilder: (context, index) {
            final photo = gridPhotos[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoViewerScreen(
                      imagePath: photo.imagenmapa,
                      heroTag: photo.imagenmapa,
                      title: photo.title,
                    ),
                  ),
                );
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
                    Expanded(
                      child: Hero(
                        tag: photo.imagenmapa,
                        child: Image.asset(photo.imagenmapa, fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            photo.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Por ${photo.author}',
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
    );
  }
}
