import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'ChatListWidget.dart';
import 'chat_cubit.dart';
import 'chat_model.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    backgroundImage: CachedNetworkImageProvider(
                      state.chats.isNotEmpty
                          ? state.chats[0].imageUrl
                          : 'https://via.placeholder.com/150',
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('Chats'),
                ],
              );
            },
          ),
          actions: [
            IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          ],
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.stories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  state.stories[index].hasStory
                                      ? Colors.green[100]
                                      : Colors.blue[100],
                              backgroundImage: CachedNetworkImageProvider(
                                state.stories[index].imageUrl,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              state.stories[index].name,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
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
                ChatListWidget(chats: state.chats),
              ],
            );
          },
        ),
      ),
    );
  }
}
