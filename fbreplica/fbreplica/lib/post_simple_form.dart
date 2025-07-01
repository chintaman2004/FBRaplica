import 'package:flutter/material.dart';
import 'widgets/text_post_widget.dart';

class PostSimpleForm extends StatefulWidget {
  const PostSimpleForm({super.key});

  @override
  State<PostSimpleForm> createState() => _PostSimpleFormState();
}

class _PostSimpleFormState extends State<PostSimpleForm> {
  final TextEditingController _controller = TextEditingController();

  void _submitPost() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    Navigator.pop(
      context,
      TextPostWidget(
        username: 'Your Name',
        timestamp: 'Just now',
        content: content,
        profileImage: 'assets/images/ahc.jpg',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Text Post'),
        actions: [
          TextButton(
            onPressed: _submitPost,
            child: const Text('Post', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _submitPost, child: const Text('Post')),
          ],
        ),
      ),
    );
  }
}
