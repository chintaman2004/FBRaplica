// lib/post_simple_form.dart
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
    if (_contentController.text.trim().isEmpty) return;

    final post = TextPostWidget(
      username: 'You',
      timestamp: 'Just now',
      content: _contentController.text,
      profileImage: 'assets/images/ahc.jpg',
    );

    Navigator.pop(context, post);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Create Text Post')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(labelText: 'Write something...'),
            maxLines: 4,
          ),
          const Spacer(),
          ElevatedButton(onPressed: _submitPost, child: const Text('Post')),
        ],
      ),
    ),
  );
}
