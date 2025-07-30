import 'package:flutter/material.dart';
import 'package:fbreplica/stories.dart';
import 'package:fbreplica/post.dart';
import 'package:fbreplica/post_simple_form.dart' as simple;
import 'package:fbreplica/post_pic_form.dart' as pic;
import 'package:fbreplica/post_vid_form.dart' as vid;
import 'package:fbreplica/widgets/postwidget.dart';
import 'package:fbreplica/reels_page.dart';
import 'package:fbreplica/cardstack.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Post> _posts = [];

  void _addPost(Post post) {
    setState(() {
      _posts.insert(0, post);
    });
  }

  void _showPostOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Column(
            mainAxisSize: MainAxisSize.min,
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
                          (_) => simple.PostSimpleForm(
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
                      builder: (_) => pic.PostPicForm(onSubmit: _addPost),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text('Video Post'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => vid.PostVidForm(
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

  int _currentIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildMainFeed(),
      ReelsPage(onBack: () {}),
      const CardsStackPage(),
    ]);
  }

  Widget _buildMainFeed() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StoriesWidget(), // Use your existing stories.dart here
        ),
        for (final post in _posts) PostWidget(post: post),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Facebook', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _showPostOptions),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_carousel),
            label: 'Cards',
          ),
        ],
      ),
    );
  }
}
