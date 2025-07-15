// ignore_for_file: deprecated_member_use

import 'package:fbreplica/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:typed_data';

class Reel {
  final String username;
  final String videoPath;
  final Uint8List? videoBytes;
  final String profileImage;

  Reel({
    required this.username,
    required this.videoPath,
    this.videoBytes,
    required this.profileImage,
  });
}

class ReelsPage extends StatelessWidget {
  const ReelsPage({super.key, required void Function() onBack});

  @override
  Widget build(BuildContext context) {
    final List<Reel> demoReels = [
      Reel(
        username: 'Ahmed',
        videoPath:
            'https://videos.pexels.com/video-files/7195645/7195645-uhd_1440_2732_25fps.mp4',
        profileImage: 'assets/images/ahc.jpg',
      ),
      Reel(
        username: 'Sara',
        videoPath:
            'https://videos.pexels.com/video-files/7605030/7605030-uhd_1440_2732_25fps.mp4',
        profileImage: 'assets/images/2.jpg',
      ),
      Reel(
        username: 'Alizay',
        videoPath:
            'https://videos.pexels.com/video-files/4973030/4973030-uhd_1440_2732_25fps.mp4',
        profileImage: 'assets/images/3.jpg',
      ),
      Reel(
        username: 'Smith',
        videoPath:
            'https://videos.pexels.com/video-files/32994649/14061926_1080_1920_30fps.mp4',
        profileImage: 'assets/images/4.jpg',
      ),
      Reel(
        username: 'Abdul',
        videoPath:
            'https://videos.pexels.com/video-files/32722668/13950063_1080_1920_30fps.mp4',
        profileImage: 'assets/images/5.png',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Facebook Reels"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
          },
        ),
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
    _controller = VideoPlayerController.network(widget.reel.videoPath)
      ..initialize().then((_) {
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
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(widget.reel.profileImage),
              ),
              const SizedBox(width: 10),
              Text(
                widget.reel.username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 6, color: Colors.black)],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
