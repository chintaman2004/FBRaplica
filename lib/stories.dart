// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// Model class
class Story {
  final String imageUrl;
  final String userName;

  Story({required this.imageUrl, required this.userName});
}

// List of sample stories
final List<Story> storyList = [
  Story(imageUrl: 'https://picsum.photos/200/300?1', userName: 'Ahmed'),
  Story(imageUrl: 'https://picsum.photos/200/300?2', userName: 'Sara'),
  Story(imageUrl: 'https://picsum.photos/200/300?3', userName: 'Ali'),
  Story(imageUrl: 'https://picsum.photos/200/300?4', userName: 'Fatima'),
  Story(imageUrl: 'https://picsum.photos/200/300?5', userName: 'John'),
  Story(imageUrl: 'https://picsum.photos/200/300?6', userName: 'Maya'),
  Story(imageUrl: 'https://picsum.photos/200/300?7', userName: 'Zain'),
  Story(imageUrl: 'https://picsum.photos/200/300?8', userName: 'Emma'),
  Story(imageUrl: 'https://picsum.photos/200/300?9', userName: 'Bilal'),
  Story(imageUrl: 'https://picsum.photos/200/300?10', userName: 'Nora'),
  Story(imageUrl: 'https://picsum.photos/200/300?11', userName: 'Usman'),
  Story(imageUrl: 'https://picsum.photos/200/300?12', userName: 'Alina'),
  Story(imageUrl: 'https://picsum.photos/200/300?13', userName: 'Hamza'),
  Story(imageUrl: 'https://picsum.photos/200/300?14', userName: 'Sophia'),
  Story(imageUrl: 'https://picsum.photos/200/300?15', userName: 'Tariq'),
  Story(imageUrl: 'https://picsum.photos/200/300?16', userName: 'Olivia'),
  Story(imageUrl: 'https://picsum.photos/200/300?17', userName: 'Kashif'),
  Story(imageUrl: 'https://picsum.photos/200/300?18', userName: 'Zoya'),
  Story(imageUrl: 'https://picsum.photos/200/300?19', userName: 'Imran'),
  Story(imageUrl: 'https://picsum.photos/200/300?20', userName: 'Aisha'),
];

// Widget to display stories
class StoriesWidget extends StatelessWidget {
  const StoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: storyList.length,
        itemBuilder: (context, index) {
          final story = storyList[index];
          return GestureDetector(
            onTap: () {
              // Optional: Add functionality to open full screen story view
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Viewing ${story.userName}\'s story')),
              );
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(story.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      story.userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
