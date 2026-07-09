import 'dart:async';
import 'package:flutter/material.dart';

import '../core/models/companion_mood.dart';
import '../models/companion_state.dart';
import '../services/dialogue_service.dart';

class CompanionProvider extends ChangeNotifier {
  CompanionProvider({DialogueService? dialogueService})
      : _dialogueService = dialogueService ?? DialogueService();

  final DialogueService _dialogueService;
  bool _visible = false;
  String _message = '';
  CompanionState _currentState = CompanionState.idle;
  CompanionMood _mood = CompanionMood.idle;
  Timer? _hideTimer;
  String? _lastDialogueId;

  bool get visible => _visible;
  String get message => _message;
  CompanionState get currentState => _currentState;
  CompanionMood get mood => _mood;

  void showMessage(
    String text, {
    CompanionState? state,
    CompanionMood? mood,
    bool autoHide = true,
  }) {
    _message = text;
    _visible = true;
    if (state != null) {
      _currentState = state;
    }
    if (mood != null) {
      _mood = mood;
    }
    notifyListeners();

    if (autoHide) {
      _startHideTimer();
    }
  }

  void setState(CompanionState state) {
    _currentState = state;
    notifyListeners();
  }

  void setMood(CompanionMood mood) {
    _mood = mood;
    notifyListeners();
  }

  void hide() {
    _hideTimer?.cancel();
    _visible = false;
    notifyListeners();
  }

  void showReminderDialogue({String category = 'reminder'}) {
    final dialogue = _dialogueService.pickDialogue(category, excludeId: _lastDialogueId);
    _lastDialogueId = dialogue.id;
    setState(CompanionState.walk);
    setMood(CompanionMood.thinking);
    showMessage(
      dialogue.text,
      state: CompanionState.walk,
      mood: CompanionMood.thinking,
    );
  }

  void showCelebration() {
    setState(CompanionState.celebrate);
    setMood(CompanionMood.celebrating);
    showMessage(
      'Awesome work!',
      state: CompanionState.celebrate,
      mood: CompanionMood.celebrating,
    );
  }

  void showDrinkReminder() {
    setState(CompanionState.walk);
    setMood(CompanionMood.thinking);
    showMessage(
      '💧 Time to drink some water!',
      state: CompanionState.walk,
      mood: CompanionMood.thinking,
    );
  }

  void showSleep() {
    setState(CompanionState.sleep);
    setMood(CompanionMood.sleepy);
    showMessage(
      'Time to rest.',
      state: CompanionState.sleep,
      mood: CompanionMood.sleepy,
    );
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), hide);
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }
}