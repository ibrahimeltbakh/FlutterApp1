import 'package:flutter/material.dart';
import 'chat_model.dart';

// Reusable widget for displaying the chat list
class ChatListWidget extends StatelessWidget {
  final List<Chat> chats;

  const ChatListWidget({Key? key, required this.chats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.person, color: Colors.grey),
            ),
            title: Text(chats[index].name),
            subtitle: Text(chats[index].status),
            trailing: Text(
              chats[index].time,
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              //navigation to chat detail page
            },
          );
        },
      ),
    );
  }
}
