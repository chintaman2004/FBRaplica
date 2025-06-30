import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  final List<String> videoUrls = [
    'https://videos.pexels.com/video-files/5896379/5896379-uhd_1440_2560_24fps.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  ];

  final List<VideoPlayerController> _controllers = [];
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    for (var url in videoUrls) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url))
        ..setLooping(true);
      _controllers.add(controller);
      controller.initialize().then((_) {
        setState(() {});
        if (_controllers.length == 1) {
          controller.play();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _playOnly(int index) {
    for (int i = 0; i < _controllers.length; i++) {
      if (i == index) {
        _controllers[i].play();
      } else {
        _controllers[i].pause();
      }
    }
  }

  void _toggleMute(VideoPlayerController controller) {
    setState(() {
      isMuted = !isMuted;
      controller.setVolume(isMuted ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _controllers.length,
        onPageChanged: (index) {
          _playOnly(index);
        },
        itemBuilder: (context, index) {
          final controller = _controllers[index];

          if (!controller.value.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
              Positioned(
                bottom: 80,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@AhmedHassan',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const Text(
                      'Where rhythm meets the streets. 💃🕺\n'
                      'Style, soul, and a splash of rebellion —\n'
                      'we dance, we vibe, we reel it all.\n'
                      'Join the movement. 🎶📲',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 80,
                right: 16,
                child: Column(
                  children: const [
                    Icon(Icons.favorite, color: Colors.white, size: 40),
                    SizedBox(height: 20),
                    Icon(Icons.comment, color: Colors.white, size: 40),
                    SizedBox(height: 20),
                    Icon(Icons.share, color: Colors.white, size: 40),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: IconButton(
                  icon: Icon(
                    isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                  ),
                  onPressed: () => _toggleMute(controller),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
