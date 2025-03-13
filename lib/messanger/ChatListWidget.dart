import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'chat_model.dart';

class ChatListWidget extends StatelessWidget {
  final List<Chat> chats;

  const ChatListWidget({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              backgroundImage: CachedNetworkImageProvider(
                chats[index].imageUrl,
              ),
            ),
            title: Text(chats[index].name),
            subtitle: Text(
              chats[index].status,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              chats[index].time,
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              // Navigation to chat detail page
            },
          );
        },
      ),
    );
  }
}
