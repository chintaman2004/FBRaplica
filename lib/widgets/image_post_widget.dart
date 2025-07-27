// ignore_for_file: unnecessary_underscores

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImagePostWidget extends StatelessWidget {
  final String username;
  final String timestamp;
  final String content;
  final String profileImage;
  final String? postImage; // Path for mobile/desktop
  final Uint8List? postBytes; // Bytes for web

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
    Widget imageWidget;

    // --- Web ---
    if (kIsWeb) {
      if (postBytes != null && postBytes!.isNotEmpty) {
        imageWidget = Image.memory(
          postBytes!,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder:
              (_, __, ___) =>
                  const Center(child: Text("⚠️ Failed to display web image")),
        );
      } else {
        imageWidget = const Padding(
          padding: EdgeInsets.all(12),
          child: Text("⚠️ No image data provided (web)"),
        );
      }
    }
    // --- Mobile/Desktop ---
    else {
      if (postImage != null && File(postImage!).existsSync()) {
        imageWidget = Image.file(
          File(postImage!),
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder:
              (_, __, ___) =>
                  const Center(child: Text("⚠️ Failed to display file image")),
        );
      } else {
        imageWidget = const Padding(
          padding: EdgeInsets.all(12),
          child: Text("⚠️ Image file not found"),
        );
      }
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
            child: imageWidget,
          ),
        ],
      ),
    );
  }
}
