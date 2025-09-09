import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/services/api_service.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/shared/elastic_list_view/flutter_elastic_list_view.dart';
import 'package:gestion_escom/ui/directory/providers/directorio_provider.dart';
import 'package:gestion_escom/ui/directory/widgets/list_item_directorio.dart';
import 'package:gestion_escom/shared/header_global/header_global.dart';

class DirectorioScreen extends ConsumerWidget {
  const DirectorioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(directorioProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double headerImageSize = screenWidth * 0.45;
    final double headerHeight = (screenWidth * 0.45) + .10;
    return Scaffold(
      body: Stack(
        children: [
          _buildBody(provider, screenWidth, screenHeight, headerHeight),
          HeaderFijo(
            imagePath:
                'https://uteycv.escom.ipn.mx/csi/app-horarios/assets/imagenes/escudo_blanco.png',
            imageHeight: headerImageSize,
            imageWidth: headerImageSize,
          ),
        ],
      ),
    );
  }

  // Widget para construir el cuerpo, manejando los estados de carga y error.
  Widget _buildBody(
    DirectorioProvider provider,
    double screenWidth,
    double screenHeight,
    double headerHeight,
  ) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: headerHeight),
          _buildDirectorioList(provider, screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.03),
        ],
      ),
    );
  }

  Widget _buildDirectorioList(
    DirectorioProvider provider,
    double screenWidth,
    double screenHeight,
  ) {
    final orderedDivisions = Division.values
        .where((div) => provider.directorioData.containsKey(div))
        .toList();

    return ElasticListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      itemCount: orderedDivisions.length,
      itemBuilder: (context, index) {
        final division = orderedDivisions[index];
        final title = provider.divisionTitles[division]!;
        final items = provider.directorioData[division]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.03,
                bottom: screenHeight * 0.01,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            ...items.map(
              (item) => DirectorioListItem(
                directorio: item,
                screenWidth: screenWidth,
              ),
            ),
          ],
        );
      },
    );
  }
}
