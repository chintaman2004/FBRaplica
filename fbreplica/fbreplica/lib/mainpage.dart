import 'package:flutter/material.dart';
import 'post_simple_form.dart';
import 'post_pic_form.dart';
import 'post_vid_form.dart';
import 'story.dart';
import 'reels_page.dart';
import 'widgets/text_post_widget.dart';
import 'widgets/image_post_widget.dart';
import 'widgets/video_post_widget.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final List<Widget> posts = [];

  final List<Story> stories = [
    Story(imageUrl: 'assets/images/1.jpg', userName: 'You'),
    Story(imageUrl: 'assets/images/2.jpg', userName: 'Sara'),
    Story(imageUrl: 'assets/images/3.jpg', userName: 'Ahmed'),
    Story(imageUrl: 'assets/images/4.jpg', userName: 'Alizay'),
    Story(imageUrl: 'assets/images/5.png', userName: 'Hannah'),
  ];

  void addPost(Widget postWidget) {
    setState(() {
      posts.insert(0, postWidget); // Add to top of feed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'facebook',
          style: TextStyle(fontSize: 32, color: Colors.blueAccent),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 32,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                isScrollControlled: true,
                builder:
                    (_) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 30,
                        left: 16,
                        right: 16,
                        top: 20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Create Post',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            leading: const Icon(Icons.text_fields),
                            title: const Text('Text Post'),
                            onTap: () async {
                              Navigator.pop(context);
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PostSimpleForm(),
                                ),
                              );
                              if (result != null) addPost(result);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.image),
                            title: const Text('Image Post'),
                            onTap: () async {
                              Navigator.pop(context);
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PostPicForm(),
                                ),
                              );
                              if (result != null) addPost(result);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.videocam),
                            title: const Text('Video Post'),
                            onTap: () async {
                              Navigator.pop(context);
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PostVidForm(),
                                ),
                              );
                              if (result != null) addPost(result);
                            },
                          ),
                        ],
                      ),
                    ),
              );
            },
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.chat), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          const Divider(thickness: 1),
          const SizedBox(height: 8),
          Row(
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
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/ahc.jpg'),
                radius: 18,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [Expanded(child: StoryWidget(stories: stories))],
            ),
          ),
          const SizedBox(height: 10),

          // Sample static posts
          TextPostWidget(
            username: 'Ahmed Hassan',
            timestamp: '5 mins ago',
            content: 'Exploring Flutter is fun!',
            profileImage: 'assets/images/ahc.jpg',
          ),
          ImagePostWidget(
            username: 'Sara',
            timestamp: '10 mins ago',
            content: 'My Flutter UI ❤️',
            profileImage: 'assets/images/2.jpg',
            postImage: 'assets/images/mas.jpg',
          ),
          VideoPostWidget(
            username: 'Alizay',
            timestamp: '15 mins ago',
            content: 'Watch my new dev video!',
            profileImage: 'assets/images/4.jpg',
            videoUrl: 'assets/videos/vid1.mp4',
            postImage: '',
          ),

          // New dynamic posts
          ...posts,
        ],
      ),
    );
  }
}
