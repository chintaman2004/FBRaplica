// ignore_for_file: file_names, dead_code

import 'package:fbreplica/post.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  void toggleLike() {
    setState(() {
      widget.post.isLiked = !widget.post.isLiked;
    });
  }

  void openComments(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.post.comments.length,
                itemBuilder:
                    (_, index) =>
                        ListTile(title: Text(widget.post.comments[index])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: commentController)),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      setState(() {
                        widget.post.comments.add(commentController.text);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(post.username),
            subtitle: const Text("Just now"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.content),
          ),
          if (post.imageUrl != null)
            Image.asset(post.imageUrl!, fit: BoxFit.cover),
          if (post.videoUrl != null)
            Container(height: 200, color: Colors.black), // For now
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                icon: Icon(
                  Icons.thumb_up,
                  color: post.isLiked ? Colors.blue : Colors.grey,
                ),
                label: Text(
                  "Like",
                  style: TextStyle(
                    color: post.isLiked ? Colors.blue : Colors.grey,
                  ),
                ),
                onPressed: toggleLike,
              ),
              TextButton.icon(
                icon: const Icon(Icons.comment, color: Colors.grey),
                label: const Text(
                  "Comment",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () => openComments(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
