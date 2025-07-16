import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/ui/onboarding/provider/onboarding_provider.dart';
import 'package:gestion_escom/ui/onboarding/screen/onboarding_screen.dart';
import 'package:gestion_escom/ui/auth/screen/login_screen.dart';

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
            loading: () => const LoginScreen(),
            error: (_, _) => const LoginScreen(),
          );
        },
      ),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
    ],
  );
});
