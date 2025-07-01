import 'package:flutter/material.dart';

class VideoPostPage extends StatelessWidget {
  const VideoPostPage({
    super.key,
    required String timestamp,
    required String username,
    required String content,
    required String profileImage,
    required String videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController captionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Video Post'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simulated Video Preview
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.black12,
              child: const Center(
                child: Icon(Icons.videocam, size: 80, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),

            // Caption Field
            TextField(
              controller: captionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Add a caption for your video...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Post Button
            ElevatedButton.icon(
              onPressed: () {
                String caption = captionController.text.trim();
                if (caption.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Video post submitted!')),
                  );
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.send),
              label: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
