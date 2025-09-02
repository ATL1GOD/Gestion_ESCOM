import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const NavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex, // Recibe el índice actual como parámetro.
      height: 65.0,
      items: <Widget>[
        Icon(Icons.home, size: 30, color: AppColors.background),
        Icon(Icons.school, size: 30, color: AppColors.background),
        Icon(Icons.menu_book, size: 30, color: AppColors.background),
        Icon(
          Icons.collections_bookmark_sharp,
          size: 30,
          color: AppColors.background,
        ),
      ],
      color: AppColors.textPrimary,
      buttonBackgroundColor: AppColors.textSecondary,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeOutCubic,
      animationDuration: Duration(milliseconds: 600),
      onTap: onTap, // Llama a la función onTap al presionar un ícono.
      letIndexChange: (index) => true, // Permite el cambio de índice.
    );
  }
}
