import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pulse_max/core/routes/routes.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_cubit.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_state.dart';
import 'package:pulse_max/features/message/presentation/screens/chat_screen.dart';

class UserChatsScreen extends StatelessWidget {
  static const routeName = '/user_chats';
  const UserChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: BlocBuilder<ChatsCubit, ChatsState>(
        builder: (context, state) {
          final chats = state.chats ?? [];
          if (chats.isEmpty)
            return const Center(
              child: Text('No Chats'),
            );
          if (state.isLoading)
            return const Center(
              child: CircularProgressIndicator(),
            );
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(chat.receiverProfilePicture ?? ''),
                ),
                title: Text(chat.receiverName ?? ''),
                subtitle: Text(
                  chat.lastMessage ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('hh:mm a')
                          .format(chat.lastMessageTime ?? DateTime.now()),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.chatScreen,
                      arguments: chat);
                },
              );
            },
          );
        },
      ),
    );
  }
}
