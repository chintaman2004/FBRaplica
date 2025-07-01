import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImagePostWidget extends StatelessWidget {
  final String username;
  final String timestamp;
  final String content;
  final String profileImage; // asset path for profile image
  final String?
  postImagePath; // local file path for picked image (mobile/desktop)
  final Uint8List? postImageBytes; // image bytes for web

  const ImagePostWidget({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.profileImage,
    this.postImagePath,
    this.postImageBytes,
    required String postImage,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (postImageBytes != null) {
      // Display image from bytes (web)
      imageWidget = Image.memory(
        postImageBytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
      );
    } else if (postImagePath != null && postImagePath!.isNotEmpty) {
      // Display image from file path (mobile/desktop)
      imageWidget = Image.file(
        File(postImagePath!),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
      );
    } else {
      // Placeholder or default image if no image selected
      imageWidget = Container(
        width: double.infinity,
        height: 200,
        color: Colors.grey[300],
        child: const Icon(
          Icons.image_not_supported,
          size: 80,
          color: Colors.grey,
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with profile image and username
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(profileImage),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      timestamp,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Post content text
            Text(content, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 12),

            // Post image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageWidget,
            ),
          ],
        ),
      ),
    );
  }
}
