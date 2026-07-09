class DialogueEntry {
  const DialogueEntry({
    required this.id,
    required this.text,
    required this.category,
    this.weight = 1,
  });

  final String id;
  final String text;
  final String category;
  final int weight;
}
