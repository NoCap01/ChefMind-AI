class CookingSession {
  final String id;
  final String userId;
  final String recipeId;
  final String recipeName;
  final DateTime startTime;
  final DateTime? endTime;
  final List<SessionStep> completedSteps;
  final List<SessionNote> notes;
  final List<String> photos;
  final double? finalRating;
  final String? review;
  final Duration? actualCookTime;
  final bool isSuccessful;
  final List<String>? modifications;
  final List<String>? challenges;

  const CookingSession({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.recipeName,
    required this.startTime,
    this.endTime,
    this.completedSteps = const [],
    this.notes = const [],
    this.photos = const [],
    this.finalRating,
    this.review,
    this.actualCookTime,
    this.isSuccessful = false,
    this.modifications,
    this.challenges,
  });

  CookingSession copyWith({
    String? id,
    String? userId,
    String? recipeId,
    String? recipeName,
    DateTime? startTime,
    DateTime? endTime,
    List<SessionStep>? completedSteps,
    List<SessionNote>? notes,
    List<String>? photos,
    double? finalRating,
    String? review,
    Duration? actualCookTime,
    bool? isSuccessful,
    List<String>? modifications,
    List<String>? challenges,
  }) {
    return CookingSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      recipeId: recipeId ?? this.recipeId,
      recipeName: recipeName ?? this.recipeName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      completedSteps: completedSteps ?? this.completedSteps,
      notes: notes ?? this.notes,
      photos: photos ?? this.photos,
      finalRating: finalRating ?? this.finalRating,
      review: review ?? this.review,
      actualCookTime: actualCookTime ?? this.actualCookTime,
      isSuccessful: isSuccessful ?? this.isSuccessful,
      modifications: modifications ?? this.modifications,
      challenges: challenges ?? this.challenges,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'recipeId': recipeId,
        'recipeName': recipeName,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime?.toIso8601String(),
        'completedSteps': completedSteps.map((s) => s.toJson()).toList(),
        'notes': notes.map((n) => n.toJson()).toList(),
        'photos': photos,
        'finalRating': finalRating,
        'review': review,
        'actualCookTime': actualCookTime?.inMinutes,
        'isSuccessful': isSuccessful,
        'modifications': modifications,
        'challenges': challenges,
      };

  factory CookingSession.fromJson(Map<String, dynamic> json) => CookingSession(
        id: json['id'] ?? '',
        userId: json['userId'] ?? '',
        recipeId: json['recipeId'] ?? '',
        recipeName: json['recipeName'] ?? '',
        startTime: DateTime.tryParse(json['startTime'] ?? '') ?? DateTime.now(),
        endTime:
            json['endTime'] != null ? DateTime.tryParse(json['endTime']) : null,
        completedSteps: (json['completedSteps'] as List?)
                ?.map((s) => SessionStep.fromJson(s))
                .toList() ??
            [],
        notes: (json['notes'] as List?)
                ?.map((n) => SessionNote.fromJson(n))
                .toList() ??
            [],
        photos: List<String>.from(json['photos'] ?? []),
        finalRating: json['finalRating']?.toDouble(),
        review: json['review'],
        actualCookTime: json['actualCookTime'] != null
            ? Duration(minutes: json['actualCookTime'])
            : null,
        isSuccessful: json['isSuccessful'] ?? false,
        modifications: json['modifications'] != null
            ? List<String>.from(json['modifications'])
            : null,
        challenges: json['challenges'] != null
            ? List<String>.from(json['challenges'])
            : null,
      );
}

class SessionStep {
  final int stepNumber;
  final DateTime completedAt;
  final Duration? timeSpent;
  final String? notes;
  final int difficultyRating;

  const SessionStep({
    required this.stepNumber,
    required this.completedAt,
    this.timeSpent,
    this.notes,
    this.difficultyRating = 5,
  });

  SessionStep copyWith({
    int? stepNumber,
    DateTime? completedAt,
    Duration? timeSpent,
    String? notes,
    int? difficultyRating,
  }) {
    return SessionStep(
      stepNumber: stepNumber ?? this.stepNumber,
      completedAt: completedAt ?? this.completedAt,
      timeSpent: timeSpent ?? this.timeSpent,
      notes: notes ?? this.notes,
      difficultyRating: difficultyRating ?? this.difficultyRating,
    );
  }

  Map<String, dynamic> toJson() => {
        'stepNumber': stepNumber,
        'completedAt': completedAt.toIso8601String(),
        'timeSpent': timeSpent?.inMinutes,
        'notes': notes,
        'difficultyRating': difficultyRating,
      };

  factory SessionStep.fromJson(Map<String, dynamic> json) => SessionStep(
        stepNumber: json['stepNumber'] ?? 0,
        completedAt:
            DateTime.tryParse(json['completedAt'] ?? '') ?? DateTime.now(),
        timeSpent: json['timeSpent'] != null
            ? Duration(minutes: json['timeSpent'])
            : null,
        notes: json['notes'],
        difficultyRating: json['difficultyRating'] ?? 5,
      );
}

class SessionNote {
  final String id;
  final String note;
  final DateTime timestamp;
  final String? category;

  const SessionNote({
    required this.id,
    required this.note,
    required this.timestamp,
    this.category,
  });

  SessionNote copyWith({
    String? id,
    String? note,
    DateTime? timestamp,
    String? category,
  }) {
    return SessionNote(
      id: id ?? this.id,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'note': note,
        'timestamp': timestamp.toIso8601String(),
        'category': category,
      };

  factory SessionNote.fromJson(Map<String, dynamic> json) => SessionNote(
        id: json['id'] ?? '',
        note: json['note'] ?? '',
        timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
        category: json['category'],
      );
}
