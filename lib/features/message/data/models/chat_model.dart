import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel {
  String? id;
  String? senderId;
  String? receiverId;
  String? receiverName;
  String? receiverProfilePicture;
  String? lastMessage;
  DateTime? lastMessageTime;
  List<types.Message>? messages ;
  ChatModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.receiverName,
    this.receiverProfilePicture,
    this.lastMessage,
    this.lastMessageTime,
     this.messages,
  });
   
  factory ChatModel.faker() {
    final faker = Faker();
    return ChatModel(
      senderId: faker.guid.guid(),
      receiverId: faker.guid.guid(),
      receiverName: faker.person.name(),
      receiverProfilePicture: faker.image.image(),
      lastMessage: faker.lorem.sentence(),
      lastMessageTime: DateTime.now(),
      messages: List<types.Message>.generate(
        5,
        (index) => types.TextMessage(
          id: faker.guid.guid(),
          author: types.User(id: faker.guid.guid(), ),
          remoteId: faker.guid.guid(),
          text: faker.lorem.sentence(),
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ),
      ),
    );

  }
  ChatModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? receiverName,
    String? receiverProfilePicture,
    String? lastMessage,
    DateTime? lastMessageTime,
    List<types.Message>? messages ,
  }) {
    return ChatModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      receiverName: receiverName ?? this.receiverName,
      receiverProfilePicture: receiverProfilePicture ?? this.receiverProfilePicture,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'receiverProfilePicture': receiverProfilePicture,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime?.millisecondsSinceEpoch,
      'messages': messages?.map((x) => x.toJson()).toList(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] != null ? map['id'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      receiverId: map['receiverId'] != null ? map['receiverId'] as String : null,
      receiverName: map['receiverName'] != null ? map['receiverName'] as String : null,
      receiverProfilePicture: map['receiverProfilePicture'] != null ? map['receiverProfilePicture'] as String : null,
      lastMessage: map['lastMessage'] != null ? map['lastMessage'] as String : null,
      lastMessageTime: map['lastMessageTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['lastMessageTime'] as int) : null,
      messages: (map['messages'] as List<dynamic>?)
          ?.map((x) => types.Message.fromJson(x as Map<String, dynamic>))
          .toList());
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, senderId: $senderId, receiverId: $receiverId, receiverName: $receiverName, receiverProfilePicture: $receiverProfilePicture, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, messages: $messages)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.senderId == senderId &&
      other.receiverId == receiverId &&
      other.receiverName == receiverName &&
      other.receiverProfilePicture == receiverProfilePicture &&
      other.lastMessage == lastMessage &&
      other.lastMessageTime == lastMessageTime &&
      listEquals(other.messages, messages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      senderId.hashCode ^
      receiverId.hashCode ^
      receiverName.hashCode ^
      receiverProfilePicture.hashCode ^
      lastMessage.hashCode ^
      lastMessageTime.hashCode ^
      messages.hashCode;
  }
}

// class MessageModel {
//   String? id;
//   String? senderId;
//   String? message;
//   String? sendAt;
//   MessageModel({
//     this.id,
//     this.senderId,
//     this.message,
//     this.sendAt,
//   });

//   MessageModel copyWith({
//     String? id,
//     String? senderId,
//     String? message,
//     String? sendAt,
//   }) {
//     return MessageModel(
//       id: id ?? this.id,
//       senderId: senderId ?? this.senderId,
//       message: message ?? this.message,
//       sendAt: sendAt ?? this.sendAt,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'senderId': senderId,
//       'message': message,
//       'sendAt': sendAt,
//     };
//   }

//   factory MessageModel.fromMap(Map<String, dynamic> map) {
//     return MessageModel(
//       id: map['id'] != null ? map['id'] as String : null,
//       senderId: map['senderId'] != null ? map['senderId'] as String : null,
//       message: map['message'] != null ? map['message'] as String : null,
//       sendAt: map['sendAt'] != null ? map['sendAt'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'MessageModel(id: $id, senderId: $senderId, message: $message, sendAt: $sendAt)';
//   }

//   @override
//   bool operator ==(covariant MessageModel other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.id == id &&
//       other.senderId == senderId &&
//       other.message == message &&
//       other.sendAt == sendAt;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       senderId.hashCode ^
//       message.hashCode ^
//       sendAt.hashCode;
//   }
// }
