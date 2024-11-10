import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  final countdownDuration = 600.obs; // 10 minutes in seconds
  Timer? _timer;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    _timer ??= Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdownDuration.value <= 0) {
        _timer?.cancel();
      } else {
        countdownDuration.value -= 1;
      }
    });
  }

  String get formattedDuration {
    int minutes = countdownDuration.value ~/ 60;
    int seconds = countdownDuration.value % 60;
    return "${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
