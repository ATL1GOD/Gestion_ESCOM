import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class InfoEscom extends StatelessWidget {
  const InfoEscom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Center(
        child: Column(
          children: [
            Text(
              "Escuela Superior de Cómputo",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "La Escuela Superior de Cómputo (ESCOM) es una institución pública mexicana de educación superior perteneciente al Instituto Politécnico Nacional que inició sus actividades académicas en 1993.",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 15,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
