enum CookingTimePreference {
  quick,      // Under 15 minutes
  moderate,   // 15-45 minutes
  extended,   // 45-90 minutes
  lengthy,    // Over 90 minutes
  noPreference;

  String get displayName {
    switch (this) {
      case CookingTimePreference.quick:
        return 'Quick (Under 15 min)';
      case CookingTimePreference.moderate:
        return 'Moderate (15-45 min)';
      case CookingTimePreference.extended:
        return 'Extended (45-90 min)';
      case CookingTimePreference.lengthy:
        return 'Lengthy (Over 90 min)';
      case CookingTimePreference.noPreference:
        return 'No Preference';
    }
  }

  int get maxMinutes {
    switch (this) {
      case CookingTimePreference.quick:
        return 15;
      case CookingTimePreference.moderate:
        return 45;
      case CookingTimePreference.extended:
        return 90;
      case CookingTimePreference.lengthy:
        return 999;
      case CookingTimePreference.noPreference:
        return 999;
    }
  }

  int get minMinutes {
    switch (this) {
      case CookingTimePreference.quick:
        return 0;
      case CookingTimePreference.moderate:
        return 15;
      case CookingTimePreference.extended:
        return 45;
      case CookingTimePreference.lengthy:
        return 90;
      case CookingTimePreference.noPreference:
        return 0;
    }
  }
}