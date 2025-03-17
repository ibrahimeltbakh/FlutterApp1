class Chat {
  final String name;
  final String status;
  final String time;
  final String imageUrl;

  Chat({
    required this.name,
    required this.status,
    required this.time,
    required this.imageUrl,
  });
}

class Story {
  final String name;
  final bool hasStory;
  final String imageUrl;

  Story({required this.name, this.hasStory = false, required this.imageUrl});
}
