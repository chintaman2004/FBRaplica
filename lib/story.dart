import 'package:flutter/material.dart';
import 'story_view_screen.dart';

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
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length + 1, // ✅ Add Story card
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          if (index == 0) {
            // ✅ Add Story Card
            return GestureDetector(
              onTap: () {
                // Add your logic to create a story
              },
              child: Container(
                height: 140,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add_circle, size: 40, color: Colors.blue),
                    SizedBox(height: 8),
                    Text(
                      "Add Story",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final story = stories[index - 1];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => StoryViewScreen(
                        imageUrl: story.imageUrl,
                        username: story.userName,
                        profileImage: story.imageUrl,
                      ),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  height: 140,
                  width: 90,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(story.imageUrl, fit: BoxFit.cover),
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
