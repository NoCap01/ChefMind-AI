class CookingStep {
  final int stepNumber;
  final String instruction;
  final Duration? duration;
  final String? temperature;
  final List<String>? tips;
  final String? imageUrl;
  final bool isOptional;

  const CookingStep({
    required this.stepNumber,
    required this.instruction,
    this.duration,
    this.temperature,
    this.tips,
    this.imageUrl,
    this.isOptional = false,
  });

  CookingStep copyWith({
    int? stepNumber,
    String? instruction,
    Duration? duration,
    String? temperature,
    List<String>? tips,
    String? imageUrl,
    bool? isOptional,
  }) {
    return CookingStep(
      stepNumber: stepNumber ?? this.stepNumber,
      instruction: instruction ?? this.instruction,
      duration: duration ?? this.duration,
      temperature: temperature ?? this.temperature,
      tips: tips ?? this.tips,
      imageUrl: imageUrl ?? this.imageUrl,
      isOptional: isOptional ?? this.isOptional,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'instruction': instruction,
      'duration': duration?.inMinutes,
      'temperature': temperature,
      'tips': tips,
      'imageUrl': imageUrl,
      'isOptional': isOptional,
    };
  }

  factory CookingStep.fromJson(Map<String, dynamic> json) {
    return CookingStep(
      stepNumber: json['stepNumber'] ?? 0,
      instruction: json['instruction'] ?? '',
      duration:
          json['duration'] != null ? Duration(minutes: json['duration']) : null,
      temperature: json['temperature'],
      tips: json['tips'] != null ? List<String>.from(json['tips']) : null,
      imageUrl: json['imageUrl'],
      isOptional: json['isOptional'] ?? false,
    );
  }
}
