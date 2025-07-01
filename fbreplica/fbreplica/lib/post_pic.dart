import 'package:flutter/material.dart';

class ImagePostPage extends StatelessWidget {
  const ImagePostPage({
    super.key,
    required String username,
    required String timestamp,
    required String profileImage,
    required String postImage,
    required String content,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController captionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Photo Post'),
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
            // Simulated Image Preview
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image, size: 80, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),

            // Caption Field
            TextField(
              controller: captionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Write a caption...',
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
                    const SnackBar(content: Text('Image post submitted!')),
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
