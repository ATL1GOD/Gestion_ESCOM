// info_carousel_dots_indicator.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class InfoCarouselDotsIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  // Use the correct controller type here as well
  final CarouselSliderController controller;

  const InfoCarouselDotsIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return GestureDetector(
          onTap: () {
            // The method is now correctly defined for the controller type
            controller.animateToPage(index);
          },
          child: Container(
            width: currentIndex == index ? 25.0 : 12.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
              borderRadius: currentIndex == index
                  ? BorderRadius.circular(8.0)
                  : null,
              shape: currentIndex == index
                  ? BoxShape.rectangle
                  : BoxShape.circle,
              color: currentIndex == index
                  ? AppColors.secondary
                  : Colors.grey.withAlpha(77),
            ),
          ),
        );
      }).toList(),
    );
  }
}
