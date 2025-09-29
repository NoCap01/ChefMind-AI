import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// Kitchen Timer State
class KitchenTimer {
  final String id;
  final String name;
  final Duration duration;
  final Duration remaining;
  final bool isRunning;
  final bool isCompleted;
  final DateTime? startTime;

  const KitchenTimer({
    required this.id,
    required this.name,
    required this.duration,
    required this.remaining,
    this.isRunning = false,
    this.isCompleted = false,
    this.startTime,
  });

  KitchenTimer copyWith({
    String? id,
    String? name,
    Duration? duration,
    Duration? remaining,
    bool? isRunning,
    bool? isCompleted,
    DateTime? startTime,
  }) {
    return KitchenTimer(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      remaining: remaining ?? this.remaining,
      isRunning: isRunning ?? this.isRunning,
      isCompleted: isCompleted ?? this.isCompleted,
      startTime: startTime ?? this.startTime,
    );
  }
}

// Kitchen Timers Provider
final kitchenTimersProvider = StateNotifierProvider<KitchenTimersNotifier, List<KitchenTimer>>((ref) {
  return KitchenTimersNotifier();
});

class KitchenTimersNotifier extends StateNotifier<List<KitchenTimer>> {
  KitchenTimersNotifier() : super([]);

  final Map<String, Timer> _activeTimers = {};

  void addTimer({
    required String name,
    required Duration duration,
  }) {
    final timer = KitchenTimer(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      duration: duration,
      remaining: duration,
    );

    state = [...state, timer];
  }

  void startTimer(String timerId) {
    final timerIndex = state.indexWhere((timer) => timer.id == timerId);
    if (timerIndex == -1) return;

    final timer = state[timerIndex];
    if (timer.isRunning) return;

    final updatedTimer = timer.copyWith(
      isRunning: true,
      startTime: DateTime.now(),
    );

    state = [
      ...state.sublist(0, timerIndex),
      updatedTimer,
      ...state.sublist(timerIndex + 1),
    ];

    _activeTimers[timerId] = Timer.periodic(const Duration(seconds: 1), (periodicTimer) {
      _updateTimer(timerId);
    });
  }

  void pauseTimer(String timerId) {
    _activeTimers[timerId]?.cancel();
    _activeTimers.remove(timerId);

    final timerIndex = state.indexWhere((timer) => timer.id == timerId);
    if (timerIndex == -1) return;

    final timer = state[timerIndex];
    final updatedTimer = timer.copyWith(isRunning: false);

    state = [
      ...state.sublist(0, timerIndex),
      updatedTimer,
      ...state.sublist(timerIndex + 1),
    ];
  }

  void resetTimer(String timerId) {
    _activeTimers[timerId]?.cancel();
    _activeTimers.remove(timerId);

    final timerIndex = state.indexWhere((timer) => timer.id == timerId);
    if (timerIndex == -1) return;

    final timer = state[timerIndex];
    final updatedTimer = timer.copyWith(
      remaining: timer.duration,
      isRunning: false,
      isCompleted: false,
      startTime: null,
    );

    state = [
      ...state.sublist(0, timerIndex),
      updatedTimer,
      ...state.sublist(timerIndex + 1),
    ];
  }

  void deleteTimer(String timerId) {
    _activeTimers[timerId]?.cancel();
    _activeTimers.remove(timerId);

    state = state.where((timer) => timer.id != timerId).toList();
  }

  void _updateTimer(String timerId) {
    final timerIndex = state.indexWhere((timer) => timer.id == timerId);
    if (timerIndex == -1) return;

    final timer = state[timerIndex];
    if (!timer.isRunning) return;

    final newRemaining = timer.remaining - const Duration(seconds: 1);

    if (newRemaining.inSeconds <= 0) {
      _activeTimers[timerId]?.cancel();
      _activeTimers.remove(timerId);

      final completedTimer = timer.copyWith(
        remaining: Duration.zero,
        isRunning: false,
        isCompleted: true,
      );

      state = [
        ...state.sublist(0, timerIndex),
        completedTimer,
        ...state.sublist(timerIndex + 1),
      ];

      // TODO: Show notification or play sound
    } else {
      final updatedTimer = timer.copyWith(remaining: newRemaining);

      state = [
        ...state.sublist(0, timerIndex),
        updatedTimer,
        ...state.sublist(timerIndex + 1),
      ];
    }
  }

  @override
  void dispose() {
    for (final timer in _activeTimers.values) {
      timer.cancel();
    }
    _activeTimers.clear();
    super.dispose();
  }
}

// Unit Conversion Provider
final unitConverterProvider = StateNotifierProvider<UnitConverterNotifier, Map<String, double>>((ref) {
  return UnitConverterNotifier();
});

class UnitConverterNotifier extends StateNotifier<Map<String, double>> {
  UnitConverterNotifier() : super({});

