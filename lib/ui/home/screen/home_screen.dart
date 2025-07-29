import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/carousel/widgets/carousel_slide.dart';
import 'package:gestion_escom/shared/header_global/header_global.dart';
import 'package:gestion_escom/ui/home/widgets/info_escom.dart';
import 'package:gestion_escom/ui/home/widgets/info_escom_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          BodyContent(),
          HeaderFijo(
            imagePath: 'assets/images/escudo_ESCOM_blanco.png',
            imageHeight: 185,
            imageWidth: 185,
          ),
        ],
      ),
    );
  }
}

// Se extrajo el contenido principal a un widget separado para mayor claridad
class BodyContent extends StatelessWidget {
  const BodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 150),
            const InfoCarousel(),
            const SizedBox(height: 20),
            const InfoEscom(),
            const SizedBox(height: 10),
            const EscomDetails(),
          ],
        ),
      ),
    );
  }
}
