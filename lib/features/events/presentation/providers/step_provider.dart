import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepNotifier extends StateNotifier<int> {
  StepNotifier() : super(0);

  void nextStep() {
    if (state < 3) state++;
  }

  void previousStep() {
    if (state > 0) state--;
  }

  void goToStep(int step) {
    state = step;
  }
  
  void reset() {
    state = 0; // Reinicia al primer paso
  }
}

final stepProvider = StateNotifierProvider<StepNotifier, int>((ref) {
  return StepNotifier();
});