  // Volume conversions (to milliliters)
  static const Map<String, double> _volumeConversions = {
    'ml': 1.0,
    'l': 1000.0,
    'cup': 236.588,
    'tbsp': 14.787,
    'tsp': 4.929,
    'fl oz': 29.574,
    'pint': 473.176,
    'quart': 946.353,
    'gallon': 3785.41,
  };

  // Weight conversions (to grams)
  static const Map<String, double> _weightConversions = {
    'g': 1.0,
    'kg': 1000.0,
    'oz': 28.3495,
    'lb': 453.592,
    'mg': 0.001,
  };

  // Temperature conversion functions
  double convertTemperature(double value, String fromUnit, String toUnit) {
    // Convert to Celsius first
    double celsius;
    switch (fromUnit.toLowerCase()) {
      case 'f':
      case 'fahrenheit':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'k':
      case 'kelvin':
        celsius = value - 273.15;
        break;
      default:
        celsius = value; // Assume Celsius
    }

    // Convert from Celsius to target unit
    switch (toUnit.toLowerCase()) {
      case 'f':
      case 'fahrenheit':
        return celsius * 9 / 5 + 32;
      case 'k':
      case 'kelvin':
        return celsius + 273.15;
      default:
        return celsius; // Return Celsius
    }
  }

  double convertVolume(double value, String fromUnit, String toUnit) {
    final fromFactor = _volumeConversions[fromUnit.toLowerCase()];
    final toFactor = _volumeConversions[toUnit.toLowerCase()];

    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Unsupported volume unit');
    }

    return (value * fromFactor) / toFactor;
  }

  double convertWeight(double value, String fromUnit, String toUnit) {
    final fromFactor = _weightConversions[fromUnit.toLowerCase()];
    final toFactor = _weightConversions[toUnit.toLowerCase()];

    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Unsupported weight unit');
    }

    return (value * fromFactor) / toFactor;
  }

  List<String> getVolumeUnits() => _volumeConversions.keys.toList();

  List<String> getWeightUnits() => _weightConversions.keys.toList();

  List<String> getTemperatureUnits() => ['c', 'f', 'k'];
}

// Cooking Tips Provider
final cookingTipsProvider = StateNotifierProvider<CookingTipsNotifier, List<String>>((ref) {
  return CookingTipsNotifier();
});

class CookingTipsNotifier extends StateNotifier<List<String>> {
  CookingTipsNotifier() : super(_defaultTips);

  static const List<String> _defaultTips = [
    'Always read the entire recipe before starting to cook.',
    'Mise en place - prepare all ingredients before cooking.',
    'Use a food thermometer to check meat doneness.',
    'Season pasta water generously with salt.',
    'Let meat rest after cooking for better juices distribution.',
    'Taste as you go and adjust seasoning accordingly.',
    'Use room temperature eggs for better incorporation in baking.',
    'Don\'t overcrowd the pan when sautéing.',
    'Sharp knives are safer than dull knives.',
    'Store herbs with stems in water like flowers.',
  ];

  void addTip(String tip) {
    if (!state.contains(tip)) {
      state = [...state, tip];
    }
  }

  void removeTip(String tip) {
    state = state.where((t) => t != tip).toList();
  }

  String getRandomTip() {
    if (state.isEmpty) return 'Keep cooking and learning!';
    final random = DateTime.now().millisecondsSinceEpoch % state.length;
    return state[random];
  }

  void resetToDefault() {
    state = _defaultTips;
  }
}

// Kitchen Equipment Tracker
final kitchenEquipmentProvider = StateNotifierProvider<KitchenEquipmentNotifier, List<String>>((ref) {
  return KitchenEquipmentNotifier();
});

class KitchenEquipmentNotifier extends StateNotifier<List<String>> {
  KitchenEquipmentNotifier() : super([]);

  static const List<String> commonEquipment = [
    'Chef\'s Knife',
    'Cutting Board',
    'Measuring Cups',
    'Measuring Spoons',
    'Mixing Bowls',
    'Skillet/Frying Pan',
    'Saucepan',
    'Stockpot',
    'Baking Sheet',
    'Oven',
    'Stovetop',
    'Microwave',
    'Blender',
    'Food Processor',
    'Stand Mixer',
    'Hand Mixer',
    'Whisk',
    'Spatula',
    'Wooden Spoons',
    'Tongs',
    'Can Opener',
    'Colander',
    'Strainer',
    'Grater',
    'Peeler',
    'Thermometer',
    'Timer',
    'Scale',
  ];

  void addEquipment(String equipment) {
    if (!state.contains(equipment)) {
      state = [...state, equipment];
    }
  }

  void removeEquipment(String equipment) {
    state = state.where((e) => e != equipment).toList();
  }

  void setEquipment(List<String> equipment) {
    state = equipment;
  }

  bool hasEquipment(String equipment) {
    return state.contains(equipment);
  }

  List<String> getCommonEquipment() => commonEquipment;
}