import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/home/model/home_model.dart';

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

class EscomDetails extends StatelessWidget {
  const EscomDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: EscomDetailListModel.details.map((detail) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionTile(
              leading: Icon(detail.icon, color: AppColors.secondary, size: 32),
              title: Text(
                detail.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        detail.content,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      if (detail.image != null)
                        Image(
                          image: detail.image!.image,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
