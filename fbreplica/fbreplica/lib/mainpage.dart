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
  /// Demo Posts
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

  /// Show post options bottom sheet
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

  /// Demo Stories
  final List<Story> demoStories = [
    Story(
      imageUrl:
          'https://images.pexels.com/photos/2170387/pexels-photo-2170387.jpeg',
      userName: 'Ahmed',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/1186116/pexels-photo-1186116.jpeg',
      userName: 'Sara',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/757828/pexels-photo-757828.jpeg',
      userName: 'AAA',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/2070485/pexels-photo-2070485.jpeg',
      userName: 'Alizay',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/2728252/pexels-photo-2728252.jpeg',
      userName: 'Yoyo',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/753339/pexels-photo-753339.jpeg',
      userName: 'New',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/1844648/pexels-photo-1844648.jpeg',
      userName: 'AK',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/2884867/pexels-photo-2884867.jpeg',
      userName: 'NYT',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/1122407/pexels-photo-1122407.jpeg',
      userName: 'Physco',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/2114229/pexels-photo-2114229.jpeg',
      userName: 'Lil',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/3811074/pexels-photo-3811074.jpeg',
      userName: 'Lil',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/1507856/pexels-photo-1507856.jpeg',
      userName: 'Kitty',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/2730218/pexels-photo-2730218.jpeg',
      userName: 'Knight Rider',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/3185480/pexels-photo-3185480.jpeg',
      userName: 'History',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/2114333/pexels-photo-2114333.jpeg',
      userName: 'Tribal',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/2406731/pexels-photo-2406731.jpeg',
      userName: 'Azaan',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/1122410/pexels-photo-1122410.jpeg',
      userName: 'Vision',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/1446161/pexels-photo-1446161.jpeg',
      userName: 'Indian',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/3889908/pexels-photo-3889908.jpeg',
      userName: 'Eyes',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/302457/pexels-photo-302457.jpeg',
      userName: 'Artist',
    ),
    Story(
      imageUrl:
          'https://images.pexels.com/photos/3243020/pexels-photo-3243020.jpeg',
      userName: 'New',
    ),
  ];

  /// Build Main Feed
  Widget _buildMainFeed() {
    return ListView(
      children: [
        const SizedBox(height: 12),
        StoryWidget(stories: demoStories),
        const Divider(height: 24),
        ...posts,
        const SizedBox(height: 100),
      ],
    );
  }

  /// Build Body (with FIXED ERROR)
  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return _buildMainFeed();
    } else if (_selectedIndex == 1) {
      return ReelsPage(
        onBack: () {
          setState(() {
            _selectedIndex = 0;
          });
        },
      );
    } else if (_selectedIndex == 2) {
      return Scaffold(
        body: MarketplaceItem(
          image: 'assets/images/14promax.jpg',
          title: 'iPhone 14 Pro Max',
          price: 'Rs. 225,000/=',
          location: 'Karachi, Pakistan',
          onBack: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
          floatingActionButton: null,
          child: null,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add Marketplace Posting Logic Here
          },
          child: const Icon(Icons.add),
        ),
      );
    } else if (_selectedIndex == 3) {
      return const Center(child: Text('Messenger'));
    } else if (_selectedIndex == 4) {
      return const ProfilePage();
    } else {
      return const SizedBox.shrink(); // ✅ Ensures Widget Always Returns
    }
  }

  /// Bottom Navigation Action
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
          /// Navigation Bar
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showPostOptions,
        child: const Icon(Icons.add),
      ),
    );
  }
}
