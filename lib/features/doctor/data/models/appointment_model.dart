// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppointmentModel {
   String? appointmentId;
  final String? date;
  final String? status;
  final String? userId;
  final String? doctorId;
  final DateTime? createdAt;
  final double? price;

   AppointmentModel({
    this.appointmentId,
    this.date,
    this.status,
    this.userId,
    this.doctorId,
    this.createdAt,
    this.price,
  });

  // CopyWith method for immutability
  AppointmentModel copyWith({
    String? appointmentId,
    String? date,
    String? status,
    String? userId,
    String? doctorId,
    DateTime? createdAt,
    double? price,
  }) {
    return AppointmentModel(
      appointmentId: appointmentId ?? this.appointmentId,
      date: date ?? this.date,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      createdAt: createdAt ?? this.createdAt,
      price: price ?? this.price,
    );
  }

  // Convert model to a map for Firestore
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appointmentId': appointmentId,
      'date': date,
      'status': status,
      'userId': userId,
      'doctorId': doctorId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'price': price,
    };
  }

  // Create model from Firestore map
  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      appointmentId: map['appointmentId'] != null ? map['appointmentId'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      doctorId: map['doctorId'] != null ? map['doctorId'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
      price: map['price'] != null ? map['price'] as double : null,
    );
  }


  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) => AppointmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppointmentModel(appointmentId: $appointmentId, date: $date, status: $status, userId: $userId, doctorId: $doctorId, createdAt: $createdAt, price: $price)';
  }

  @override
  bool operator ==(covariant AppointmentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.appointmentId == appointmentId &&
      other.date == date &&
      other.status == status &&
      other.userId == userId &&
      other.doctorId == doctorId &&
      other.createdAt == createdAt &&
      other.price == price;
  }

  @override
  int get hashCode {
    return appointmentId.hashCode ^
      date.hashCode ^
      status.hashCode ^
      userId.hashCode ^
      doctorId.hashCode ^
      createdAt.hashCode ^
      price.hashCode;
  }
  }
