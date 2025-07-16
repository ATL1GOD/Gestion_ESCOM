import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:device_preview/device_preview.dart';
import 'package:gestion_escom/ui/onboarding/screen/onboarding_screen.dart';
import 'package:gestion_escom/ui/auth/screen/login_screen.dart';
import 'package:gestion_escom/core/services/onboarding_service.dart';
import 'package:gestion_escom/ui/home/screen/home_screen.dart';

/// Provider que obtiene si ya se completó el onboarding
final onboardingCompleteProvider = FutureProvider<bool>((ref) async {
  return await OnboardingService().isOnboardingComplete();
});

/// GoRouter configurado en base al estado del onboarding
final routerProvider = Provider<GoRouter>((ref) {
  final onboardingAsync = ref.watch(onboardingCompleteProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return onboardingAsync.when(
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
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
  );
});

/// Aplicación principal
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      routerConfig: router,
    );
  }
}
