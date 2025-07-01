import 'package:flutter/material.dart';
import 'widgets/image_post_widget.dart';

class PostPicForm extends StatefulWidget {
  const PostPicForm({super.key});

  @override
  State<PostPicForm> createState() => _PostPicFormState();
}

class _PostPicFormState extends State<PostPicForm> {
  final TextEditingController _contentController = TextEditingController();
  String? _selectedImage;

  final List<String> availableImages = [
    'assets/images/mas.jpg',
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/4.jpg',
  ];

  void _submitPost() {
    final content = _contentController.text.trim();

    if (content.isNotEmpty && _selectedImage != null) {
      Navigator.pop(
        context,
        ImagePostWidget(
          username: 'Your Name',
          timestamp: 'Just now',
          content: content,
          profileImage: 'assets/images/ahc.jpg',
          postImage: _selectedImage!,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write content and select an image'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Image Post'),
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
        child: Column(
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
            const Text('Select Image:'),
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
