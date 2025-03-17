import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chat_model.dart';

class ChatState {
  final bool isLoading;
  final List<Chat> chats;
  final List<Story> stories;

  ChatState({
    this.isLoading = true,
    this.chats = const [],
    this.stories = const [],
  });

  ChatState copyWith({
    bool? isLoading,
    List<Chat>? chats,
    List<Story>? stories,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      chats: chats ?? this.chats,
      stories: stories ?? this.stories,
    );
  }
}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState()) {
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

        final chats =
            products
                .map(
                  (product) => Chat(
                    name: product['title'] ?? 'Unnamed Product',
                    status: product['description'] ?? 'No description',
                    time: '${DateTime.now().hour}:${DateTime.now().minute} PM',
                    imageUrl:
                        product['thumbnail'] ??
                        'https://via.placeholder.com/150',
                  ),
                )
                .toList();

        final stories =
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

        emit(state.copyWith(isLoading: false, chats: chats, stories: stories));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print('Error fetching data: $e');
      emit(state.copyWith(isLoading: false));
    }
  }
}
