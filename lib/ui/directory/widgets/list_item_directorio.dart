import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/directory/model/directorio_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectorioListItem extends StatelessWidget {
  final DirectorioModel directorio;
  final double screenWidth;

  const DirectorioListItem({
    super.key,
    required this.directorio,
    required this.screenWidth,
  });

  // En list_item_directorio.dart

  Future<void> _sendEmail() async {
    // Crear el URI específico para Gmail.
    // El formato es googlegmail:///co?to=[correo]&subject=[asunto]&body=[cuerpo]
    final Uri gmailUri = Uri.parse(
      'googlegmail:///co?to=${directorio.correo}&subject=Contacto%20desde%20App&body=Hola,%20',
    );

    // Crear el URI genérico como alternativa (fallback).
    final Uri mailtoUri = Uri(
      scheme: 'mailto',
      path: directorio.correo,
      queryParameters: {'subject': 'Contacto desde App', 'body': 'Hola, '},
    );

    // Intentar abrir Gmail primero.
    if (await canLaunchUrl(gmailUri)) {
      await launchUrl(gmailUri);
    }
    // Si no se puede (porque no está instalado), usar el método genérico.
    else if (await canLaunchUrl(mailtoUri)) {
      await launchUrl(mailtoUri);
    } else {
      // Manejar el caso en que no hay ninguna app de correo.
      throw 'No se pudo abrir ${directorio.correo}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior:
          Clip.antiAlias, // Para que el ExpansionTile respete los bordes
      child: ExpansionTile(
        leading: const Icon(
          Icons.person_pin_rounded,
          color: AppColors.secondary,
          size: 32,
        ),
        title: Text(
          directorio.funcionario,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          directorio.puesto,
          style: TextStyle(color: AppColors.textPrimary.withAlpha(179)),
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            icon: Icons.location_on,
            label: 'Ubicación',
            value: directorio.ubicacion,
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            icon: Icons.phone_in_talk,
            label: 'Extensión',
            value: directorio.ext,
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: _sendEmail,
            child: _buildInfoRow(
              icon: Icons.email,
              label: 'Correo',
              value: directorio.correo,
              isLink: true, // Estilo especial para el correo
            ),
          ),
          if (directorio.funciones.isNotEmpty) ...[
            const Divider(height: 24),
            Text(
              'Funciones Principales',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              directorio.funciones,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textPrimary.withAlpha(204),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLink = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: AppColors.textPrimary.withAlpha(230),
                fontSize: 13,
                fontFamily: 'Roboto',
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: isLink ? Colors.blue : null,
                    decoration: isLink ? TextDecoration.underline : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
