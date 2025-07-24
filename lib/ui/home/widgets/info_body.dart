import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/carousel/model/carousel_model.dart';

// Asumimos que estas secciones están importadas
import 'package:gestion_escom/ui/carousel/widgets/carousel/becas/becas_section.dart';
import 'package:gestion_escom/ui/carousel/widgets/carousel/social/redes_section.dart';
import 'package:gestion_escom/ui/carousel/widgets/carousel/fotografias/fotos_section.dart';

class InfoDetailsBody extends StatelessWidget {
  final CarouselItem infoItem;

  const InfoDetailsBody({super.key, required this.infoItem});

  @override
  Widget build(BuildContext context) {
    // El Padding y el SingleChildScrollView se han eliminado.
    // Esto ahora debe ser manejado por el Sliver padre.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        // Fila del autor (sin cambios)
        Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(infoItem.imgAssets)),
            const SizedBox(width: 8.0),
            Text(
              infoItem.author,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // Usa un 'switch' sobre el enum. Es más seguro y escalable.
        _buildContentSection(context),
      ],
    );
  }

  /// Método helper para construir la sección de contenido según el tipo.
  Widget _buildContentSection(BuildContext context) {
    switch (infoItem.infoItemType) {
      case InfoItem.calendario:
        return const BecasSection();
      case InfoItem.redesSociales:
        return const RedesSection();
      case InfoItem.croquis:
        return const FotosSection();
      case InfoItem.desconocido:
        return Text(
          'El contenido de esta noticia no está disponible.',
          style: Theme.of(context).textTheme.bodyLarge,
        );
    }
  }
}
