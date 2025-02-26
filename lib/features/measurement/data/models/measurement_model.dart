// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MeasurementModel {
  final int? pulse;
  final double? temperature;
  final double? voltage ;

  const MeasurementModel({
    required this.pulse,
    required this.temperature,
    required this.voltage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pulse': pulse,
      'temperature': temperature,
      'ecgVoltage': voltage,
    };
  }

  factory MeasurementModel.fromMap(Map<String, dynamic> map) {
    return MeasurementModel(
      pulse: map['pulse'] != null ? map['pulse'] as int : null,
      temperature: map['temperature'] != null ? map['temperature'] as double : null,
      voltage: map['ecgVoltage'] != null ? map['ecgVoltage'] as double : null,
    );
  }

  MeasurementModel copyWith({
    int? pulse,
    double? temperature,
    double? voltage ,
  }) {
    return MeasurementModel(
      pulse: pulse ?? this.pulse,
      temperature: temperature ?? this.temperature,
      voltage: voltage ?? this.voltage,
    );
  }

  String toJson() => json.encode(toMap());

  factory MeasurementModel.fromJson(String source) => MeasurementModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MeasurementModel(pulse: $pulse, temperature: $temperature, ecgVoltage: $voltage)';

  @override
  bool operator ==(covariant MeasurementModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.pulse == pulse &&
      other.temperature == temperature &&
      other.voltage ==voltage ;
  }

  @override
  int get hashCode => pulse.hashCode ^ temperature.hashCode ^ voltage.hashCode;
}
