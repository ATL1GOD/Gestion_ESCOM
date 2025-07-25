import 'package:flutter/material.dart';
import 'package:gestion_escom/shared/navbar.dart';
import 'package:gestion_escom/ui/carousel/widgets/carousel_slide.dart';
//info_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 65),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    " ESCOM",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: const Color.fromARGB(255, 3, 102, 184),
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const InfoCarousel(),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  bottom: 0,
                ), //boottom es para
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Escuela Superior de Cómputo",
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(
                              color: const Color.fromARGB(255, 2, 82, 148),
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                        textAlign: TextAlign.center, // Tamaño de la fuente
                      ),
                      Text(
                        "La Escuela Superior de Cómputo (ESCOM) es una institución pública mexicana de educación superior perteneciente al Instituto Politécnico Nacional que inició sus actividades académicas en 1993.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify, // Tamaño de la fuente
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
