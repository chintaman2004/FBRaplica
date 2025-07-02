import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPostWidget extends StatefulWidget {
  final String username;
  final String timestamp;
  final String content;
  final String profileImage;
  final String videoUrl;
  final String postImage; // optional thumbnail

  const VideoPostWidget({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.profileImage,
    required this.videoUrl,
    this.postImage = '',
  });

  @override
  State<VideoPostWidget> createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends State<VideoPostWidget> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.profileImage),
            ),
            title: Text(
              widget.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.timestamp),
          ),

          // Content
          if (widget.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(widget.content),
            ),

          const SizedBox(height: 8),

          // Video
          _initialized
              ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),
                    IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        size: 48,
                        color: Colors.white,
                      ),
                      onPressed: _togglePlay,
                    ),
                  ],
                ),
              )
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
