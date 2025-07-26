import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/carousel/model/carousel_model.dart';
import 'package:gestion_escom/ui/carousel/widgets/appbar_icon.dart';

class CustomSliverAppBar extends StatelessWidget {
  final CarouselItem infoItem;

  const CustomSliverAppBar({super.key, required this.infoItem});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Estilo para el texto sobre la imagen, con sombra para mejor legibilidad.
    const textStyleOnImage = TextStyle(
      color: Colors.white,
      shadows: [Shadow(blurRadius: 8.0, color: Colors.black54)],
    );

    return SliverAppBar(
      expandedHeight: size.height * 0.4, // Altura expandida del AppBar
      toolbarHeight: 35,
      pinned: true,
      stretch: true,
      elevation: 0,
      backgroundColor:
          AppColors.background, // El fondo lo da el FlexibleSpaceBar
      // Botón para retroceder
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: AppBarIcon(
          icon: Icons.arrow_back_ios_new, //
          onTap: () => Navigator.of(context).pop(),
        ),
      ),

      // Espacio flexible que contiene la imagen y el texto
      flexibleSpace: FlexibleSpaceBar(
        background: _buildFlexibleSpaceBackground(context, textStyleOnImage),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
      ),

      // Curva superior para la sección de contenido
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: SizedBox(
          height: 30,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(36.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget helper para mantener el `build` principal más limpio
  Widget _buildFlexibleSpaceBackground(
    BuildContext context,
    TextStyle textStyle,
  ) {
    final theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen de fondo
        Image.network(infoItem.imgUrl, fit: BoxFit.cover),

        // Degradado oscuro para asegurar que el texto blanco sea legible
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.black54, Colors.transparent],
            ),
          ),
        ),

        // Contenido de texto superpuesto
        Positioned(
          bottom: 50,
          left: 16,
          right: 16, // Añadimos padding derecho para evitar desbordamiento
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Etiqueta de categoría
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  // Usa el color primario del tema
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  infoItem.category,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),

              // Título
              Text(
                infoItem.title,
                style: theme.textTheme.headlineSmall!
                    .merge(textStyle)
                    .copyWith(fontWeight: FontWeight.bold),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),

              // Autor
              Text(
                infoItem.author,
                style: theme.textTheme.bodyMedium!.merge(textStyle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
