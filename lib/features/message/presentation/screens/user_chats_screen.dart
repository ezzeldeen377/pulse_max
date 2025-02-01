import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pulse_max/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_cubit.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_state.dart';
class UserChatsScreen extends StatelessWidget {
  static const routeName = '/user_chats';
  const UserChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AppUserCubit>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1A998E), Color(0xff0E6C63)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100], // Light background for contrast
        child: BlocBuilder<ChatsCubit, ChatsState>(
          builder: (context, state) {
            final chats = state.chats ?? [];
            if (chats.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No Chats Yet',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ],
                ),
              );
            }
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff1A998E),
                ),
              );
            }
            return RefreshIndicator(
              color: const Color(0xff1A998E),
              onRefresh: () async {
                // Refresh chats
              },
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return Dismissible(
                    key: Key(chat.id ?? ''),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      // Remove the dismissed item from the list

                      // Optionally, show a snack bar or other feedback
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Chat deleted')),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xff1A998E),
                          backgroundImage: NetworkImage(
                            currentUser?.uid == chat.senderId
                                ? chat.receiverProfilePicture ?? ''
                                : chat.senderProfilePicture ?? '',
                          ),
                          radius: 25,
                          child: chat.receiverProfilePicture == null
                              ? const Icon(Icons.person, color: Colors.white)
                              : null,
                        ),
                        title: Text(
                          currentUser?.uid == chat.senderId
                              ? chat.receiverName ?? ''
                              : chat.senderName ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1A998E),
                          ),
                        ),
                        subtitle: Text(
                          chat.lastMessage ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('hh:mm a')
                                  .format(chat.lastMessageTime ?? DateTime.now()),
                              style: const TextStyle(
                                color: Color(0xff1A998E),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.chatScreen,
                              arguments: chat);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
