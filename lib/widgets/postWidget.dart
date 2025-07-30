import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fbreplica/post.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.post.videoUrl != null && widget.post.videoUrl!.isNotEmpty) {
      _videoController = VideoPlayerController.asset(widget.post.videoUrl!)
        ..initialize().then((_) {
          setState(() {});
          _videoController?.setLooping(true);
          _videoController?.play(); // autoplay
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void toggleLike() {
    setState(() {
      widget.post.isLiked = !widget.post.isLiked;
    });
  }

  void openComments(BuildContext context) {
    final commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.post.comments.length,
                  itemBuilder: (_, index) {
                    return ListTile(title: Text(widget.post.comments[index]));
                  },
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
                        final text = commentController.text.trim();
                        if (text.isNotEmpty) {
                          setState(() {
                            widget.post.comments.add(text);
                          });
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
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
          ListTile(title: Text(post.username), subtitle: Text(post.timestamp)),
          if (post.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(post.content),
            ),
          if (post.imageBytes != null)
            Image.memory(post.imageBytes!, fit: BoxFit.cover),
          if (_videoController != null && _videoController!.value.isInitialized)
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
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
