import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImagePostWidget extends StatelessWidget {
  final String username, timestamp, content, profileImage;
  final String? postImage; // mobile
  final Uint8List? postBytes; // web

  const ImagePostWidget({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.profileImage,
    this.postImage,
    this.postBytes,
  });

  @override
  Widget build(BuildContext context) {
    Widget img;
    if (kIsWeb && postBytes != null) {
      img = Image.memory(postBytes!, fit: BoxFit.cover, width: double.infinity);
    } else if (!kIsWeb && postImage != null && File(postImage!).existsSync()) {
      img = Image.file(
        File(postImage!),
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      img = const Padding(
        padding: EdgeInsets.all(12),
        child: Text("⚠️ Image not available"),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(profileImage)),
            title: Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(timestamp),
          ),
          if (content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(content),
            ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
            child: img,
          ),
        ],
      ),
    );
  }
}
