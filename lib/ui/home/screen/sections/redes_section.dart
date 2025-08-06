import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RedesSection extends StatelessWidget {
  const RedesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Síguenos en nuestras redes sociales para mantenerte informado de las últimas noticias y eventos de la ESCOM:',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16.0),

        Column(
          children: [
            _buildRedSocialItem(
              context,
              icon: FontAwesomeIcons.facebook,
              color: const Color(0xFF1877F2),
              name: 'Escuela Superior de Cómputo IPN',
              url: 'https://www.facebook.com/escomipnmx/',
            ),
            _buildRedSocialItem(
              context,
              icon: FontAwesomeIcons.instagram,
              color: Colors.black,
              name: 'escom_ipn_mx',
              url: 'https://www.instagram.com/escom_ipn_mx',
            ),
            _buildRedSocialItem(
              context,
              icon: FontAwesomeIcons.xTwitter,
              color: Colors.black,
              name: 'ESCOM IPN MX',
              url: 'https://x.com/escomunidad/',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRedSocialItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String name,
    required String url,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No se pudo abrir el enlace: $url')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              FaIcon(icon, color: color, size: 32.0),
              const SizedBox(width: 16.0),
              Text(name, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
