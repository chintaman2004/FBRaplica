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
      body: Stack(
        children: [
          Center(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              height: double.infinity,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(profileImage)),
                const SizedBox(width: 10),
                Text(
                  username,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
