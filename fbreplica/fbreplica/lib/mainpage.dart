import 'package:flutter/material.dart';
import 'package:fbreplica/post_simple.dart';
import 'package:fbreplica/post_pic.dart';
import 'package:fbreplica/post_vid.dart';
import 'story.dart';
import 'reels_page.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final List<Widget> userPosts = [];

  final List<Story> stories = [
    Story(imageUrl: 'assets/images/1.jpg', userName: 'You'),
    Story(imageUrl: 'assets/images/2.jpg', userName: 'Sara'),
    Story(imageUrl: 'assets/images/3.jpg', userName: 'Ahmed'),
    Story(imageUrl: 'assets/images/4.jpg', userName: 'Alizay'),
    Story(imageUrl: 'assets/images/5.png', userName: 'Hannah'),
    Story(imageUrl: 'assets/images/ford.jpg', userName: 'Ford'),
    Story(imageUrl: 'assets/images/1.jpg', userName: 'Sam'),
    Story(imageUrl: 'assets/images/2.jpg', userName: 'Rebica'),
    Story(imageUrl: 'assets/images/3.jpg', userName: 'Sib'),
    Story(imageUrl: 'assets/images/4.jpg', userName: 'Susan'),
    Story(imageUrl: 'assets/images/5.png', userName: 'Ryle'),
    Story(imageUrl: 'assets/images/ford.jpg', userName: 'Mustang'),
  ];

  void _openPostOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Container(
            padding: const EdgeInsets.all(16),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Post',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.text_fields),
                  title: const Text('Text Post'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      userPosts.insert(
                        0,
                        TextOnlyPostPage(
                          username: 'Your Name',
                          timestamp: 'Just now',
                          content: 'This is a new text post!',
                          profileImage: 'assets/images/ahc.jpg',
                        ),
                      );
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Image Post'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      userPosts.insert(
                        0,
                        ImagePostPage(
                          username: 'Your Name',
                          timestamp: 'Just now',
                          content: 'Image uploaded!',
                          profileImage: 'assets/images/ahc.jpg',
                          postImage: 'assets/images/mas.jpg',
                          videoUrl: '',
                        ),
                      );
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.videocam),
                  title: const Text('Video Post'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      userPosts.insert(
                        0,
                        VideoPostPage(
                          username: 'Your Name',
                          timestamp: 'Just now',
                          content: 'New video!',
                          profileImage: 'assets/images/ahc.jpg',
                          videoUrl: 'assets/videos/vid1.mp4',
                          postImage: '',
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'facebook',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 40),
            onPressed: _openPostOptions,
          ),
          IconButton(
            icon: const Icon(Icons.search, size: 40),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.chat, size: 40), onPressed: () {}),
        ],
      ),
      body: ListView(
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReelsPage()),
                  );
                },
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
                    icon: const Icon(Icons.photo_library),
                    iconSize: 30,
                    onPressed: () {},
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
          ...userPosts, // ✅ Add user-generated posts
          // Static sample posts:
          TextOnlyPostPage(
            username: 'Ahmed Hassan',
            timestamp: '5 mins ago',
            content: 'Exploring Flutter is fun. Loving the layout system!',
            profileImage: 'assets/images/ahc.jpg',
          ),
          ImagePostPage(
            username: 'Sara Khan',
            timestamp: '10 mins ago',
            content: 'Check out my new Flutter project!',
            profileImage: 'assets/images/2.jpg',
            postImage: 'assets/images/mas.jpg',
            videoUrl: '',
          ),
          VideoPostPage(
            username: 'Alizay',
            timestamp: '15 mins ago',
            content: 'Just uploaded a new video on Flutter development!',
            profileImage: 'assets/images/4.jpg',
            videoUrl: 'assets/videos/vid1.mp4',
            postImage: '',
          ),
        ],
      ),
    );
  }
}
