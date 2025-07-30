class Post {
  final String username;
  final String timestamp;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  bool isLiked;
  List<String> comments;

  Post({
    required this.username,
    required this.timestamp,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    this.isLiked = false,
    List<String>? comments,
    required String id,
    required String type,
    required mediaUrl,
  }) : comments = comments ?? [];
}
