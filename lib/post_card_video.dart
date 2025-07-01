import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostCardVideo extends StatefulWidget {
  final String username;
  final String timestamp;
  final String content;
  final String profileImage;
  final String videoUrl;

  const PostCardVideo({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.profileImage,
    required this.videoUrl,
  });

  @override
  State<PostCardVideo> createState() => _PostCardVideoState();
}

class _PostCardVideoState extends State<PostCardVideo> {
  late VideoPlayerController _controller;
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.videoUrl.startsWith('http')
            ? VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
            : VideoPlayerController.asset(widget.videoUrl);

    _controller.initialize().then((_) {
      setState(() {});
      _controller.setLooping(true);
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleMute() {
    setState(() {
      isMuted = !isMuted;
      _controller.setVolume(isMuted ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    widget.profileImage,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.timestamp,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Content
            if (widget.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(widget.content),
              ),

            // Video
            AspectRatio(
              aspectRatio:
                  _controller.value.isInitialized
                      ? _controller.value.aspectRatio
                      : 16 / 9,
              child:
                  _controller.value.isInitialized
                      ? Stack(
                        children: [
                          VideoPlayer(_controller),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                isMuted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.white,
                              ),
                              onPressed: toggleMute,
                            ),
                          ),
                        ],
                      )
                      : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
