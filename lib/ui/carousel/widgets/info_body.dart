import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/carousel/model/carousel_model.dart';
import 'package:gestion_escom/ui/carousel/widgets/carousel/becas/becas_section.dart';
import 'package:gestion_escom/ui/carousel/widgets/carousel/social/redes_section.dart';

class InfoDetailsBody extends StatelessWidget {
  final CarouselItem infoItem;

  const InfoDetailsBody({super.key, required this.infoItem});

  @override
  Widget build(BuildContext context) {
    // We now use a decoration on the Container to get rounded corners.
    return Container(
      // Add a decoration to create the rounded top corners effect.
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      // Add some padding around the content.
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(infoItem.imgUrl)),
              const SizedBox(width: 8.0),
              Text(
                infoItem.author,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _buildContentSection(context),
        ],
      ),
    );
  }

  /// Método helper para construir la sección de contenido según el tipo.
  Widget _buildContentSection(BuildContext context) {
    // ... (Your switch statement will be corrected in the next step)
    switch (infoItem.infoItemType) {
      case InfoItem.calendario:
        // This is currently incorrect, it will be fixed in the next section.
        return const BecasSection();
      case InfoItem.redesSociales:
        return const RedesSection();
      case InfoItem.croquis:
        return const RedesSection();
      case InfoItem.desconocido:
        return Text(
          'El contenido de esta noticia no está disponible.',
          style: Theme.of(context).textTheme.bodyLarge,
        );
    }
  }
}
