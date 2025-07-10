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
    if (content.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter some text")));
      return;
    }

    final post = TextPostWidget(
      username: 'You',
      timestamp: 'Just now',
      content: content,
      profileImage: 'assets/images/ahc.jpg', // Make sure this asset exists
    );

    Navigator.pop(context, post); // 🔁 Return to main page with post
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
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: "What's on your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submitPost, child: const Text("Post")),
          ],
        ),
      ),
    );
  }
}
