import 'package:flutter/material.dart';
import 'post.dart';
import 'postwidget.dart';
import 'story_fullscreen.dart';
import 'story_widget.dart';
import 'stories.dart';
import 'cardstack.dart'; // Make sure this import points to CardsStackPage

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Post> posts = [
    Post(
      id: '1',
      username: 'John Doe',
      content: 'Hello, this is my first post!',
      imageUrl: 'assets/images/sample1.jpg',
    ),
    Post(
      id: '2',
      username: 'Jane Smith',
      content: 'Loving this new app! ❤️',
      imageUrl: 'assets/images/sample2.jpg',
    ),
    Post(id: '3', username: 'Ali Khan', content: 'What a beautiful day!'),
  ];

  void _onStoryTap(Story story) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => StoryFullScreen(story: story, imageUrl: '', userName: ''),
      ),
    );
  }

  void _onAddPost() {
    debugPrint("Add post pressed");
  }

  void _onItemTapped(int index) {
    if (index == 4) {
      // Navigate to CardsStackPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CardsStackPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  static const List<BottomNavigationBarItem> _bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.ondemand_video), label: 'Videos'),
    BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
    BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
    BottomNavigationBarItem(
      icon: Icon(Icons.view_carousel),
      label: 'Cards',
    ), // NEW TAB
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _onAddPost,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StoryWidget(stories: demoStories, onStoryTap: _onStoryTap),
            const SizedBox(height: 10),
            ...posts.map((post) => PostWidget(post: post)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPost,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: _bottomItems,
      ),
    );
  }
}
