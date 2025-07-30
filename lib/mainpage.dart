import 'package:flutter/material.dart';
import 'post_simple_form.dart';
import 'post_pic_form.dart';
import 'post_vid_form.dart';
import 'reels_page.dart';
import 'cardstack.dart';
import 'post.dart';
import 'stories.dart' show Story;
import 'widgets/postwidget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          (_) => Wrap(
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
                            onPostCreated: (Post post) {},
                            onPost: (Map<String, dynamic> post) {},
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
                          (_) => PostPicForm(
                            onSubmit: _addPost,
                            initialContent: '',
                            onPostCreated: (Post post) {},
                            onPost: (Map<String, dynamic> post) {},
                          ),
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

  int _currentIndex = 0;

  final List<Widget> _tabs = [];

  List<Story>? get storyList => null;

  @override
  void initState() {
    super.initState();
    _tabs.add(_buildHome());
    _tabs.add(
      ReelsPage(
        onBack: () {
          setState(() => _currentIndex = 0);
        },
      ),
    );
    _tabs.add(const CardsStackPage());
  }

  Widget _buildHome() {
    return ListView(
      children: [
        _buildStories(storyList!),
        const SizedBox(height: 10),
        ...posts.map((post) => PostWidget(post: post)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text('Facebook', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _showPostOptions,
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        selectedItemColor: Colors.blue[800],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: "Reels",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: "Cards"),
        ],
      ),
    );
  }

  Widget _buildStories(List<Story> stories) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Implement story tap logic if needed
              },
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(story.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      story.userName,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
