import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/shared/navbar.dart';
import 'package:gestion_escom/ui/docentes/widgets/list_item.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/shared/elastic_list_view/flutter_elastic_list_view.dart';
import 'package:gestion_escom/ui/docentes/providers/docente_provider.dart';
import 'package:gestion_escom/ui/docentes/widgets/search_bar.dart';

// Proveedor de docentes
final docenteProvider = ChangeNotifierProvider((ref) => DocenteProvider());

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
    // Carga los datos desde el proveedor de docentes
    ref.read(docenteProvider.notifier).cargarDocentes();

    _searchController.addListener(() {
      // Llamar al método de filtrado cuando el texto cambie
      ref
          .read(docenteProvider.notifier)
          .filtrarDocentes(_searchController.text);
    });

    // Inicia la animación después del primer frame
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

    // Obtenemos la instancia del provider. La variable ahora se llama 'docenteProviderState' para mayor claridad.
    final docenteProviderState = ref.watch(docenteProvider);

    return Scaffold(
      bottomNavigationBar: const NavBar(),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  ref.read(docenteProvider.notifier).filtrarDocentes(value);
                },
              ),

              const SizedBox(height: 30),
              // Usamos la lista de docentes del provider
              ElasticListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: docenteProviderState.docentes.length,
                itemBuilder: (context, index) {
                  return DocenteListItemWidget(
                    docente: docenteProviderState.docentes[index],
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
    );
  }
}
