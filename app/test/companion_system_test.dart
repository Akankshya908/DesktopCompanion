import 'package:app/core/models/companion_mood.dart';
import 'package:app/models/companion_state.dart';
import 'package:app/providers/companion_provider.dart';
import 'package:app/services/dialogue_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('companion provider reacts to reminder prompts with mood and text', () {
    final provider = CompanionProvider();

    provider.showReminderDialogue();

    expect(provider.visible, isTrue);
    expect(provider.message, isNotEmpty);
    expect(provider.currentState, CompanionState.walk);
    expect(provider.mood, CompanionMood.thinking);
  });

  test('dialogue service picks a message from the requested category', () {
    final service = DialogueService();

    final entry = service.pickDialogue('reminder');

    expect(entry.category, 'reminder');
    expect(entry.text, isNotEmpty);
  });
}
