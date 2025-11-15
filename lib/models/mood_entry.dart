class MoodEntry {
  final String mood;
  final String note;
  final String iconPath;
  final DateTime createdAt;

  MoodEntry({
    required this.mood,
    required this.note,
    required this.iconPath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
