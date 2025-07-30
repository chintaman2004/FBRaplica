class Post {
  final String id;
  final String username;
  final String content;
  final String? imageUrl;
  final String? videoUrl;

  bool isLiked;
  List<String> comments;

  Post({
    required this.id,
    required this.username,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    this.isLiked = false,
    List<String>? comments,
  }) : comments = comments ?? [];
}
