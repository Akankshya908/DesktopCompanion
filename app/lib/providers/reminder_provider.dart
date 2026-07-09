import 'package:flutter/material.dart';
import 'package:app/services/reminder_service.dart' as reminder_service;

class ReminderProvider extends ChangeNotifier {
  ReminderProvider({Duration initialInterval = const Duration(seconds: 10)})
      : _interval = initialInterval;

  final reminder_service.ReminderService _service = reminder_service.ReminderService();

  bool _enabled = false;
  Duration _interval;
  VoidCallback? _onReminder;

  bool get enabled => _enabled;
  Duration get interval => _interval;

  void start({Duration? interval}) {
    _enabled = true;
    if (interval != null) {
      _interval = interval;
    }

    _service.start(
      interval: _interval,
      onReminder: () {
        _onReminder?.call();
      },
    );

    notifyListeners();
  }

  void stop() {
    _enabled = false;
    _service.stop();
    notifyListeners();
  }

  void restart({Duration? interval}) {
    if (interval != null) {
      _interval = interval;
    }
    if (_enabled) {
      _service.start(
        interval: _interval,
        onReminder: () {
          _onReminder?.call();
        },
      );
      notifyListeners();
    }
  }

  void snoozeFor(Duration duration) {
    _interval = duration;
    restart(interval: duration);
  }

  void setReminderCallback(VoidCallback? callback) {
    _onReminder = callback;
  }
}