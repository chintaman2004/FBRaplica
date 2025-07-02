import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'file_picker_helper.dart';
import 'widgets/image_post_widget.dart';

class PostPicForm extends StatefulWidget {
  const PostPicForm({super.key});

  @override
  State<PostPicForm> createState() => _PostPicFormState();
}

class _PostPicFormState extends State<PostPicForm> {
  final TextEditingController _contentController = TextEditingController();
  PickedFile? _pickedImage;

  void _pickImage() async {
    final image = await FilePickerHelper.pickImage();
    if (image != null) {
      setState(() => _pickedImage = image);
    }
  }

  void _submitPost() {
    if (_pickedImage == null) return;

    final widgetToReturn = ImagePostWidget(
      username: 'You',
      timestamp: 'Just now',
      content: _contentController.text,
      profileImage: 'assets/images/ahc.jpg',
      postImage: _pickedImage!.file?.path ?? '', // Only valid for non-web
    );

    Navigator.pop(context, widgetToReturn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Image Post")),
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
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Pick Image"),
            ),
            const SizedBox(height: 16),
            if (_pickedImage != null)
              kIsWeb
                  ? Image.memory(_pickedImage!.bytes!)
                  : Image.file(_pickedImage!.file!, height: 200),
            const Spacer(),
            ElevatedButton(
              onPressed: _pickedImage != null ? _submitPost : null,
              child: const Text("Post"),
            ),
          ],
        ),
      ),
    );
  }
}
