import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/home/model/home_model.dart';
import 'package:gestion_escom/ui/home/screen/sections/calendario_section.dart';
import 'package:gestion_escom/ui/home/screen/sections/carreras_section.dart';
import 'package:gestion_escom/ui/home/screen/sections/mapa_screen.dart';
import 'package:gestion_escom/ui/home/screen/sections/redes_section.dart';

class InfoDetailsBody extends StatelessWidget {
  final CarouselItem infoItem;

  const InfoDetailsBody({super.key, required this.infoItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(infoItem.imgUrl)),
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
    switch (infoItem.infoItemType) {
      case InfoItem.mapaEscom:
        return const FotosSection();
      case InfoItem.calendario:
        return const CalendarioSection();
      case InfoItem.isc:
        return CarrerasSection(
          carreraItem: carrerasItems.firstWhere((c) => c.id == 0),
        );
      case InfoItem.iia:
        return CarrerasSection(
          carreraItem: carrerasItems.firstWhere((c) => c.id == 1),
        );
      case InfoItem.lcd:
        return CarrerasSection(
          carreraItem: carrerasItems.firstWhere((c) => c.id == 2),
        );
      case InfoItem.redesSociales:
        return const RedesSection();
      case InfoItem.desconocido:
        return Text(
          'El contenido de esta sección no está disponible.',
          style: Theme.of(context).textTheme.bodyLarge,
        );
    }
  }
}
