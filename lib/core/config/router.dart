import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// Importa las pantallas y providers
import 'package:gestion_escom/ui/onboarding/provider/onboarding_provider.dart';
import 'package:gestion_escom/ui/onboarding/screen/onboarding_screen.dart';
import 'package:gestion_escom/ui/auth/screen/login_screen.dart';
import 'package:gestion_escom/ui/docentes/screen/docente_screen.dart';
import 'package:gestion_escom/ui/home/screen/home_screen.dart';
import 'package:gestion_escom/shared/navigation_navbar/navigation_scaffold.dart';

// Se definen llaves globales para los navegadores de cada rama
//final _rootNavigatorKey = GlobalKey<NavigatorState>();
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
          // El builder ahora retorna el widget que contiene el Scaffold y la NavBar.
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Rama 0: Contiene la pantalla de Home.
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Rama 1: Contiene la pantalla de Docentes.
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                path: '/docentes',
                builder: (context, state) => const DocenteListScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
