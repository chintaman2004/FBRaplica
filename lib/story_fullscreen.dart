import 'package:fbreplica/stories.dart';
import 'package:flutter/material.dart';

class StoryFullScreen extends StatelessWidget {
  final String imageUrl;
  final String userName;

  const StoryFullScreen({
    super.key,
    required this.imageUrl,
    required this.userName,
    required Story story,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Text(userName, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(child: Image.network(imageUrl, fit: BoxFit.contain)),
    );
  }
}
