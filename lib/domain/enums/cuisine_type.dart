enum CuisineType {
  american,
  italian,
  mexican,
  chinese,
  japanese,
  indian,
  french,
  thai,
  mediterranean,
  middle_eastern,
  korean,
  vietnamese,
  spanish,
  greek,
  british,
  german,
  brazilian,
  moroccan,
  caribbean,
  fusion;

  String get displayName {
    switch (this) {
      case CuisineType.american:
        return 'American';
      case CuisineType.italian:
        return 'Italian';
      case CuisineType.mexican:
        return 'Mexican';
      case CuisineType.chinese:
        return 'Chinese';
      case CuisineType.japanese:
        return 'Japanese';
      case CuisineType.indian:
        return 'Indian';
      case CuisineType.french:
        return 'French';
      case CuisineType.thai:
        return 'Thai';
      case CuisineType.mediterranean:
        return 'Mediterranean';
      case CuisineType.middle_eastern:
        return 'Middle Eastern';
      case CuisineType.korean:
        return 'Korean';
      case CuisineType.vietnamese:
        return 'Vietnamese';
      case CuisineType.spanish:
        return 'Spanish';
      case CuisineType.greek:
        return 'Greek';
      case CuisineType.british:
        return 'British';
      case CuisineType.german:
        return 'German';
      case CuisineType.brazilian:
        return 'Brazilian';
      case CuisineType.moroccan:
        return 'Moroccan';
      case CuisineType.caribbean:
        return 'Caribbean';
      case CuisineType.fusion:
        return 'Fusion';
    }
  }

  String get flag {
    switch (this) {
      case CuisineType.american:
        return '🇺🇸';
      case CuisineType.italian:
        return '🇮🇹';
      case CuisineType.mexican:
        return '🇲🇽';
      case CuisineType.chinese:
        return '🇨🇳';
      case CuisineType.japanese:
        return '🇯🇵';
      case CuisineType.indian:
        return '🇮🇳';
      case CuisineType.french:
        return '🇫🇷';
      case CuisineType.thai:
        return '🇹🇭';
      case CuisineType.mediterranean:
        return '🌊';
      case CuisineType.middle_eastern:
        return '🕌';
      case CuisineType.korean:
        return '🇰🇷';
      case CuisineType.vietnamese:
        return '🇻🇳';
      case CuisineType.spanish:
        return '🇪🇸';
      case CuisineType.greek:
        return '🇬🇷';
      case CuisineType.british:
        return '🇬🇧';
      case CuisineType.german:
        return '🇩🇪';
      case CuisineType.brazilian:
        return '🇧🇷';
      case CuisineType.moroccan:
        return '🇲🇦';
      case CuisineType.caribbean:
        return '🏝️';
      case CuisineType.fusion:
        return '🌍';
    }
  }
}
