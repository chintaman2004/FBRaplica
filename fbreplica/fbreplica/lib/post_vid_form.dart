import 'package:flutter/material.dart';
import 'widgets/video_post_widget.dart';

class PostVidForm extends StatefulWidget {
  const PostVidForm({super.key});

  @override
  State<PostVidForm> createState() => _PostVidFormState();
}

class _PostVidFormState extends State<PostVidForm> {
  final TextEditingController _contentController = TextEditingController();

  String? _selectedVideo;
  String? _selectedImage;

  final List<String> availableVideos = [
    'assets/videos/vid1.mp4',
    'assets/videos/vid2.mp4',
  ];

  final List<String> availableImages = [
    'assets/images/mas.jpg',
    'assets/images/4.jpg',
    'assets/images/2.jpg',
  ];

  void _submitPost() {
    final content = _contentController.text.trim();

    if (_selectedVideo != null) {
      Navigator.pop(
        context,
        VideoPostWidget(
          username: 'Your Name',
          timestamp: 'Just now',
          content: content,
          profileImage: 'assets/images/ahc.jpg',
          videoUrl: _selectedVideo!,
          postImage: _selectedImage ?? '',
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a video')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Video Post'),
        actions: [
          TextButton(
            onPressed: _submitPost,
            child: const Text(
              'Post',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _contentController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Say something...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Video:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 10,
              children:
                  availableVideos.map((videoPath) {
                    return ChoiceChip(
                      label: Text(videoPath.split('/').last),
                      selected: _selectedVideo == videoPath,
                      onSelected: (_) {
                        setState(() {
                          _selectedVideo = videoPath;
                        });
                      },
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Optional Cover Image:'),
            Wrap(
              spacing: 10,
              children:
                  availableImages.map((img) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImage = img;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                _selectedImage == img
                                    ? Colors.blue
                                    : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: Image.asset(
                          img,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
