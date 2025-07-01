import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'widgets/image_post_widget.dart';

class PostPicForm extends StatefulWidget {
  const PostPicForm({super.key});

  @override
  State<PostPicForm> createState() => _PostPicFormState();
}

class _PostPicFormState extends State<PostPicForm> {
  final TextEditingController _controller = TextEditingController();
  File? _selectedImageFile; // For desktop/mobile
  String? _selectedImagePath; // For web or fallback

  void _submitPost() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    if (_selectedImageFile == null && _selectedImagePath == null) {
      // No image selected, you can show a warning or proceed with default image
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
            _selectedImagePath ??
            _selectedImageFile?.path ??
            'assets/images/mas.jpg',
      ),
    );
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      // For web, path might be null, use bytes or name instead
      if (result.files.single.path != null) {
        setState(() {
          _selectedImageFile = File(result.files.single.path!);
          _selectedImagePath = null;
        });
      } else {
        // Web fallback: use bytes or name
        setState(() {
          _selectedImagePath = result.files.single.name; // or handle bytes
          _selectedImageFile = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (_selectedImageFile != null) {
      imageWidget = Image.file(
        _selectedImageFile!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else if (_selectedImagePath != null) {
      // For web, you might want to handle differently
      imageWidget = Text('Selected image: $_selectedImagePath');
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
