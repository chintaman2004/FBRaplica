import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'mainpage.dart';

class Reel {
  final String videoUrl;
  final String username;
  final String caption;

  Reel({required this.videoUrl, required this.username, required this.caption});
}

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  final List<Reel> reels = [
    Reel(
      videoUrl:
          'https://videos.pexels.com/video-files/3403284/3403284-uhd_1440_2732_25fps.mp4',
      username: '@streetqueen',
      caption: 'Dancing like the city’s watching 🏙️💃',
    ),
    Reel(
      videoUrl:
          'https://videos.pexels.com/video-files/4594927/4594927-uhd_1440_2732_25fps.mp4',
      username: '@urbanmoves',
      caption: 'Grace in every frame. Style in every step. ✨',
    ),
    Reel(
      videoUrl:
          'https://videos.pexels.com/video-files/4008162/4008162-uhd_1440_2732_25fps.mp4',
      username: '@sweetgirl',
      caption: 'Every step is refreshing. ✨',
    ),
    Reel(
      videoUrl:
          'https://videos.pexels.com/video-files/5435292/5435292-uhd_1440_2732_25fps.mp4',
      username: '@silentkiller',
      caption: 'Night with Candle ✨',
    ),
    Reel(
      videoUrl:
          'https://videos.pexels.com/video-files/5427492/5427492-uhd_1440_2732_25fps.mp4',
      username: '@darkness',
      caption: 'Light goes dark and my mind activates. ✨',
    ),
  ];

  final List<VideoPlayerController> _controllers = [];
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    for (var reel in reels) {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(reel.videoUrl),
      )..setLooping(true);
      _controllers.add(controller);
      controller.initialize().then((_) {
        setState(() {});
        if (_controllers.length == 1) controller.play(); // Auto play first
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
          final reel = reels[index];

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
                      reel.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      reel.caption,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Positioned(
                bottom: 80,
                right: 16,
                child: Column(
                  children: [
                    Icon(Icons.favorite, color: Colors.white),
                    SizedBox(height: 10),
                    Icon(Icons.comment, color: Colors.white),
                    SizedBox(height: 10),
                    Icon(Icons.share, color: Colors.white),
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
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Mainpage()),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
