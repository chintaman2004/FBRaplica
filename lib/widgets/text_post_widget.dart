import 'package:flutter/material.dart';

class TextPostWidget extends StatelessWidget {
  final String username, timestamp, content, profileImage;
  const TextPostWidget({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) => Card(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(content),
        ),
      ],
    ),
  );
}
