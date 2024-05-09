import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState(){
    super.initState();
    videoPlayerController = VideoPlayerController.asset(
      'assets/video/video_example.mp4'
    )..initialize().then((_){
      videoPlayerController.play();
      setState(() {
        
      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title:  const Text ('Text'),
        centerTitle: true,

      ),
      body: Center(
        child: videoPlayerController.value.isInitialized ?
        VideoPlayer(videoPlayerController) : Container(),
      ),
    );
  }
}