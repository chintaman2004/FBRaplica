import 'package:flutter/material.dart';
import 'package:fbreplica/post.dart';

class PostSimpleForm extends StatefulWidget {
  const PostSimpleForm({
    super.key,
    required void Function(Post post) onSubmit,
    required String initialContent,
    required Null Function(Post post) onPostCreated,
    required Null Function(Map<String, dynamic> post) onPost,
  });

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

    final newPost = Post(
      id: DateTime.now().toString(),
      username: "You",
      content: content,
      imageUrl: null,
      videoUrl: null,
    );

    Navigator.pop(context, newPost); // return Post to mainpage.dart
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
