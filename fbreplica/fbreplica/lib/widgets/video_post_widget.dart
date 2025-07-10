import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPostWidget extends StatefulWidget {
  final String username;
  final String timestamp;
  final String content;
  final String profileImage;
  final String videoUrl; // for mobile/desktop
  final Uint8List? videoBytes; // for web

  const VideoPostWidget({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.profileImage,
    required this.videoUrl,
    this.videoBytes,
    required String postImage,
  });

  @override
  State<VideoPostWidget> createState() => _VideoPostWidgetState();
}

class _VideoPostWidgetState extends State<VideoPostWidget> {
  VideoPlayerController? _ctl;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb && widget.videoUrl.isNotEmpty) {
      _ctl = VideoPlayerController.file(File(widget.videoUrl))
        ..initialize().then((_) {
          setState(() {});
          _ctl!.setLooping(true);
          _ctl!.play();
        });
    }
  }

  @override
  void dispose() {
    _ctl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget videoContent;

    if (kIsWeb) {
      videoContent = Container(
        height: 200,
        color: Colors.black12,
        alignment: Alignment.center,
        child: Text(
          widget.videoBytes != null
              ? "🎥 Video selected (Web preview not supported)"
              : "⚠️ No video available",
          style: const TextStyle(color: Colors.grey),
        ),
      );
    } else if (_ctl != null && _ctl!.value.isInitialized) {
      videoContent = AspectRatio(
        aspectRatio: _ctl!.value.aspectRatio,
        child: VideoPlayer(_ctl!),
      );
    } else {
      videoContent = const Padding(
        padding: EdgeInsets.all(12),
        child: Text("⚠️ Video unavailable"),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          if (widget.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(widget.content),
            ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
            child: videoContent,
          ),
        ],
      ),
    );
  }
}
