import 'package:flutter/material.dart';
import 'widgets/text_post_widget.dart';

class PostSimpleForm extends StatefulWidget {
  const PostSimpleForm({super.key});

  @override
  State<PostSimpleForm> createState() => _PostSimpleFormState();
}

class _PostSimpleFormState extends State<PostSimpleForm> {
  final TextEditingController _contentController = TextEditingController();

  void _submitPost() {
    final content = _contentController.text.trim();

    if (content.isNotEmpty) {
      Navigator.pop(
        context,
        TextPostWidget(
          username: 'Your Name',
          timestamp: 'Just now',
          content: content,
          profileImage: 'assets/images/ahc.jpg',
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post content cannot be empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Text Post'),
        actions: [
          TextButton(
            onPressed: _submitPost,
            child: const Text(
              'Post',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _contentController,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'What\'s on your mind?',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
