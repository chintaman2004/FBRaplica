import 'dart:typed_data';

class Post {
  final String username;
  final String timestamp;
  final String content;
  final Uint8List? imageBytes;
  final String? videoUrl;
  final List<String> comments;
  bool isLiked;

  Post({
    required this.username,
    required this.timestamp,
    required this.content,
    this.imageBytes,
    this.videoUrl,
    this.comments = const [],
    this.isLiked = false,
    required String id,
    required imageUrl,
    required String type,
    required mediaUrl,
  });
}
