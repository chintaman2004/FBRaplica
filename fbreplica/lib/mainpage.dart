import 'package:flutter/material.dart';
import 'story.dart';
import 'reels_page.dart';
import 'post_card_text.dart';
import 'post_card_image.dart';
import 'post_card_video.dart';
import 'post_simple.dart';
import 'post_pic.dart';
import 'post_vid.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Story> stories = [
      Story(imageUrl: 'assets/images/1.jpg', userName: 'You'),
      Story(imageUrl: 'assets/images/2.jpg', userName: 'Sara'),
      Story(imageUrl: 'assets/images/3.jpg', userName: 'Ahmed'),
      Story(imageUrl: 'assets/images/4.jpg', userName: 'Alizay'),
    ];

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
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // <-- important
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder:
                    (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: Wrap(
                        children: [
                          const Text(
                            'Create Post',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            leading: const Icon(Icons.text_fields),
                            title: const Text('Text Post'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => TextOnlyPostPage(
                                        username: 'Your Name',
                                        timestamp: 'Just now',
                                        content: '',
                                        profileImage: 'assets/images/ahc.jpg',
                                      ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.image),
                            title: const Text('Image Post'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => ImagePostPage(
                                        username: 'Your Name',
                                        timestamp: 'Just now',
                                        content: '',
                                        profileImage: 'assets/images/ahc.jpg',
                                        postImage: 'assets/images/mas.jpg',
                                        videoUrl: '',
                                      ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.videocam),
                            title: const Text('Video Post'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => VideoPostPage(
                                        username: 'Your Name',
                                        timestamp: 'Just now',
                                        content: '',
                                        profileImage: 'assets/images/ahc.jpg',
                                        videoUrl: 'assets/videos/vid1.mp4',
                                        postImage: '',
                                      ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
              );
            },
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

          // Bottom nav buttons
          _buildNavigationRow(context),

          const SizedBox(height: 10),

          // Search bar
          _buildSearchBar(),

          const SizedBox(height: 20),

          // Stories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: StoryWidget(stories: stories),
          ),

          const SizedBox(height: 10),

          // Posts feed using card widgets
          PostCardText(
            username: 'Ahmed Hassan',
            timestamp: '5 mins ago',
            content: 'Exploring Flutter is fun. Loving the layout system!',
            profileImage: 'assets/images/ahc.jpg',
          ),
          PostCardImage(
            username: 'Sara Khan',
            timestamp: '10 mins ago',
            content: 'Check out my new Flutter project!',
            profileImage: 'assets/images/2.jpg',
            postImage: 'assets/images/mas.jpg',
          ),
          PostCardVideo(
            username: 'Alizay',
            timestamp: '15 mins ago',
            content: 'Just uploaded a new video on Flutter development!',
            profileImage: 'assets/images/4.jpg',
            videoUrl: 'assets/videos/vid1.mp4',
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.home, color: Colors.blue),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.video_library, color: Colors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReelsPage()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.group, color: Colors.blue),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.store, color: Colors.blue),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.blue),
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
    );
  }

  Widget _buildSearchBar() {
    return Padding(
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Search AI',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.photo_library, size: 30),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
