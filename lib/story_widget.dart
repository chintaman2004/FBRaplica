// story_widget.dart

import 'package:flutter/material.dart';
import 'stories.dart'; // Import this to use Story and demoStories

class StoryWidget extends StatelessWidget {
  final List<Story> stories;

  const StoryWidget({
    super.key,
    required this.stories,
    required void Function(Story story) onStoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final story = stories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(backgroundColor: Colors.transparent),
                        body: Center(child: Image.network(story.imageUrl)),
                      ),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  height: 140,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(story.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  left: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      story.userName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
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
