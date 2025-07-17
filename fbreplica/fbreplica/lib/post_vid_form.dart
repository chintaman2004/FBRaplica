import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'file_picker_helper.dart';
import 'widgets/video_post_widget.dart';

class PostVidForm extends StatefulWidget {
  const PostVidForm({
    super.key,
    required String initialContent,
    required String initialVideo,
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
      if (kDebugMode) print("⚠️ No video selected");
    }
  }

  void _submitPost() {
    if (_pickedVideo == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a video')));
      return;
    }

    final post = VideoPostWidget(
      username: 'You',
      timestamp: 'Just now',
      content: _contentController.text,
      profileImage: 'assets/images/ahc.jpg',
      videoUrl: _pickedVideo?.file?.path ?? '',
      videoBytes: _pickedVideo?.bytes,
      postImage: '',
    );

    Navigator.pop(context, post);
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
