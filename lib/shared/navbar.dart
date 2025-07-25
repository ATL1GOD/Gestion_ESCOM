import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:go_router/go_router.dart';

final navIndexProvider = StateProvider<int>((ref) => 0);

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentIndex = ref.watch(navIndexProvider);

    final List<String> routes = ['/home', '/docentes'];

    return CurvedNavigationBar(
      index: currentIndex,
      height: 65.0,
      items: <Widget>[
        Icon(Icons.home, size: 30, color: AppColors.background),
        Icon(Icons.school, size: 30, color: AppColors.background),
      ],
      color: AppColors.textPrimary,
      buttonBackgroundColor: AppColors.textSecondary,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeOutCubic,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        if (currentIndex != index) {
          ref.read(navIndexProvider.notifier).state = index;
          context.go(routes[index]);
        }
      },
      letIndexChange: (index) => true,
    );
  }
}
