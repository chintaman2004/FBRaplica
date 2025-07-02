import 'package:flutter/material.dart';
import 'post_simple_form.dart';
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

  void addPost(Widget postWidget) {
    setState(() {
      posts.insert(0, postWidget);
    });
  }

  void _showPostOptions(BuildContext context) {
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.text_fields),
                  title: const Text('Text Post'),
                  onTap: () async {
                    Navigator.pop(context);
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PostSimpleForm()),
                    );
                    if (result != null) addPost(result);
                  },
                ),
                // You can add image/video post options later
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'facebook',
          style: TextStyle(fontSize: 28, color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 28,
            onPressed: () => _showPostOptions(context),
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.chat), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          const Divider(thickness: 1),
          const SizedBox(height: 10),

          // Navigation Icons Row
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

          const SizedBox(height: 10),

          // Safe Stories Placeholder
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Stories Placeholder",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Static Post 1 - Text Post
          Builder(
            builder: (context) {
              try {
                return TextPostWidget(
                  username: 'Ahmed Hassan',
                  timestamp: '5 mins ago',
                  content: 'Exploring Flutter is fun!',
                  profileImage: 'assets/images/ahc.jpg',
                );
              } catch (e) {
                return Text("Error loading TextPostWidget: $e");
              }
            },
          ),

          // Static Post 2 - Image Post
          Builder(
            builder: (context) {
              try {
                return ImagePostWidget(
                  username: 'Sara',
                  timestamp: '10 mins ago',
                  content: 'My Flutter UI ❤️',
                  profileImage: 'assets/images/2.jpg',
                  postImage: 'assets/images/mas.jpg',
                );
              } catch (e) {
                return Text("Error loading ImagePostWidget: $e");
              }
            },
          ),

          // Static Post 3 - Video Post
          Builder(
            builder: (context) {
              try {
                return VideoPostWidget(
                  username: 'Alizay',
                  timestamp: '15 mins ago',
                  content: 'Watch my new dev video!',
                  profileImage: 'assets/images/4.jpg',
                  videoUrl: 'assets/videos/vid1.mp4',
                  postImage: '', // or a thumbnail if you want
                );
              } catch (e) {
                return Text("Error loading VideoPostWidget: $e");
              }
            },
          ),

          // Dynamic User-Created Posts (if any)
          ...posts,
        ],
      ),
    );
  }
}
