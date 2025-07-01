// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPostWidget extends StatefulWidget {
  final String username;
  final String timestamp;
  final String content;
  final String profileImage;
  final String videoUrl; // For mobile/desktop: file path or network URL
  final Uint8List? videoBytes; // For web: video data as bytes
  final String? postImage; // Optional thumbnail image asset path or URL

  const VideoPostWidget({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.profileImage,
    required this.videoUrl,
    this.videoBytes,
    this.postImage,
  });

  @override
  State<VideoPostWidget> createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends State<VideoPostWidget> {
  late VideoPlayerController _controller;
  bool _isMuted = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    if (kIsWeb && widget.videoBytes != null) {
      // For web, VideoPlayerController.file is not supported with bytes directly.
      // You need to create a blob URL or upload the video and use network URL.
      // Here, we show a placeholder and recommend uploading video to server.
      // For demonstration, we will not initialize video player with bytes.
      _isInitialized = false;
    } else {
      // For mobile/desktop or network URL
      if (widget.videoUrl.startsWith('http')) {
        _controller = VideoPlayerController.network(widget.videoUrl);
      } else {
        _controller = VideoPlayerController.file(File(widget.videoUrl));
      }

      _controller.initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.setLooping(true);
        _controller.play();
      });
    }
  }

  @override
  void dispose() {
    if (!_controller.value.isInitialized) {
      // If controller was never initialized, avoid disposing null
      return super.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget videoContent;

    if (kIsWeb && widget.videoBytes != null) {
      // On web, show a placeholder because playing video from bytes requires extra setup
      videoContent = Container(
        height: 200,
        color: Colors.black12,
        child: const Center(
          child: Text(
            'Video playback from local bytes is not supported on web.\nPlease upload video and use network URL.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    } else if (_isInitialized) {
      videoContent = Stack(
        alignment: Alignment.bottomRight,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          IconButton(
            icon: Icon(
              _isMuted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: _toggleMute,
          ),
        ],
      );
    } else {
      videoContent = const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile row
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

            const SizedBox(height: 10),

            // Post text
            if (widget.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(widget.content),
              ),

            // Video player or placeholder
            videoContent,
          ],
        ),
      ),
    );
  }
}
