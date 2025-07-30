// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fbreplica/post.dart';
import 'file_picker_helper.dart';

class PostVidForm extends StatefulWidget {
  const PostVidForm({
    super.key,
    required void Function(Post post) onSubmit,
    required String initialContent,
    required String initialVideo,
    required Null Function(Post post) onPostCreated,
    required Null Function(Map<String, dynamic> post) onPost,
  });

  @override
  State<PostVidForm> createState() => _PostVidFormState();
}

class _PostVidFormState extends State<PostVidForm> {
  final TextEditingController _contentController = TextEditingController();
  PickedFile? _pickedVideo;

  void _pickVideo() async {
    final video = await FilePickerHelper.pickVideo();
    if (video != null) {
      setState(() => _pickedVideo = video);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No video selected')));
    }
  }

  void _submitPost() {
    if (_pickedVideo == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a video')));
      return;
    }

    final newPost = Post(
      id: DateTime.now().toString(),
      username: 'You',
      content: _contentController.text.trim(),
      imageUrl: null,
      videoUrl: _pickedVideo?.file?.path ?? '',
      type: '',
      timestamp: '',
      mediaUrl: null,
    );

    Navigator.pop(context, newPost); // Return Post model to mainpage.dart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Video Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Write something...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickVideo,
              icon: const Icon(Icons.video_library),
              label: const Text('Pick Video'),
            ),
            if (_pickedVideo != null)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text("🎞️ Selected: ${_pickedVideo!.name}"),
              ),
            const Spacer(),
            ElevatedButton(onPressed: _submitPost, child: const Text('Post')),
          ],
        ),
      ),
    );
  }
}
