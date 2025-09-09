import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/shared/header_global/header_global.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';
import 'package:gestion_escom/ui/docentes/widgets/list_item.dart';
import 'package:gestion_escom/shared/elastic_list_view/flutter_elastic_list_view.dart';
import 'package:gestion_escom/ui/docentes/providers/docente_provider.dart';
import 'package:gestion_escom/ui/docentes/widgets/search_bar.dart';

class DocenteListScreen extends ConsumerStatefulWidget {
  const DocenteListScreen({super.key});

  @override
  ConsumerState<DocenteListScreen> createState() => _DocenteListScreenState();
}

class _DocenteListScreenState extends ConsumerState<DocenteListScreen> {
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
    // Observamos el FutureProvider para saber el estado de la carga inicial.
    final allDocentesAsync = ref.watch(allDocentesProvider);
    final filteredDocentes = ref.watch(filteredDocentesProvider);

    return Scaffold(
      body: Stack(
        children: [
          DocentesBody(
            allDocentesAsync: allDocentesAsync,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            searchController: _searchController,
            ref: ref,
            filteredDocentes: filteredDocentes,
            startAnimation: startAnimation,
            headerHeight: headerHeight,
          ),
          HeaderFijo(
            colorini: AppColors.terciary,
            colorfin: AppColors.primary,
            imagePath:
                'https://uteycv.escom.ipn.mx/csi/app-horarios/assets/imagenes/escudo_azul.png',
            imageHeight: headerImageSize,
            imageWidth: headerImageSize,
          ),
        ],
      ),
    );
  }
}

class DocentesBody extends StatelessWidget {
  const DocentesBody({
    super.key,
    required this.allDocentesAsync,
    required this.screenWidth,
    required this.screenHeight,
    required TextEditingController searchController,
    required this.ref,
    required this.filteredDocentes,
    required this.startAnimation,
    required this.headerHeight,
  }) : _searchController = searchController;

  final AsyncValue<List<DocenteModel>> allDocentesAsync;
  final double screenWidth;
  final double screenHeight;
  final TextEditingController _searchController;
  final WidgetRef ref;
  final List<DocenteModel> filteredDocentes;
  final bool startAnimation;
  final double headerHeight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Usamos .when para reaccionar a los estados de carga, error y datos.
      child: allDocentesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (docentes) => SingleChildScrollView(
          // La data aquí es la lista completa
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
          child: Column(
            children: [
              SizedBox(height: headerHeight),
              CustomSearchBar(
                controller: _searchController,
                onChanged: (value) {
                  // Al cambiar el texto, solo actualizamos el estado del provider de búsqueda.
                  ref.read(docenteSearchQueryProvider.notifier).state = value;
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              ElasticListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount:
                    filteredDocentes.length, // Usamos la lista ya filtrada
                itemBuilder: (context, index) {
                  return DocenteListItemWidget(
                    docente: filteredDocentes[index],
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
