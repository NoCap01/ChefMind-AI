enum SkillLevel {
  novice,
  beginner,
  intermediate,
  advanced,
  professional;

  String get displayName {
    switch (this) {
      case SkillLevel.novice:
        return 'Novice';
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
      case SkillLevel.professional:
        return 'Professional';
    }
  }

  String get description {
    switch (this) {
      case SkillLevel.novice:
        return 'Just starting out in the kitchen';
      case SkillLevel.beginner:
        return 'Know basic cooking techniques';
      case SkillLevel.intermediate:
        return 'Comfortable with most recipes';
      case SkillLevel.advanced:
        return 'Experienced home cook';
      case SkillLevel.professional:
        return 'Professional or culinary training';
    }
  }

  List<String> get recommendedEquipment {
    switch (this) {
      case SkillLevel.novice:
        return ['Basic pots and pans', 'Sharp knife', 'Cutting board'];
      case SkillLevel.beginner:
        return ['Basic pots and pans', 'Sharp knife', 'Cutting board', 'Measuring cups'];
      case SkillLevel.intermediate:
        return ['Various pans', 'Good knives', 'Thermometer', 'Mixer', 'Blender'];
      case SkillLevel.advanced:
        return ['Professional cookware', 'Specialty knives', 'Advanced equipment'];
      case SkillLevel.professional:
        return ['Commercial-grade equipment', 'Specialized tools'];
    }
  }
}
