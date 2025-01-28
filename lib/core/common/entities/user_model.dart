// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserModel {
  final String uid;
  final String email;
  final String name;
  final DateTime createdAt;
  final String? type;
  final String? city;
  final String? profileImage;
  final String? phoneNumber;
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.type,
    this.city,
    this.profileImage,
    this.phoneNumber,
  });
  // Add any other fields you need
  types.User toTypesUser() {
    return types.User(
      id: uid,
      createdAt: createdAt.millisecondsSinceEpoch,
      firstName: name,
      imageUrl: profileImage,
    );
  }
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    DateTime? createdAt,
    String? type,
    String? city,
    String? profileImage,
    String? phoneNumber,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      city: city ?? this.city,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'type': type,
      'city': city,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      type: map['type'] != null ? map['type'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, createdAt: $createdAt, type: $type, city: $city, profileImage: $profileImage, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email &&
      other.name == name &&
      other.createdAt == createdAt &&
      other.type == type &&
      other.city == city &&
      other.profileImage == profileImage &&
      other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      name.hashCode ^
      createdAt.hashCode ^
      type.hashCode ^
      city.hashCode ^
      profileImage.hashCode ^
      phoneNumber.hashCode;
  }
}
