import 'package:flutter/material.dart';

class Story {
  final String imageUrl, userName;
  Story({required this.imageUrl, required this.userName});
}

class StoryWidget extends StatelessWidget {
  final List<Story> stories;
  const StoryWidget({super.key, required this.stories});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 150,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: stories.length,
      separatorBuilder: (_, _) => const SizedBox(width: 10),
      itemBuilder: (_, i) {
        final s = stories[i];
        return Stack(
          children: [
            Container(
              width: 90,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(s.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 6,
              left: 6,
              right: 6,
              child: Text(
                s.userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    ),
  );
}
