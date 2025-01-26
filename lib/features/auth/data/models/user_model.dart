// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
 String uid;
 String email;
 String? username; // Optional field
 String? profilePicture; // Optional field
 DateTime? createdAt;
  UserModel({
    required this.uid,
    required this.email,
    this.username,
    this.profilePicture,
    this.createdAt,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? profilePicture,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'username': username,
      'profilePicture': profilePicture,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      username: map['username'] != null ? map['username'] as String : null,
      profilePicture: map['profilePicture'] != null ? map['profilePicture'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usermodel(uid: $uid, email: $email, username: $username, profilePicture: $profilePicture, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email &&
      other.username == username &&
      other.profilePicture == profilePicture &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      username.hashCode ^
      profilePicture.hashCode ^
      createdAt.hashCode;
  }
}
