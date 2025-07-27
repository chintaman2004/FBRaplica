import 'package:flutter/material.dart';

class StoryViewScreen extends StatelessWidget {
  final String imageUrl;
  final String username;
  final String profileImage;

  const StoryViewScreen({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: [
            Center(child: Image.network(imageUrl, fit: BoxFit.contain)),
            Positioned(
              top: 40,
              left: 16,
              child: Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(profileImage)),
                  const SizedBox(width: 8),
                  Text(
                    username,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
