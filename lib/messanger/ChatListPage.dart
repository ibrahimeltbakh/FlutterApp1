import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ChatListWidget.dart';
import 'chat_model.dart';

class Story {
  final String name;
  final bool hasStory;
  final String imageUrl;

  Story({required this.name, this.hasStory = false, required this.imageUrl});
}

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<Chat> chats = [];
  List<Story> stories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final products = data['products'] as List;

        setState(() {
          chats =
              products
                  .map(
                    (product) => Chat(
                      name: product['title'] ?? 'Unnamed Product',
                      status: product['description'] ?? 'No description',
                      time:
                          '${DateTime.now().hour}:${DateTime.now().minute} PM',
                      imageUrl:
                          product['thumbnail'] ??
                          'https://via.placeholder.com/150',
                    ),
                  )
                  .toList();

          stories =
              products
                  .take(5)
                  .map(
                    (product) => Story(
                      name: product['brand'] ?? 'Unknown Brand',
                      hasStory:
                          ((product['rating'] as num?)?.toDouble() ?? 0) > 4.5,
                      imageUrl:
                          product['thumbnail'] ??
                          'https://via.placeholder.com/150',
                    ),
                  )
                  .toList();

          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              backgroundImage: CachedNetworkImageProvider(
                chats.isNotEmpty
                    ? chats[0].imageUrl
                    : 'https://via.placeholder.com/150',
              ),
            ),
            SizedBox(width: 8),
            Text('Chats'),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
        ],
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  SizedBox(
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
                                backgroundImage: CachedNetworkImageProvider(
                                  stories[index].imageUrl,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                stories[index].name,
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
                  ChatListWidget(chats: chats),
                ],
              ),
    );
  }
}
