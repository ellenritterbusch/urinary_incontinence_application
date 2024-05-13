import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//This class is used as the template for the video asset in the ListTile_DropDown tile. 
//Its attribute "videoAssetString" is given as "String videoAsset" in LT_DD.
class VideoAsset extends StatefulWidget {
  final String videoAssetString; //Location of video in the "video" sub-folder in assets folder. Should take the form of "assets/video/VIDEOFILENAME.mp4"



  const VideoAsset({required this.videoAssetString});
  @override
  State<VideoAsset> createState() => _VideoAssetState();
}

class _VideoAssetState extends State<VideoAsset> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState(){
    super.initState();
    //Initialize when there is a video, prevents it from freaking out when it can't find the video right away
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

              child: VideoPlayer(videoPlayerController)),// this is the video itself

            Row( //row of play, pause, ffwd, and rwd buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton( //Rewind button
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
                      seconds: videoPlayerController.value.position.inSeconds -1 //Only goes back 1 second each time it's pressed
                    )
                  );
                },
               child: const Icon(Icons.fast_rewind_outlined)),
               
              const Padding(padding: EdgeInsets.all(2)), //Room between buttons

              ElevatedButton( //Pause button
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))
                ),
                onPressed: (){
                  videoPlayerController.pause();
                }, 
                child: const Icon(Icons.pause_outlined)),

              const Padding(padding: EdgeInsets.all(2)), //Room between buttons

              ElevatedButton(//Play button
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))
                      ),
                onPressed: (){
                  videoPlayerController.play();
                },
               child: const Icon(Icons.play_arrow_outlined)),

               
              const Padding(padding: EdgeInsets.all(2)), //Room between buttons

               ElevatedButton(//Fastforward button. 
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))
                ),
                onPressed: (){
                  videoPlayerController.seekTo(
                    Duration(
                      seconds: videoPlayerController.value.position.inSeconds +1)); //Only goes forward 1 second each time it's pressed
                },
               child: const Icon(Icons.fast_forward_outlined)),
               ],
               )
          ],
        ) : Container(),
      );
  }
}