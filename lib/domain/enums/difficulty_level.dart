enum DifficultyLevel {
  beginner,
  easy,
  medium,
  hard,
  expert;

  String get displayName {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'Beginner';
      case DifficultyLevel.easy:
        return 'Easy';
      case DifficultyLevel.medium:
        return 'Medium';
      case DifficultyLevel.hard:
        return 'Hard';
      case DifficultyLevel.expert:
        return 'Expert';
    }
  }

  String get description {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'Perfect for first-time cooks';
      case DifficultyLevel.easy:
        return 'Simple techniques and common ingredients';
      case DifficultyLevel.medium:
        return 'Some cooking experience helpful';
      case DifficultyLevel.hard:
        return 'Advanced techniques required';
      case DifficultyLevel.expert:
        return 'Professional-level complexity';
    }
  }

  /// Estimated time multiplier based on difficulty
  double get timeMultiplier {
    switch (this) {
      case DifficultyLevel.beginner:
        return 1.5;
      case DifficultyLevel.easy:
        return 1.2;
      case DifficultyLevel.medium:
        return 1.0;
      case DifficultyLevel.hard:
        return 0.8;
      case DifficultyLevel.expert:
        return 0.6;
    }
  }
}