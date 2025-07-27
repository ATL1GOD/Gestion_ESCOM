// (Tus imports permanecen igual)
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:gestion_escom/ui/onboarding/provider/onboarding_provider.dart';
import 'package:gestion_escom/ui/onboarding/screen/onboarding_screen.dart';
import 'package:gestion_escom/ui/auth/screen/login_screen.dart';
// Asumiendo que DocenteListScreen y DocenteDetailScreen están en este archivo
import 'package:gestion_escom/ui/docentes/screen/docente_screen.dart';
import 'package:gestion_escom/ui/home/screen/home_screen.dart';
import 'package:gestion_escom/shared/navigation_navbar/navigation_scaffold.dart';
import 'package:gestion_escom/ui/docentes/screen/docente_detail_screen.dart';

final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final routerProvider = Provider<GoRouter>((ref) {
  final onboardingCompleteAsync = ref.watch(onboardingCompleteProvider);
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return onboardingCompleteAsync.when(
            data: (complete) =>
                complete ? const LoginScreen() : const OnboardingScreen(),
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) =>
                Scaffold(body: Center(child: Text('Error: $err'))),
          );
        },
      ),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Rama 0: Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Rama 1: Docentes
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              // Ruta principal de la lista de docentes
              GoRoute(
                path: '/docentes',
                builder: (context, state) => const DocenteListScreen(),
                routes: [
                  // Esta es la sub-ruta para el detalle de un docente específico
                  GoRoute(
                    path: ':numEmpleado', // Acepta un parámetro 'numEmpleado'
                    builder: (context, state) {
                      // Extraemos el parámetro de la URL
                      final numEmpleado = state.pathParameters['numEmpleado']!;
                      // Pasamos el ID a la pantalla de detalle
                      return DocenteDetailScreen(numEmpleado: numEmpleado);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
