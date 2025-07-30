import 'package:flutter/material.dart';
import 'post.dart';
import 'post_simple_form.dart';
import 'post_pic_form.dart';
import 'post_vid_form.dart';
import 'widgets/postwidget.dart';
import 'reels_page.dart';
import 'stories.dart';
import 'marketplace.dart';
import 'profilepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Post> posts = [];

  void _addPost(Post post) {
    setState(() {
      posts.insert(0, post);
    });
  }

  void _showPostOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text('Text Post'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => PostSimpleForm(
                            onSubmit: _addPost,
                            initialContent: '',
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
                      builder: (_) => PostPicForm(onSubmit: _addPost),
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
                          (_) => PostVidForm(
                            onSubmit: _addPost,
                            initialContent: '',
                            initialVideo: '',
                            onPostCreated: (Post post) {},
                            onPost: (Map<String, dynamic> post) {},
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 180,
                child: StoriesWidget(), // Use your custom story widget
              ),
            ),
            Expanded(
              child:
                  posts.isEmpty
                      ? const Center(child: Text('No posts yet'))
                      : ListView.builder(
                        itemCount: posts.length,
                        itemBuilder:
                            (context, index) => PostWidget(post: posts[index]),
                      ),
            ),
          ],
        );
      case 1:
        return ReelsPage(onBack: () {});
      case 2:
        return MarketplacePage();
      case 3:
        return ProfilePage();
      default:
        return const Center(child: Text('Unknown tab'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _showPostOptions,
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Marketplace',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
