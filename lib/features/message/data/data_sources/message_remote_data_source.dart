import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';

abstract class MessageRemoteDataSource {
  Future<Unit> sendMessage(types.TextMessage message, String chatId);
  Future<ChatModel> createChat(ChatModel chat);
  Future<List<Map<String, dynamic>>> getChats();
  Future<List<types.Message>> getAllMessages();
  void listOnChatMessages(
      Function(List<types.Message>) callback, String chatId);
}

@Injectable(as: MessageRemoteDataSource)
class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final firestore = FirebaseFirestore.instance;
  CollectionReference get chatCollection => firestore.collection('chats');

  @override
  Future<Unit> sendMessage(types.TextMessage message, String chatId) async {
    final docRef = chatCollection.doc(chatId);
    await docRef.update({
      'messages': FieldValue.arrayUnion(
          [message.toJson()]), // Add the new message to the list
      'lastMessage': (message as types.TextMessage).text, // Update lastMessage
      'lastMessageTime': DateTime.now().millisecondsSinceEpoch,
    });
    return Future.value(unit);
  }

  @override
  Future<List<types.Message>> getAllMessages() {
    // TODO: implement getAllMessages
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getChats() async {
    final chats = await chatCollection.get();
    return chats.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Future<ChatModel> createChat(ChatModel chat) async {
    final result =await  chatCollection
        .where('senderId', isEqualTo: chat.senderId)
        .where('receiverId', isEqualTo: chat.receiverId)
        .get();
        if(result.docs.isNotEmpty){
          return ChatModel.fromMap(result.docs.first.data()as Map<String, dynamic>);
        }
    final chatRef = chatCollection.doc();
    chat.id = chatRef.id;
    await chatRef.set(chat.toMap());
    return chat;
  }

  @override
  void listOnChatMessages(
      Function(List<types.Message> p1) callback, String chatId) {
    chatCollection.doc(chatId).snapshots().listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        try {
          // Parse the document data into a ChatModel
          ChatModel chat =
              ChatModel.fromMap(snapshot.data() as Map<String, dynamic>);

          // Extract the messages from the ChatModel
          List<types.Message> messages =
              chat.messages ?? []; // Ensure the list is not null
          messages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
          // Pass the parsed list to the callback
          callback(messages);
        } catch (e) {
          // Handle errors in parsing
          print('Error parsing chat data: $e');
        }
      } else {
        print('Chat does not exist.');
      }
    });
  }
}
