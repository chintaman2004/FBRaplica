import 'package:flutter/material.dart';
import 'post_simple_form.dart';
import 'post_pic_form.dart';
import 'post_vid_form.dart';
import 'reels_page.dart';
import 'story_widget.dart';
import 'widgets/text_post_widget.dart';
import 'widgets/image_post_widget.dart';
import 'widgets/video_post_widget.dart';
import 'profilepage.dart';
import 'marketplace_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> posts = [
    const TextPostWidget(
      username: 'Ahmed',
      timestamp: 'Just now',
      content: 'Hello from Facebook Replica!',
      profileImage: 'assets/images/ahc.jpg',
    ),
    const ImagePostWidget(
      username: 'Sara',
      timestamp: '1 min ago',
      content: 'Check out this photo!',
      profileImage: 'assets/images/ahc.jpg',
      postImage: 'assets/images/mas.jpg',
      postBytes: null,
    ),
    const VideoPostWidget(
      username: 'John',
      timestamp: '2 min ago',
      content: 'Watch this video!',
      profileImage: 'assets/images/ahc.jpg',
      videoUrl: 'assets/videos/vid1.mp4',
      videoBytes: null,
      postImage: '',
    ),
  ];

  int _selectedIndex = 0;

  /// Add post options
  void _showPostOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (ctx) => Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text("Text Post"),
                onTap: () async {
                  Navigator.pop(ctx);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PostSimpleForm(initialContent: ''),
                    ),
                  );
                  if (result != null) setState(() => posts.insert(0, result));
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Image Post"),
                onTap: () async {
                  Navigator.pop(ctx);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PostPicForm()),
                  );
                  if (result != null) setState(() => posts.insert(0, result));
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text("Video Post"),
                onTap: () async {
                  Navigator.pop(ctx);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PostVidForm()),
                  );
                  if (result != null) setState(() => posts.insert(0, result));
                },
              ),
            ],
          ),
    );
  }

  /// Demo stories
  final List<Story> demoStories = [
    Story(imageUrl: 'assets/images/ahc.jpg', userName: 'Ahmed'),
    Story(imageUrl: 'assets/images/1.jpg', userName: 'Sara'),
    Story(imageUrl: 'assets/images/2.jpg', userName: 'Ali'),
    Story(imageUrl: 'assets/images/3.jpg', userName: 'Zain'),
    Story(imageUrl: 'assets/images/4.jpg', userName: 'Nida'),
    Story(imageUrl: 'assets/images/5.png', userName: 'Sam'),
  ];

  /// Build feed with edit/delete for text posts
  Widget _buildMainFeed() {
    return ListView(
      children: [
        const SizedBox(height: 12),
        StoryWidget(stories: demoStories),
        const Divider(height: 24),
        ...posts.asMap().entries.map((entry) {
          final index = entry.key;
          final post = entry.value;
          return Column(
            children: [
              post,
              if (post is TextPostWidget)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _editPost(index),
                      child: const Text("Edit"),
                    ),
                    TextButton(
                      onPressed: () => _deletePost(index),
                      child: const Text("Delete"),
                    ),
                  ],
                ),
            ],
          );
        }),
        const SizedBox(height: 100),
      ],
    );
  }

  /// Edit post
  void _editPost(int index) async {
    final post = posts[index];
    if (post is TextPostWidget) {
      final editedPost = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostSimpleForm(initialContent: post.content),
        ),
      );
      if (editedPost != null) {
        setState(() => posts[index] = editedPost);
      }
    }
  }

  /// Delete post
  void _deletePost(int index) {
    setState(() => posts.removeAt(index));
  }

  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return _buildMainFeed();
    } else if (_selectedIndex == 1) {
      return ReelsPage(onBack: () => setState(() => _selectedIndex = 0));
    } else if (_selectedIndex == 2) {
      return MarketplaceItem(
        image: 'assets/images/14promax.jpg',
        title: 'iPhone 14 Pro Max',
        price: 'Rs. 225,000/=',
        location: 'Karachi, Pakistan',
        onBack: () => setState(() => _selectedIndex = 0),
        floatingActionButton: null,
        child: null,
      );
    } else if (_selectedIndex == 3) {
      return const Center(child: Text('Messenger'));
    } else if (_selectedIndex == 4) {
      return const ProfilePage();
    } else {
      return const SizedBox.shrink();
    }
  }

  void _onNavTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('facebook'),
        titleTextStyle: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => _onNavTapped(0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.ondemand_video,
                    color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => _onNavTapped(1),
                ),
                IconButton(
                  icon: Icon(
                    Icons.storefront,
                    color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => _onNavTapped(2),
                ),
                IconButton(
                  icon: Icon(
                    Icons.message,
                    color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => _onNavTapped(3),
                ),
                GestureDetector(
                  onTap: () => _onNavTapped(4),
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage('assets/images/ahc.jpg'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
      floatingActionButton:
          _selectedIndex == 0
              ? FloatingActionButton(
                onPressed: _showPostOptions,
                child: const Icon(Icons.add),
              )
              : null,
    );
  }
}
