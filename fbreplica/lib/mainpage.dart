import 'package:fbreplica/post_pic.dart';
import 'package:fbreplica/post_simple.dart';
import 'package:fbreplica/post_vid.dart';
import 'package:flutter/material.dart';
import 'story.dart'; // ✅ Your single story file

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Story> stories = [
      Story(imageUrl: 'assets/images/1.jpg', userName: 'You'),
      Story(imageUrl: 'assets/images/2.jpg', userName: 'Sara'),
      Story(imageUrl: 'assets/images/3.jpg', userName: 'Ahmed'),
      Story(imageUrl: 'assets/images/4.jpg', userName: 'Alizay'),
      Story(imageUrl: 'assets/images/5.png', userName: 'Hannah'),
      Story(imageUrl: 'assets/images/ford.jpg', userName: 'Ford'),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 40,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 40,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat),
            iconSize: 40,
            onPressed: () {},
          ),
        ],
        title: const Text('facebook'),
        titleTextStyle: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Divider(thickness: 1, color: Colors.grey),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, size: 30, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.video_library,
                    size: 30,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.group, size: 30, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.store, size: 30, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
                ClipOval(
                  child: Image.asset(
                    'assets/images/ahc.jpg',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/ahc.jpg',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: SearchBar(
                        hintText: 'Search AI',
                        onSubmitted: (value) {},
                        textStyle: WidgetStateProperty.all(
                          const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.photo_library),
                      iconSize: 30,
                      padding: EdgeInsets.zero,
                      splashRadius: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [Expanded(child: StoryWidget(stories: stories))],
              ),
            ),

            TextOnlyPostWidget(
              username: 'Ahmed Hassan',
              timestamp: '5 mins ago',
              content: 'Exploring Flutter is fun. Loving the layout system!',
              profileImage: 'assets/images/ahc.jpg',
            ),
            PostWithImageWidget(
              username: 'Sara Khan',
              timestamp: '10 mins ago',
              content: 'Check out my new Flutter project!',
              profileImage: 'assets/images/2.jpg',
              postImage: 'assets/images/mas.jpg',
            ),
            PostWithVideoWidget(
              username: 'Alizay',
              timestamp: '15 mins ago',
              content: 'Just uploaded a new video on Flutter development!',
              profileImage: 'assets/images/4.jpg',
              videoUrl: 'assets/videos/vid1.mp4',
            ),
          ],
        ),
      ),
    );
  }
}
