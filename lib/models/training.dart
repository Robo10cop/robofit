class TrainingModel {
  final String id;
  final String name;
  final String type;
  final String description;
  final String videoUrl;
  final int duration; // In minutes
  final List<String> days;

  TrainingModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.videoUrl,
    required this.duration,
    required this.days,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'videoUrl': videoUrl,
      'duration': duration,
      'days': days,
    };
  }

  factory TrainingModel.fromMap(Map<String, dynamic> map) {
    return TrainingModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      duration: map['duration'] ?? 0,
      days: List<String>.from(map['days'] ?? []),
    );
  }
}
