import 'package:flutter/material.dart';
import 'story_view_screen.dart';
import 'post_simple_form.dart'; // Make sure you have this
import 'post_pic_form.dart'; // Optional
import 'post_vid_form.dart'; // Optional

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Map<String, String>> stories = [
    {
      'storyImage':
          'https://images.unsplash.com/photo-1603415526960-f7e0328f0796',
      'username': 'Alice',
      'profileImage':
          'https://images.unsplash.com/photo-1607746882042-944635dfe10e',
    },
    {
      'storyImage':
          'https://images.unsplash.com/photo-1607746882042-944635dfe10e',
      'username': 'Bob',
      'profileImage':
          'https://images.unsplash.com/photo-1603415526960-f7e0328f0796',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
                title: const Text("Text Post"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostSimpleForm(initialContent: ''),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Picture Post"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostPicForm(initialContent: ''),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text("Video Post"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) =>
                              PostVidForm(initialContent: '', initialVideo: ''),
                    ),
                  );
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Facebook Replica"),
        backgroundColor: const Color(0xFF1877F2),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildStorySection(context);
          } else {
            return _buildPost(index);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPostOptions,
        backgroundColor: const Color(0xFF1877F2),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF1877F2),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_outlined),
            label: "Reels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: "Marketplace",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildStorySection(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => StoryViewScreen(
                            imageUrl: stories[i]['storyImage']!,
                            username: stories[i]['username']!,
                            profileImage: stories[i]['profileImage']!,
                          ),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(stories[i]['storyImage']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        stories[i]['username']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(height: 24),
      ],
    );
  }

  Widget _buildPost(int index) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61',
                ),
              ),
              title: Text('User $index'),
              subtitle: const Text('2 hrs ago'),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('This is a post caption.'),
            ),
            Image.network(
              'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.thumb_up_alt_outlined, size: 20),
                  SizedBox(width: 4),
                  Text("Like"),
                  SizedBox(width: 16),
                  Icon(Icons.comment_outlined, size: 20),
                  SizedBox(width: 4),
                  Text("Comment"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
