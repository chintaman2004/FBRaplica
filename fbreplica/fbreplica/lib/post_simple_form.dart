import 'package:flutter/material.dart';
import 'widgets/text_post_widget.dart'; // Ensure this path is correct

class PostSimpleForm extends StatefulWidget {
  const PostSimpleForm({super.key});

  @override
  State<PostSimpleForm> createState() => _PostSimpleFormState();
}

class _PostSimpleFormState extends State<PostSimpleForm> {
  final TextEditingController _controller = TextEditingController();

  void _submitPost() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      // Create the widget to return
      final newPost = TextPostWidget(
        username: 'Ahmed Hassan',
        timestamp: 'Just now',
        content: text,
        profileImage: 'assets/images/ahc.jpg',
      );

      Navigator.pop(context, newPost); // Return it to MainPage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Text Post")),
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
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text("Post"),
              onPressed: _submitPost,
            ),
          ],
        ),
      ),
    );
  }
}
