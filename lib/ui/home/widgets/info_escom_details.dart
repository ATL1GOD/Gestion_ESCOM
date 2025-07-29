import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/home/model/home_model.dart';

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
