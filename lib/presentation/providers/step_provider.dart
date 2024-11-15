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
}

final stepProvider = StateNotifierProvider<StepNotifier, int>((ref) {
  return StepNotifier();
});