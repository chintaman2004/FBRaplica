// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Story {
  final String imageUrl;
  final String userName;

  Story({required this.imageUrl, required this.userName});
}

class StoryWidget extends StatelessWidget {
  final List<Story> stories;

  const StoryWidget({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170, // Increased for box style
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: stories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final story = stories[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(story.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 80,
                child: Text(
                  story.userName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
