import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/services/api_service.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/directory/providers/directorio_provider.dart';
import 'package:gestion_escom/ui/directory/widgets/list_item_directorio.dart';

class DirectorioScreen extends ConsumerWidget {
  const DirectorioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(directorioProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text(
                  "Directorio",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                floating: true,
                pinned: true,
                elevation: 0,
              ),
            ];
          },
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.error != null
              ? Center(child: Text(provider.error!))
              : _buildDirectorioList(provider, screenWidth),
        ),
      ),
    );
  }

  Widget _buildDirectorioList(DirectorioProvider provider, double screenWidth) {
    // Ordenamos las divisiones según el enum para un orden consistente
    final orderedDivisions = Division.values
        .where((div) => provider.directorioData.containsKey(div))
        .toList();

    return ListView.builder(
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
