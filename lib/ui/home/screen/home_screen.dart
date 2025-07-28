import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/carousel/widgets/carousel_slide.dart';
import 'package:gestion_escom/ui/home/widgets/croquis_page.dart';
import 'package:gestion_escom/shared/header_global/header_global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Stack(children: [BodyContent(), HeaderFijo()]));
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
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(25),
            //     child: Text(
            //       " ESCOM",
            //       style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            //         color: const Color.fromARGB(255, 3, 102, 184),
            //         fontWeight: FontWeight.w800,
            //       ),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // ),
            const InfoCarousel(),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
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
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8), // Pequeño espacio
                    Text(
                      "La Escuela Superior de Cómputo (ESCOM) es una institución pública mexicana de educación superior perteneciente al Instituto Politécnico Nacional que inició sus actividades académicas en 1993.",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.5, // Mejora la legibilidad
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CroquisScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 3, 102, 184),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      icon: const Icon(Icons.school),
                      label: const Text(
                        "Explorar ESCOM",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
