import 'package:flutter/material.dart';
import 'post.dart';

class PostSimpleForm extends StatefulWidget {
  final Function(Post) onSubmit;
  final String initialContent;
  final void Function(Post)? onPostCreated;
  final void Function(Map<String, dynamic>)? onPost;

  const PostSimpleForm({
    super.key,
    required this.onSubmit,
    required this.initialContent,
    this.onPostCreated,
    this.onPost,
  });

  @override
  State<PostSimpleForm> createState() => _PostSimpleFormState();
}

class _PostSimpleFormState extends State<PostSimpleForm> {
  final TextEditingController _controller = TextEditingController();

  void _submitPost() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    final post = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: 'Ahmed', // You can replace with logged-in username
      timestamp: DateTime.now().toString(),
      type: 'text',
      content: content,
      mediaUrl: null,
      imageUrl: null,
      videoUrl: null,
      isLiked: false,
      comments: [],
    );

    widget.onSubmit(post);
    widget.onPostCreated?.call(post); // optional callback
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Text Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'What\'s on your mind?',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submitPost, child: const Text('Post')),
          ],
        ),
      ),
    );
  }
}
