import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/academy/model/academia_model.dart';
import 'package:gestion_escom/ui/academy/providers/academia_provider.dart';

class AcademiaListItemWidget extends ConsumerWidget {
  const AcademiaListItemWidget({
    super.key,
    required this.academia,
    required this.index,
    required this.startAnimation,
    required this.screenWidth,
  });

  final AcademiaModel academia;
  final int index;
  final bool startAnimation;
  final double screenWidth;

  RichText _buildHighlightedText(String text, String query) {
    final textStyle = const TextStyle(color: Colors.black87, fontSize: 14);
    final highlightStyle = textStyle.copyWith(
      fontWeight: FontWeight.bold,
      backgroundColor: AppColors.primary.withAlpha(50),
    );

    if (query.isEmpty) {
      return RichText(
        text: TextSpan(text: text, style: textStyle),
      );
    }

    final List<TextSpan> spans = [];
    final String textLower = text.toLowerCase();
    final String queryLower = query.toLowerCase();
    int start = 0;
    int indexOfQuery;

    while ((indexOfQuery = textLower.indexOf(queryLower, start)) != -1) {
      if (indexOfQuery > start) {
        spans.add(TextSpan(text: text.substring(start, indexOfQuery)));
      }
      spans.add(
        TextSpan(
          text: text.substring(indexOfQuery, indexOfQuery + query.length),
          style: highlightStyle,
        ),
      );
      start = indexOfQuery + query.length;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      text: TextSpan(style: textStyle, children: spans),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(academiaSearchQueryProvider);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 150)),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(
        startAnimation ? 0 : screenWidth,
        0,
        0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                academia.nombre,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Presidente: ${academia.presidente}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
          children: academia.materias.map((materia) {
            return ListTile(
              title: _buildHighlightedText(materia, searchQuery),
              contentPadding: const EdgeInsets.only(
                left: 32.0,
                right: 16.0,
                bottom: 4.0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
