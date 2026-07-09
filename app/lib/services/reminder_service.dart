import 'dart:async';

class ReminderService {
  Timer? _timer;

  void start({
    required Duration interval,
    required VoidCallback onReminder,
  }) {
    stop();

    _timer = Timer.periodic(interval, (_) {
      onReminder();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  bool get isRunning => _timer != null;
}

typedef VoidCallback = void Function();