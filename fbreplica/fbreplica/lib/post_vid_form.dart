import 'package:flutter/material.dart';
import 'file_picker_helper.dart';
import 'widgets/video_post_widget.dart';

class PostVidForm extends StatefulWidget {
  const PostVidForm({super.key});

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
    }
  }

  void _submitPost() {
    if (_pickedVideo == null) return;

    final widgetToReturn = VideoPostWidget(
      username: 'You',
      timestamp: 'Just now',
      content: _contentController.text,
      profileImage: 'assets/images/ahc.jpg',
      videoUrl: _pickedVideo!.file?.path ?? '',
      postImage: '', // You can provide a thumbnail later
    );

    Navigator.pop(context, widgetToReturn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Video Post")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Say something...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickVideo,
              icon: const Icon(Icons.videocam),
              label: const Text("Pick Video"),
            ),
            const SizedBox(height: 16),
            if (_pickedVideo != null)
              Text("Video selected: ${_pickedVideo!.name}"),
            const Spacer(),
            ElevatedButton(
              onPressed: _pickedVideo != null ? _submitPost : null,
              child: const Text("Post"),
            ),
          ],
        ),
      ),
    );
  }
}
