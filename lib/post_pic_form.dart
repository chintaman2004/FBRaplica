import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'post.dart';

class PostPicForm extends StatefulWidget {
  final Function(Post) onSubmit;

  const PostPicForm({super.key, required this.onSubmit});

  @override
  State<PostPicForm> createState() => _PostPicFormState();
}

class _PostPicFormState extends State<PostPicForm> {
  final TextEditingController _captionController = TextEditingController();
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  void _submitPost() {
    if (_imageBytes != null || _captionController.text.isNotEmpty) {
      final post = Post(
        username: 'User',
        timestamp: DateTime.now().toIso8601String(),
        content: _captionController.text,
        imageBytes: _imageBytes,
        id: '',
        type: '',
        mediaUrl: null,
        imageUrl: null,
      );
      widget.onSubmit(post);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Image Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(labelText: 'Caption'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 10),
            if (_imageBytes != null) Image.memory(_imageBytes!, height: 200),
            const Spacer(),
            ElevatedButton(onPressed: _submitPost, child: const Text('Post')),
          ],
        ),
      ),
    );
  }
}
