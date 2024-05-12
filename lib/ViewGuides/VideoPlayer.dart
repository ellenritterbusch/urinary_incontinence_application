import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoAsset extends StatefulWidget {
  final String videoAssetString;
  final String ? videoLink;

  const VideoAsset({required this.videoAssetString, this.videoLink});
  @override
  State<VideoAsset> createState() => _VideoAssetState();
}

class _VideoAssetState extends State<VideoAsset> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState(){
    super.initState();
    videoPlayerController = VideoPlayerController.asset(
      widget.videoAssetString
    )..initialize().then((_){
      setState(() {
        
      });
    });
  }
  Widget build(BuildContext context) {
    return Center(
        child: videoPlayerController.value.isInitialized ?
        Column(
          children: [
            AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,

              child: VideoPlayer(videoPlayerController)),

            Row(mainAxisAlignment: MainAxisAlignment.center,children: [ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)
                    )
                  )
                ),
                onPressed: (){
                  videoPlayerController.seekTo(
                    Duration(
                      seconds: videoPlayerController.value.position.inSeconds -1
                    )
                  );
                },
               child: const Icon(Icons.fast_rewind_outlined)),
               
              const Padding(padding: EdgeInsets.all(2)),

              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))
                ),
                onPressed: (){
                  videoPlayerController.pause();
                }, 
                child: const Icon(Icons.pause_outlined)),

              const Padding(padding: EdgeInsets.all(2)),

              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))
                      ),
                onPressed: (){
                  videoPlayerController.play();
                },
               child: const Icon(Icons.play_arrow_outlined)),

               
              const Padding(padding: EdgeInsets.all(2)),

               ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))
                ),
                onPressed: (){
                  videoPlayerController.seekTo(
                    Duration(
                      seconds: videoPlayerController.value.position.inSeconds +1));
                },
               child: const Icon(Icons.fast_forward_outlined)),
               ],
               )
          ],
        ) : Container(),
      );
  }
}