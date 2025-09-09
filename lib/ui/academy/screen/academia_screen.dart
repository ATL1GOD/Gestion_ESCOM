import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/shared/header_global/header_global.dart';
import 'package:gestion_escom/ui/academy/model/academia_model.dart';
import 'package:gestion_escom/shared/elastic_list_view/flutter_elastic_list_view.dart';
import 'package:gestion_escom/ui/academy/widgets/search_bar.dart';
import 'package:gestion_escom/ui/academy/providers/academia_provider.dart';
import 'package:gestion_escom/ui/academy/widgets/list_item_academia.dart';

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
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
          child: Column(
            children: [
              SizedBox(height: headerHeight),
              AcademiaSearchBar(
                controller: _searchController,
                onChanged: (value) {
                  ref.read(academiaSearchQueryProvider.notifier).state = value;
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              ElasticListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: filteredAcademias.length,
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
