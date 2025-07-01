import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'file_picker_helper.dart'; // Import the helper
import 'widgets/image_post_widget.dart';

class PostPicForm extends StatefulWidget {
  const PostPicForm({super.key});

  @override
  State<PostPicForm> createState() => _PostPicFormState();
}

class _PostPicFormState extends State<PostPicForm> {
  final TextEditingController _controller = TextEditingController();

  File? _selectedImageFile;
  Uint8List? _selectedImageBytes;

  Future<void> _pickImage() async {
    final picked = await FilePickerHelper.pickImage();
    if (picked != null) {
      setState(() {
        _selectedImageFile = picked.file;
        _selectedImageBytes = picked.bytes;
      });
    }
  }

  void _submitPost() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    if (_selectedImageFile == null && _selectedImageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image before posting.')),
      );
      return;
    }

    Navigator.pop(
      context,
      ImagePostWidget(
        username: 'Your Name',
        timestamp: 'Just now',
        content: content,
        profileImage: 'assets/images/ahc.jpg',
        postImage:
            _selectedImageFile?.path ??
            '', // For web, handle differently if needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (_selectedImageBytes != null) {
      imageWidget = Image.memory(
        _selectedImageBytes!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else if (_selectedImageFile != null) {
      imageWidget = Image.file(
        _selectedImageFile!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else {
      imageWidget = Image.asset(
        'assets/images/mas.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Image Post'),
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
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Say something about the photo...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imageWidget,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_library),
              label: const Text('Select Image from Computer'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _submitPost, child: const Text('Post')),
          ],
        ),
      ),
    );
  }
}
