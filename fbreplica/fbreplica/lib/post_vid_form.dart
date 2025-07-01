import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'file_picker_helper.dart'; // Import the helper
import 'widgets/video_post_widget.dart';

class PostVidForm extends StatefulWidget {
  const PostVidForm({super.key});

  @override
  State<PostVidForm> createState() => _PostVidFormState();
}

class _PostVidFormState extends State<PostVidForm> {
  final TextEditingController _controller = TextEditingController();

  File? _selectedVideoFile;
  Uint8List? _selectedVideoBytes;

  Future<void> _pickVideo() async {
    final picked = await FilePickerHelper.pickVideo();
    if (picked != null) {
      setState(() {
        _selectedVideoFile = picked.file;
        _selectedVideoBytes = picked.bytes;
      });
    }
  }

  void _submitPost() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    if (_selectedVideoFile == null && _selectedVideoBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a video before posting.')),
      );
      return;
    }

    Navigator.pop(
      context,
      VideoPostWidget(
        username: 'Your Name',
        timestamp: 'Just now',
        content: content,
        profileImage: 'assets/images/ahc.jpg',
        videoUrl:
            _selectedVideoFile?.path ??
            '', // For web, handle differently if needed
        postImage: '', // Optionally add a thumbnail
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget videoPreview;
    if (_selectedVideoBytes != null) {
      videoPreview = Center(
        child: Text(
          'Selected video: ${_selectedVideoBytes!.lengthInBytes} bytes',
        ),
      );
    } else if (_selectedVideoFile != null) {
      videoPreview = Center(
        child: Text(
          'Selected video: ${_selectedVideoFile!.path.split('/').last}',
        ),
      );
    } else {
      videoPreview = const Center(
        child: Icon(Icons.videocam, size: 60, color: Colors.grey),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Video Post'),
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
                hintText: 'Say something about the video...',
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
                child: videoPreview,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickVideo,
              icon: const Icon(Icons.video_library),
              label: const Text('Select Video from Computer'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _submitPost, child: const Text('Post')),
          ],
        ),
      ),
    );
  }
}
