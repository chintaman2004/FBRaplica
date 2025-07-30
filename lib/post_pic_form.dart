// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fbreplica/post.dart';
import 'file_picker_helper.dart';

class PostPicForm extends StatefulWidget {
  const PostPicForm({
    super.key,
    required void Function(Post post) onSubmit,
    required String initialContent,
    required Null Function(Post post) onPostCreated,
    required Null Function(Map<String, dynamic> post) onPost,
  });

  @override
  State<PostPicForm> createState() => _PostPicFormState();
}

class _PostPicFormState extends State<PostPicForm> {
  final TextEditingController _captionController = TextEditingController();
  PickedFile? _pickedFile;

  void _pickImage() async {
    final result = await FilePickerHelper.pickImage();

    if (result != null) {
      setState(() {
        _pickedFile = result;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No image selected")));
    }
  }

  void _submitPost() {
    if (_pickedFile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an image")));
      return;
    }

    final newPost = Post(
      id: DateTime.now().toString(),
      username: "You",
      content: _captionController.text.trim(),
      imageUrl: _pickedFile!.file?.path,
      videoUrl: null,
    );

    Navigator.pop(context, newPost); // Return Post to mainpage.dart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Image Post")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                labelText: 'Write a caption...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Pick Image"),
            ),
            if (_pickedFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text("📷 Selected: ${_pickedFile!.name}"),
              ),
            const Spacer(),
            ElevatedButton(onPressed: _submitPost, child: const Text("Post")),
          ],
        ),
      ),
    );
  }
}
