import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Reel {
  final String username;
  final String videoPath; // Local asset or file path
  final Uint8List? videoBytes; // For web

  Reel({required this.username, required this.videoPath, this.videoBytes});
}

class ReelsPage extends StatelessWidget {
  const ReelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Reel> demoReels = [
      Reel(username: 'Ahmed', videoPath: 'assets/videos/vid1.mp4'),
      Reel(username: 'Sara', videoPath: 'assets/videos/vid2.mp4'),
      // Add more if you like
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reels"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: demoReels.length,
        itemBuilder: (context, index) {
          final reel = demoReels[index];
          return ReelPlayer(reel: reel);
        },
      ),
    );
  }
}

class ReelPlayer extends StatefulWidget {
  final Reel reel;

  const ReelPlayer({super.key, required this.reel});

  @override
  State<ReelPlayer> createState() => _ReelPlayerState();
}

class _ReelPlayerState extends State<ReelPlayer> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // Web video playback from local bytes not supported
      return;
    }

    _controller = VideoPlayerController.asset(widget.reel.videoPath);
    _controller!.initialize().then((_) {
      setState(() {});
      _controller!.setLooping(true);
      _controller!.play();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            "⚠️ Video reels not supported on Flutter Web using local files.\nTry running on mobile or desktop.",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller!.value.size.width,
            height: _controller!.value.size.height,
            child: VideoPlayer(_controller!),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: Text(
            widget.reel.username,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 6, color: Colors.black)],
            ),
          ),
        ),
      ],
    );
  }
}
