import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/home/model/home_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CroquisScreen extends StatelessWidget {
  const CroquisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Scaffold(
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.vertical,
        children: const [RandomCardSection(), InfoSection()],
      ),
    );
  }
}

class RandomCardSection extends StatelessWidget {
  const RandomCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final cards = CardListModel.cards;
    final card = cards[random.nextInt(cards.length)];

    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen de fondo
        Image.asset(card.assetPath, fit: BoxFit.cover),

        // Gradiente para mejorar contraste
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withAlpha(129), Colors.transparent],
            ),
          ),
        ),

        // Texto centrado
        Center(
          child: Text(
            '',
            textAlign: TextAlign.center,
            style: GoogleFonts.blackOpsOne(
              fontSize: 45.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
        ),

        // Flecha abajo animada
        const Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 40,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2C1E1E),
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Text(
          'Aquí comienza tu recorrido por ESCOM.\n\nDesliza hacia abajo para explorar más.',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 20,
            color: Colors.white,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
