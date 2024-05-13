import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:urinary_incontinence_application/ViewGuides/VideoPlayer.dart';
import 'package:urinary_incontinence_application/ViewGuides/ImageAsset.dart';
//This is the template for each unique tile with guide info. It has a title, 2 potential tile texts, a possible image, and a possible video
class ListTile_DropDown extends StatefulWidget {
  final String tile_Title; //Title of the tile
  final String tile_Text; //Text on tile, immediately under title
  final String imageAsset; //Location of image in assets folder. Relates to imageAsset attribute in ImageAsset class
  final String tile_Text2;//Text on tile, appears after image, before video
  final String videoAsset;//Location of video in assets folder. Relates to videoAssetString attribute in VideoPlayer class

  const ListTile_DropDown({required this.tile_Title, required this.tile_Text, required this.tile_Text2, required this.imageAsset, required this.videoAsset});


  @override
 
  State<ListTile_DropDown> createState() => _ListTile_DropDownState();
}

class _ListTile_DropDownState extends State<ListTile_DropDown> {
  bool _tileExpanded = false; //Boolean for the tile being expanded, relates to arrow icon. 
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Text(widget.tile_Title),
                trailing: Icon(
                  _tileExpanded
                  ? Icons.keyboard_arrow_down_outlined
                  : Icons.keyboard_arrow_right_outlined),
                  
              children: [
              Text(
              widget.tile_Text, 
              textAlign: TextAlign.left,),
              ImageAsset(imageAsset: widget.imageAsset),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(widget.tile_Text2, textAlign: TextAlign.left,),
              VideoAsset(videoAssetString: widget.videoAsset, videoLink: '',),
              ],
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _tileExpanded = expanded;
                  });}
             ),
          ),
      ]
    );  
  }
}
