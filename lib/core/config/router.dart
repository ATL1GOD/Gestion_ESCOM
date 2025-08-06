import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gestion_escom/ui/home/model/home_model.dart';

// Screens
import 'package:gestion_escom/ui/auth/screen/login_screen.dart';
import 'package:gestion_escom/ui/onboarding/screen/onboarding_screen.dart';
import 'package:gestion_escom/ui/home/screen/home_screen.dart';
import 'package:gestion_escom/ui/docentes/screen/docente_screen.dart';
import 'package:gestion_escom/ui/docentes/screen/docente_detail_screen.dart';
import 'package:gestion_escom/ui/directory/screen/directorio_screen.dart';
import 'package:gestion_escom/shared/navigation_navbar/navigation_scaffold.dart';
import 'package:gestion_escom/ui/home/screen/carousel_screen.dart';

// Providers
import 'package:gestion_escom/ui/onboarding/provider/onboarding_provider.dart';
import 'package:gestion_escom/ui/auth/providers/auth_provider.dart';

final _navigatorKeys = {
  'home': GlobalKey<NavigatorState>(debugLabel: 'homeNav'),
  'docentes': GlobalKey<NavigatorState>(debugLabel: 'docentesNav'),
  'directorio': GlobalKey<NavigatorState>(debugLabel: 'directorioNav'),
};

class Routes {
  static const root = '/';
  static const login = '/login';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const carouselDetails = 'carousel-details';
  static const docentes = '/docentes';
  static const docentesDetail = ':numEmpleado';
  static const directorio = '/directorio';
}

final routerProvider = Provider<GoRouter>((ref) {
  final onboardingState = ref.watch(onboardingCompleteProvider);
  final isLoggedIn = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: Routes.root,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final onboardingComplete = onboardingState.value;
      if (onboardingComplete == null) return null;
      if (!onboardingComplete && state.matchedLocation != Routes.onboarding) {
        return Routes.onboarding;
      }
      if (onboardingComplete &&
          !isLoggedIn &&
          state.matchedLocation != Routes.login) {
        return Routes.login;
      }
      if (onboardingComplete &&
          isLoggedIn &&
          state.matchedLocation == Routes.root) {
        return Routes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.root,
        builder: (_, _) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(path: Routes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: Routes.onboarding,
        builder: (_, _) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            ScaffoldWithNavBar(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _navigatorKeys['home'],
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (_, _) => const HomeScreen(),
                routes: [
                  GoRoute(
                    path: Routes.carouselDetails,
                    builder: (context, state) {
                      final infoItem = state.extra as CarouselItem;
                      return CarouselScreen(infoItem: infoItem);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _navigatorKeys['docentes'],
            routes: [
              GoRoute(
                path: Routes.docentes,
                builder: (_, _) => const DocenteListScreen(),
                routes: [
                  GoRoute(
                    path: Routes.docentesDetail,
                    builder: (context, state) {
                      final numEmpleado = state.pathParameters['numEmpleado']!;
                      return DocenteDetailScreen(numEmpleado: numEmpleado);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _navigatorKeys['directorio'],
            routes: [
              GoRoute(
                path: Routes.directorio,
                builder: (_, _) => const DirectorioScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
