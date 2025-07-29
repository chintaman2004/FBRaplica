class Post {
  final String id;
  final String username;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  bool isLiked;
  int likeCount;

  Post({
    required this.id,
    required this.username,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    this.isLiked = false,
    this.likeCount = 0,
  });

  // Factory constructor to create a Post from a map (useful when decoding from JSON or Firestore)
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      username: map['username'] ?? 'Unknown',
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'],
      videoUrl: map['videoUrl'],
      isLiked: map['isLiked'] ?? false,
      likeCount: map['likeCount'] ?? 0,
    );
  }

  get comments => null;

  // Optional: Convert Post object to Map (if needed)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'content': content,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'isLiked': isLiked,
      'likeCount': likeCount,
    };
  }
}
