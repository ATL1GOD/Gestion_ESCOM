import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/shared/header_global/header_global.dart';
import 'package:gestion_escom/ui/academy/model/academia_model.dart';
import 'package:gestion_escom/shared/elastic_list_view/flutter_elastic_list_view.dart';
import 'package:gestion_escom/ui/docentes/widgets/search_bar.dart';
import 'package:gestion_escom/ui/academy/providers/academia_provider.dart';

class AcademiaListScreen extends ConsumerStatefulWidget {
  const AcademiaListScreen({super.key});

  @override
  ConsumerState<AcademiaListScreen> createState() => _AcademiaListScreenState();
}

class _AcademiaListScreenState extends ConsumerState<AcademiaListScreen> {
  bool startAnimation = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          startAnimation = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final double headerImageSize = screenWidth * 0.38;
    final double headerHeight = headerImageSize + 40;

    // ✨ CAMBIO: Observamos los providers de academias.
    final allAcademiasAsync = ref.watch(academiasProvider);
    final filteredAcademias = ref.watch(filteredAcademiasProvider);

    return Scaffold(
      body: Stack(
        children: [
          AcademiasBody(
            allAcademiasAsync: allAcademiasAsync,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            searchController: _searchController,
            ref: ref,
            filteredAcademias: filteredAcademias,
            startAnimation: startAnimation,
            headerHeight: headerHeight,
          ),
          HeaderFijo(
            colorini: AppColors.terciary,
            colorfin: AppColors.primary,
            imagePath: 'assets/images/escudo_azul.png',
            imageHeight: headerImageSize,
            imageWidth: headerImageSize,
          ),
        ],
      ),
    );
  }
}

class AcademiasBody extends StatelessWidget {
  const AcademiasBody({
    super.key,
    required this.allAcademiasAsync,
    required this.screenWidth,
    required this.screenHeight,
    required TextEditingController searchController,
    required this.ref,
    required this.filteredAcademias,
    required this.startAnimation,
    required this.headerHeight,
  }) : _searchController = searchController;

  // ✨ CAMBIO: Tipos de datos actualizados para academias.
  final AsyncValue<List<AcademiaModel>> allAcademiasAsync;
  final List<AcademiaModel> filteredAcademias;
  final double screenWidth;
  final double screenHeight;
  final TextEditingController _searchController;
  final WidgetRef ref;
  final bool startAnimation;
  final double headerHeight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: allAcademiasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (academias) => SingleChildScrollView(
          // ✨ CAMBIO: 'docentes' a 'academias'
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
          child: Column(
            children: [
              SizedBox(height: headerHeight),
              const Text(
                "Academias",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomSearchBar(
                controller: _searchController,
                onChanged: (value) {
                  ref.read(academiaSearchQueryProvider.notifier).state = value;
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              ElasticListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: filteredAcademias.length, // Usamos la lista filtrada
                itemBuilder: (context, index) {
                  return AcademiaListItemWidget(
                    academia: filteredAcademias[index],
                    index: index,
                    startAnimation: startAnimation,
                    screenWidth: screenWidth,
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}

// 🎨 NUEVO WIDGET: Creado para mostrar la información de una academia.
class AcademiaListItemWidget extends StatelessWidget {
  const AcademiaListItemWidget({
    super.key,
    required this.academia,
    required this.index,
    required this.startAnimation,
    required this.screenWidth,
  });

  final AcademiaModel academia;
  final int index;
  final bool startAnimation;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 150)),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(
        startAnimation ? 0 : screenWidth,
        0,
        0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                academia.nombre,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Presidente: ${academia.presidente}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
