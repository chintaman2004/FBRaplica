import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'widgets/video_post_widget.dart';

class PostVidForm extends StatefulWidget {
  const PostVidForm({super.key});

  @override
  State<PostVidForm> createState() => _PostVidFormState();
}

class _PostVidFormState extends State<PostVidForm> {
  final TextEditingController _controller = TextEditingController();
  File? _selectedVideoFile;
  String? _selectedVideoPath;

  void _submitPost() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    if (_selectedVideoFile == null && _selectedVideoPath == null) {
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
            _selectedVideoPath ??
            _selectedVideoFile?.path ??
            'assets/videos/vid1.mp4',
        postImage: '', // optionally add a thumbnail here
      ),
    );
  }

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.isNotEmpty) {
      if (result.files.single.path != null) {
        setState(() {
          _selectedVideoFile = File(result.files.single.path!);
          _selectedVideoPath = null;
        });
      } else {
        setState(() {
          _selectedVideoPath = result.files.single.name;
          _selectedVideoFile = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget videoPreview;

    if (_selectedVideoFile != null) {
      videoPreview = Center(
        child: Text(
          'Selected video:\n${_selectedVideoFile!.path.split('/').last}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      );
    } else if (_selectedVideoPath != null) {
      videoPreview = Center(
        child: Text(
          'Selected video:\n$_selectedVideoPath',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
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
