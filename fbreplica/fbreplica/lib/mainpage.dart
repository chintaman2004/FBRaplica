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
                // You can add image & video post forms here later
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

          // Navigation Icons Row (Updated size)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 36,
                icon: const Icon(Icons.home, color: Colors.blue),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 36,
                icon: const Icon(Icons.video_library, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReelsPage()),
                  );
                },
              ),
              IconButton(
                iconSize: 36,
                icon: const Icon(Icons.group, color: Colors.blue),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 36,
                icon: const Icon(Icons.store, color: Colors.blue),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 36,
                icon: const Icon(Icons.notifications, color: Colors.blue),
                onPressed: () {},
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/ahc.jpg'),
                radius: 20,
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Facebook-style Rectangular Stories
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: const [
                _StoryCard(image: 'assets/images/ahc.jpg', name: 'You'),
                _StoryCard(image: 'assets/images/2.jpg', name: 'Sara'),
                _StoryCard(image: 'assets/images/3.jpg', name: 'Ahmed'),
                _StoryCard(image: 'assets/images/4.jpg', name: 'Alizay'),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Static Text Post
          TextPostWidget(
            username: 'Ahmed Hassan',
            timestamp: '5 mins ago',
            content: 'Exploring Flutter is fun!',
            profileImage: 'assets/images/ahc.jpg',
          ),

          // Static Image Post
          ImagePostWidget(
            username: 'Sara',
            timestamp: '10 mins ago',
            content: 'My Flutter UI ❤️',
            profileImage: 'assets/images/2.jpg',
            postImage: 'assets/images/mas.jpg',
          ),

          // Static Video Post
          VideoPostWidget(
            username: 'Alizay',
            timestamp: '15 mins ago',
            content: 'Watch my new dev video!',
            profileImage: 'assets/images/4.jpg',
            videoUrl: 'assets/videos/vid1.mp4',
            postImage: '',
          ),

          // User-added dynamic posts
          ...posts,
        ],
      ),
    );
  }
}

// Story card widget (rectangle style)
class _StoryCard extends StatelessWidget {
  final String image;
  final String name;

  const _StoryCard({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(6),
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
