// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'file_picker_helper.dart';
import 'widgets/image_post_widget.dart';

class PostPicForm extends StatefulWidget {
  const PostPicForm({super.key});

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

    final post = ImagePostWidget(
      username: "You",
      timestamp: "Just now",
      content: _captionController.text.trim(),
      profileImage: 'assets/images/ahc.jpg',
      postImage: _pickedFile!.file?.path,
      postBytes: _pickedFile!.bytes,
    );

    Navigator.pop(context, post);
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
