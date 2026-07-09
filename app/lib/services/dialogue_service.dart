import '../models/dialogue_entry.dart';

class DialogueService {
  DialogueService();

  static final List<DialogueEntry> _entries = [
    DialogueEntry(id: 'morning_1', text: 'Good morning! A fresh glass of water is a great start.', category: 'morning', weight: 2),
    DialogueEntry(id: 'morning_2', text: 'Morning mode: one sip at a time.', category: 'morning', weight: 1),
    DialogueEntry(id: 'afternoon_1', text: 'You are doing great. Another sip would be lovely.', category: 'afternoon', weight: 2),
    DialogueEntry(id: 'afternoon_2', text: 'A little hydration goes a long way.', category: 'afternoon', weight: 1),
    DialogueEntry(id: 'night_1', text: 'A final sip before bed can feel so good.', category: 'night', weight: 2),
    DialogueEntry(id: 'night_2', text: 'Your body will thank you for a gentle refill.', category: 'night', weight: 1),
    DialogueEntry(id: 'reminder_1', text: 'Time for a quick water break.', category: 'reminder', weight: 2),
    DialogueEntry(id: 'reminder_2', text: 'Your companion is cheering for your next glass.', category: 'reminder', weight: 1),
    DialogueEntry(id: 'goal_1', text: 'Goal reached! You earned a happy little celebration.', category: 'goal', weight: 2),
    DialogueEntry(id: 'goal_2', text: 'That is a fantastic streak. Keep it up!', category: 'goal', weight: 1),
    DialogueEntry(id: 'idle_1', text: 'I am here whenever you need a tiny nudge.', category: 'idle', weight: 2),
    DialogueEntry(id: 'idle_2', text: 'Just a little sip and we are moving again.', category: 'idle', weight: 1),
  ];

  DialogueEntry pickDialogue(String category, {String? excludeId}) {
    final matches = _entries.where((entry) => entry.category == category).toList();
    if (matches.isEmpty) {
      return DialogueEntry(id: 'fallback', text: 'Keep going!', category: category);
    }

    final filtered = excludeId == null
        ? matches
        : matches.where((entry) => entry.id != excludeId).toList();

    final pool = filtered.isEmpty ? matches : filtered;
    final totalWeight = pool.fold<int>(0, (sum, entry) => sum + entry.weight);
    final roll = DateTime.now().millisecondsSinceEpoch % totalWeight;

    var running = 0;
    for (final entry in pool) {
      running += entry.weight;
      if (roll < running) {
        return entry;
      }
    }

    return pool.first;
  }
}
