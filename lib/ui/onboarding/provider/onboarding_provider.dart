import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/services/onboarding_service.dart';

final onboardingCompleteProvider = FutureProvider<bool>((ref) async {
  return await OnboardingService().isOnboardingComplete();
});

class OnboardingNotifier extends StateNotifier<bool> {
  OnboardingNotifier() : super(false);

  Future<void> complete() async {
    await OnboardingService().completeOnboarding();
    state = true;
  }
}

final onboardingStateProvider = StateNotifierProvider<OnboardingNotifier, bool>(
  (ref) {
    return OnboardingNotifier();
  },
);
