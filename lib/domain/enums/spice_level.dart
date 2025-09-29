enum SpiceLevel {
  none,
  mild,
  medium,
  hot,
  extraHot;

  String get displayName {
    switch (this) {
      case SpiceLevel.none:
        return 'No Spice';
      case SpiceLevel.mild:
        return 'Mild';
      case SpiceLevel.medium:
        return 'Medium';
      case SpiceLevel.hot:
        return 'Hot';
      case SpiceLevel.extraHot:
        return 'Extra Hot';
    }
  }

  String get description {
    switch (this) {
      case SpiceLevel.none:
        return 'No heat at all';
      case SpiceLevel.mild:
        return 'Just a hint of warmth';
      case SpiceLevel.medium:
        return 'Noticeable heat but comfortable';
      case SpiceLevel.hot:
        return 'Definitely spicy, for heat lovers';
      case SpiceLevel.extraHot:
        return 'Extremely spicy, proceed with caution';
    }
  }

  int get scaleValue {
    switch (this) {
      case SpiceLevel.none:
        return 0;
      case SpiceLevel.mild:
        return 1;
      case SpiceLevel.medium:
        return 2;
      case SpiceLevel.hot:
        return 3;
      case SpiceLevel.extraHot:
        return 4;
    }
  }
}