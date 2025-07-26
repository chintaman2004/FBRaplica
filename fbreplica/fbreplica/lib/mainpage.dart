import 'package:flutter/material.dart';
import 'post_simple_form.dart';
import 'post_pic_form.dart';
import 'post_vid_form.dart';
import 'reels_page.dart';
import 'widgets/text_post_widget.dart';
import 'widgets/image_post_widget.dart';
import 'widgets/video_post_widget.dart';
import 'profilepage.dart';
import 'marketplace_item.dart';
import 'stories.dart';
import 'cardstack.dart'; // ✅ Added

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  /// ✅ Stories List
  final List<Map<String, String>> stories = [
    {
      "username": "Ahmed",
      "profileImage":
          "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg",
    },
    {
      "username": "Sara",
      "profileImage":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
    },
    {
      "username": "John",
      "profileImage":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
      "storyImage":
          "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg",
    },
  ];

  /// ✅ Posts List
  final List<Widget> posts = [
    const TextPostWidget(
      username: 'Ahmed',
      timestamp: 'Just now',
      content: 'Hello from Facebook Replica!',
      profileImage:
          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg',
    ),
    const ImagePostWidget(
      username: 'Sara',
      timestamp: '1 min ago',
      content: 'Check out this amazing photo!',
      profileImage:
          'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg',
      postImage:
          'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg',
      postBytes: null,
    ),
    const VideoPostWidget(
      username: 'John',
      timestamp: '2 min ago',
      content: 'Watch this awesome video!',
      profileImage:
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
      videoUrl:
          'https://videos.pexels.com/video-files/855564/855564-hd_1920_1080_24fps.mp4',
      videoBytes: null,
      postImage: '',
    ),
  ];

  /// ✅ Like state and Like counts
  final List<bool> _likedPosts = [];
  final List<int> _likeCounts = [];

  @override
  void initState() {
    super.initState();
    _likedPosts.addAll(List.generate(posts.length, (_) => false));
    _likeCounts.addAll(List.generate(posts.length, (_) => 0));
  }

  /// ✅ Show Post Options
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
                    MaterialPageRoute(
                      builder:
                          (_) => const PostPicForm(
                            initialContent: '',
                            initialImage: '',
                          ),
                    ),
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
                    MaterialPageRoute(
                      builder:
                          (_) => const PostVidForm(
                            initialContent: '',
                            initialVideo: '',
                          ),
                    ),
                  );
                  if (result != null) setState(() => posts.insert(0, result));
                },
              ),
            ],
          ),
    );
  }

  /// ✅ Comment Feature
  void _showCommentsSheet(BuildContext context, int postIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Comments",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: const [
                      Text("No comments yet. Be the first to comment!"),
                    ],
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Write a comment...",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ✅ Main Feed with Double-Tap to Like
  Widget _buildMainFeed() {
    return ListView.builder(
      itemCount: posts.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) return const SizedBox(height: 12);
        if (index == 1) {
          return Column(
            children: [Stories(stories: stories), const Divider(height: 24)],
          );
        }
        final postIndex = index - 2;
        return GestureDetector(
          onDoubleTap: () {
            setState(() {
              if (!_likedPosts[postIndex]) {
                _likedPosts[postIndex] = true;
                _likeCounts[postIndex]++;
              }
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              posts[postIndex],
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Text(
                  "${_likeCounts[postIndex]} Likes",
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _likedPosts[postIndex] = !_likedPosts[postIndex];
                          if (_likedPosts[postIndex]) {
                            _likeCounts[postIndex]++;
                          } else {
                            _likeCounts[postIndex]--;
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            _likedPosts[postIndex]
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
                            size: 18,
                            color:
                                _likedPosts[postIndex]
                                    ? Colors.blue
                                    : Colors.grey[700],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Like",
                            style: TextStyle(
                              color:
                                  _likedPosts[postIndex]
                                      ? Colors.blue
                                      : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showCommentsSheet(context, postIndex),
                      child: _reactionButton(Icons.comment_outlined, "Comment"),
                    ),
                    _reactionButton(Icons.share_outlined, "Share"),
                  ],
                ),
              ),
              const Divider(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _reactionButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(color: Colors.grey[700])),
      ],
    );
  }

  /// ✅ Handle Navigation
  Widget _getPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildMainFeed();
      case 1:
        return ReelsPage(onBack: () => setState(() => _selectedIndex = 0));
      case 2:
        return MarketplaceItem(
          image:
              'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg',
          title: 'iPhone 14 Pro Max',
          price: 'Rs. 225,000/=',
          location: 'Karachi, Pakistan',
          onBack: () => setState(() => _selectedIndex = 0),
          floatingActionButton: null,
          child: null,
        );
      case 3:
        return const Center(child: Text('Messenger Screen Coming Soon'));
      case 4:
        return const ProfilePage();
      case 5: // ✅ Card Stack Page
        return CardsStackPage();
      default:
        return const SizedBox.shrink();
    }
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
        elevation: 1,
      ),
      body: _getPage(),
      floatingActionButton:
          _selectedIndex == 0
              ? FloatingActionButton(
                onPressed: _showPostOptions,
                child: const Icon(Icons.add),
              )
              : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: 'Cards',
          ), // ✅ Added
        ],
      ),
    );
  }
}
