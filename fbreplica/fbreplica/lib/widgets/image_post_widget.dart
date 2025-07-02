import 'package:flutter/material.dart';

class ImagePostWidget extends StatelessWidget {
  final String username;
  final String timestamp;
  final String content;
  final String profileImage;
  final String postImage;

  const ImagePostWidget({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.profileImage,
    required this.postImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with avatar and timestamp
          ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(profileImage)),
            title: Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(timestamp),
          ),

          // Text content
          if (content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(content),
            ),

          const SizedBox(height: 8),

          // Image post (full width)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.asset(
              postImage,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              errorBuilder:
                  (context, error, stackTrace) => const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("⚠️ Image failed to load."),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
