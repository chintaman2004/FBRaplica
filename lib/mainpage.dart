import 'package:flutter/material.dart';
import 'package:fbreplica/post.dart';
import 'package:fbreplica/widgets/postWidget.dart';
import 'package:fbreplica/reels_page.dart';
import 'package:fbreplica/cardstack.dart';
import 'package:fbreplica/post_simple_form.dart';
import 'package:fbreplica/post_pic_form.dart';
import 'package:fbreplica/post_vid_form.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Post> posts = [];

  List<Map<String, String>>? get storyList => null;

  void _onAddPost(Post post) {
    setState(() {
      posts.insert(0, post);
    });
  }

  void _onAddButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text('Text Post'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => PostSimpleForm(
                            initialContent: '',
                            onPostCreated: (Post post) {},
                            onPost: (Map<String, dynamic> post) {},
                          ),
                    ),
                  );
                  if (result is Post) _onAddPost(result);
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
                      builder:
                          (_) => PostPicForm(
                            initialContent: '',
                            onPostCreated: (Post post) {},
                            onPost: (Map<String, dynamic> post) {},
                          ),
                    ),
                  );
                  if (result is Post) _onAddPost(result);
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
                      builder:
                          (_) => PostVidForm(
                            initialContent: '',
                            initialVideo: '',
                            onPostCreated: (Post post) {},
                            onPost: (Map<String, dynamic> post) {},
                          ),
                    ),
                  );
                  if (result is Post) _onAddPost(result);
                },
              ),
            ],
          ),
    );
  }

  Widget _buildStories(List<Map<String, String>> stories) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullScreenStory(imagePath: story['image']!),
                ),
              );
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(story['image']!),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(8),
              child: Text(
                story['username']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.black45,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return ListView(
          children: [
            _buildStories(storyList!),
            const SizedBox(height: 10),
            ...posts.map((post) => PostWidget(post: post)),
          ],
        );
      case 1:
        return ReelsPage(onBack: () {});
      case 2:
        return const CardsStackPage();
      default:
        return const Center(child: Text('Unknown Page'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Facebook', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _onAddButtonPressed,
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Reels',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Cards'),
        ],
      ),
    );
  }
}

class FullScreenStory extends StatelessWidget {
  final String imagePath;
  const FullScreenStory({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
