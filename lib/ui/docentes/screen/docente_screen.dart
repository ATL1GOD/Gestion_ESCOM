import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/ui/docentes/widgets/list_item.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/shared/elastic_list_view/flutter_elastic_list_view.dart';
import 'package:gestion_escom/ui/docentes/providers/docente_provider.dart';
import 'package:gestion_escom/ui/docentes/widgets/search_bar.dart';

class DocenteListScreen extends ConsumerStatefulWidget {
  const DocenteListScreen({super.key});

  @override
  ConsumerState<DocenteListScreen> createState() => _DocenteListScreenState();
}

class _DocenteListScreenState extends ConsumerState<DocenteListScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  bool startAnimation = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // Observamos el FutureProvider para saber el estado de la carga inicial.
    final allDocentesAsync = ref.watch(allDocentesProvider);
    // Observamos el provider de la lista filtrada para construir la UI.
    final filteredDocentes = ref.watch(filteredDocentesProvider);

    return Scaffold(
      body: SafeArea(
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
                const SizedBox(height: 30),
                const Text(
                  "Docentes",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                CustomSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    // Al cambiar el texto, solo actualizamos el estado del provider de búsqueda.
                    ref.read(docenteSearchQueryProvider.notifier).state = value;
                  },
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
