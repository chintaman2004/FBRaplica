import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  Stories({super.key, required List<Map<String, String>> stories});

  // ✅ Move stories list here
  final List<Map<String, String>> stories = [
    {
      "username": "Ahmed",
      "profileImage":
          "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg",
    },
    {
      "username": "Sara",
      "profileImage":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    },
    {
      "username": "John",
      "profileImage":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg",
    },
    {
      "username": "Emily",
      "profileImage":
          "https://images.pexels.com/photos/1239298/pexels-photo-1239298.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg",
    },
    {
      "username": "Michael",
      "profileImage":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg",
    },
    {
      "username": "Sophia",
      "profileImage":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    },
    {
      "username": "Liam",
      "profileImage":
          "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg",
    },
    {
      "username": "Olivia",
      "profileImage":
          "https://images.pexels.com/photos/1239298/pexels-photo-1239298.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg",
    },
    {
      "username": "James",
      "profileImage":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg",
    },
    {
      "username": "Ava",
      "profileImage":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    },
    {
      "username": "Ahmed",
      "profileImage":
          "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg",
    },
    {
      "username": "Sara",
      "profileImage":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    },
    {
      "username": "John",
      "profileImage":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg",
    },
    {
      "username": "Emily",
      "profileImage":
          "https://images.pexels.com/photos/1239298/pexels-photo-1239298.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg",
    },
    {
      "username": "Michael",
      "profileImage":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg",
    },
    {
      "username": "Sophia",
      "profileImage":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    },
    {
      "username": "Liam",
      "profileImage":
          "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg",
    },
    {
      "username": "Olivia",
      "profileImage":
          "https://images.pexels.com/photos/1239298/pexels-photo-1239298.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg",
    },
    {
      "username": "James",
      "profileImage":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg",
    },
    {
      "username": "Ava",
      "profileImage":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Container(
            width: 120,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(story['storyImage']!),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black54, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    story['username']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(story['profileImage']!),
                    radius: 18,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
