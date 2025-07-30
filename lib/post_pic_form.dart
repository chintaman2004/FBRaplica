import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'post.dart';

class PostPicForm extends StatefulWidget {
  final Function(Post) onSubmit;
  final void Function(Post)? onPostCreated;

  const PostPicForm({super.key, required this.onSubmit, this.onPostCreated});

  @override
  State<PostPicForm> createState() => _PostPicFormState();
}

class _PostPicFormState extends State<PostPicForm> {
  final TextEditingController _captionController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitPost() {
    final caption = _captionController.text.trim();
    if (_selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an image")));
      return;
    }

    final post = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: 'Ahmed', // Replace dynamically if needed
      timestamp: DateTime.now().toString(),
      type: 'image',
      content: caption,
      mediaUrl: _selectedImage!.path, // Local file path
      imageUrl: _selectedImage!.path,
      videoUrl: null,
      isLiked: false,
      comments: [],
    );

    widget.onSubmit(post);
    widget.onPostCreated?.call(post);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Image Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 200),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text('Pick Image'),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                hintText: 'Say something about the image...',
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
