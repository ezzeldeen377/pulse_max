import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:rxdart/rxdart.dart';

abstract class MessageRemoteDataSource {
  Future<Unit> sendMessage(types.TextMessage message, String chatId);
  Future<ChatModel> createChat(ChatModel chat);
  Stream<List<Map<String, dynamic>>> getUserChats(String uid) ;
  Future<List<types.Message>> getAllMessages();
  Stream<List<types.Message>> listOnChatMessages( String chatId);
    Future<Unit> deleteChat(String chatId);

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
      'lastMessage': (message).text, // Update lastMessage
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
Stream<List<Map<String, dynamic>>> getUserChats(String uid) {
  // Query for chats where the user is the sender
  final senderChatsStream = chatCollection
      .where('senderId', isEqualTo: uid).orderBy('lastMessageTime', descending: true) // Sort newest first

      .snapshots();

  // Query for chats where the user is the receiver
  final receiverChatsStream = chatCollection
      .where('receiverId', isEqualTo: uid)    .orderBy('lastMessageTime', descending: true) // Sort newest first

      .snapshots();

  // Combine both streams
  return Rx.combineLatest2(
  senderChatsStream,
  receiverChatsStream,
  (QuerySnapshot senderSnapshot, QuerySnapshot receiverSnapshot) {
    final senderChats = senderSnapshot.docs;
    final receiverChats = receiverSnapshot.docs;

    // Combine both sender and receiver chat documents
    final allChats = [...senderChats, ...receiverChats];

    // Use a map to remove duplicates based on document ID
    final Map<String, Map<String, dynamic>> uniqueChatsMap = {};

    for (var doc in allChats) {
      uniqueChatsMap[doc.id] = doc.data() as Map<String, dynamic>;
    }

    // Convert map values to a list (only unique chats remain)
    return uniqueChatsMap.values.toList();
  },
);
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
  Stream<List<types.Message>> listOnChatMessages(String chatId) {
  return chatCollection.doc(chatId).snapshots().map((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      try {
        // Parse the document data into a ChatModel
        ChatModel chat = ChatModel.fromMap(snapshot.data() as Map<String, dynamic>);

        // Extract and sort messages
        List<types.Message> messages = chat.messages ?? [];
        messages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

        return messages;
      } catch (e) {
rethrow;       
      }
    } else {
      throw Exception('Chat does not exist'); // Return an empty list if chat doesn't exist
    }
  });
}

  @override
  Future<Unit> deleteChat(String chatId) async {
   final docRef=  chatCollection.doc(chatId);
  await docRef.delete();
    return Future.value(unit);
  }

}
