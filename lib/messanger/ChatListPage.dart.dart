// lib/messanger/ChatListPage.dart
import 'package:flutter/material.dart';
import 'ChatListWidget.dart';
import 'chat_model.dart';

// Define the Story data model
class Story {
  final String name;
  final bool hasStory;

  Story({required this.name, this.hasStory = false});
}

class ChatListPage extends StatelessWidget {
  // Story data
  final List<Story> stories = [
    Story(name: 'Khaled', hasStory: true),
    Story(name: 'Fatima', hasStory: false),
    Story(name: 'Yousef', hasStory: true),
    Story(name: 'Nora', hasStory: false),
    Story(name: 'Omar', hasStory: true),
  ];

  // Chat data
  final List<Chat> chats = [
    Chat(
      name: 'Khaled Mohammad',
      status: 'Hello, I am Khaled',
      time: '04:00 PM',
    ),
    Chat(name: 'Fatima Ahmad', status: 'How are you?', time: '03:30 PM'),
    Chat(name: 'Yousef Ali', status: 'Let’s meet tomorrow', time: '02:15 PM'),
    Chat(name: 'Nora Saeed', status: 'I sent you a photo', time: '01:00 PM'),
    Chat(name: 'Omar Khaled', status: 'Thanks for the help', time: '12:30 PM'),
    Chat(name: 'Sara Ahmed', status: 'Can we talk now?', time: '05:00 PM'),
    Chat(name: 'Mahmoud Ziad', status: 'I’ll call you later', time: '04:30 PM'),
    Chat(
      name: 'Laila Hassan',
      status: 'Check the group chat',
      time: '03:45 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.person, color: Colors.grey),
            ),
            SizedBox(width: 8),
            Text('Chats'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              // Handle camera action
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Handle edit action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stories row
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            stories[index].hasStory
                                ? Colors.green[100]
                                : Colors.blue[100],
                        child: Icon(Icons.person, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(stories[index].name, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          // Chat list
          ChatListWidget(chats: chats),
        ],
      ),
    );
  }
}
