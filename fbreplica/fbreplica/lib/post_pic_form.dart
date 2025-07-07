// lib/post_pic_form.dart
import 'package:flutter/material.dart';
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

    final post = ImagePostWidget(
      username: 'You',
      timestamp: 'Just now',
      content: _contentController.text,
      profileImage: 'assets/images/ahc.jpg',
      postImage: _pickedImage!.file?.path,
      postBytes: _pickedImage!.bytes,
    );

    Navigator.pop(context, post);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Create Image Post')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(labelText: 'Write something...'),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image),
            label: const Text('Pick Image'),
          ),
          if (_pickedImage != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text("📷 Selected: ${_pickedImage!.name}"),
            ),
          const Spacer(),
          ElevatedButton(onPressed: _submitPost, child: const Text('Post')),
        ],
      ),
    ),
  );
}
