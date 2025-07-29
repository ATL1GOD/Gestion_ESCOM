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

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [];
              },
              body: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.error != null
                  ? Center(child: Text(provider.error!))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 120),
                          _buildDirectorioList(provider, screenWidth),
                        ],
                      ),
                    ),
            ),
          ),
          const HeaderFijo(
            imagePath: 'assets/images/escudo_ESCOM_blanco.png',
            imageHeight: 185,
            imageWidth: 185,
          ),
        ],
      ),
    );
  }

  Widget _buildDirectorioList(DirectorioProvider provider, double screenWidth) {
    // Ordenamos las divisiones según el enum para un orden consistente
    final orderedDivisions = Division.values
        .where((div) => provider.directorioData.containsKey(div))
        .toList();

    return ElasticListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: orderedDivisions.length,
      itemBuilder: (context, index) {
        final division = orderedDivisions[index];
        final title = provider.divisionTitles[division]!;
        final items = provider.directorioData[division]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 8.0, left: 4.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
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
