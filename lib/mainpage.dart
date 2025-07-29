// ignore_for_file: strict_top_level_inference

import 'package:flutter/material.dart';
import 'post.dart';
import 'stories.dart';
import 'story_widget.dart';
import 'story_fullscreen.dart';
import 'cardstack.dart';
import 'reels_page.dart';
import 'widgets/postWidget.dart';

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

  void _onStoryTap(story) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => StoryFullScreen(story: story, imageUrl: '', userName: ''),
      ),
    );
  }

  void _onAddPost() {
    setState(() {
      posts.insert(
        0,
        Post(
          id: DateTime.now().toString(),
          username: 'New User',
          content: 'New post added!',
          imageUrl: 'assets/images/sample1.jpg',
        ),
      );
    });
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ReelsPage(onBack: () {})),
      ).then((_) {
        setState(() => _selectedIndex = 0); // Return to main
      });
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CardsStackPage()),
      ).then((_) {
        setState(() => _selectedIndex = 0); // Return to main
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
        iconTheme: const IconThemeData(color: Colors.white),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video),
            label: 'Reels',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Cards'),
        ],
      ),
    );
  }
}
