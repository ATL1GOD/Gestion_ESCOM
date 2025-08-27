import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/home/widgets/carousel_slide.dart';
import 'package:gestion_escom/shared/header_global/header_global.dart';
import 'package:gestion_escom/ui/home/widgets/info_escom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final double headerHeight = (screenWidth * 0.45) + 20;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: headerHeight),
                const InfoCarousel(),
                SizedBox(height: screenHeight * 0.015),
                const InfoEscom(),
                SizedBox(height: screenHeight * 0.015),
                const EscomDetails(),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),

          HeaderFijo(
            imagePath: 'assets/images/escudo_blanco.png',
            imageHeight: screenWidth * 0.45,
            imageWidth: screenWidth * 0.45,
          ),
        ],
      ),
    );
  }
}
