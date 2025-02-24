class MeasurementModel {
  final int pulse;
  final int temperature;
  final DateTime timestamp;

  const MeasurementModel({
    required this.pulse,
    required this.temperature,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'pulse': pulse,
      'temperature': temperature,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory MeasurementModel.fromMap(Map<String, dynamic> map) {
    return MeasurementModel(
      pulse: map['pulse'] as int,
      temperature: map['temperature'] as int,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }

  MeasurementModel copyWith({
    int? pulse,
    int? temperature,
    DateTime? timestamp,
  }) {
    return MeasurementModel(
      pulse: pulse ?? this.pulse,
      temperature: temperature ?? this.temperature,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}