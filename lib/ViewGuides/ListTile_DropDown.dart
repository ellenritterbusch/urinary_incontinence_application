import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:urinary_incontinence_application/ViewGuides/VideoPlayer.dart';
import 'package:urinary_incontinence_application/ViewGuides/ImageAsset.dart';
class ListTile_DropDown extends StatefulWidget {
  final String tile_Title;
  final String tile_Text;
  final Image ? imageAsset;
  final String ? videoAsset;

  const ListTile_DropDown({required this.tile_Title, required this.tile_Text, this.imageAsset, this.videoAsset});


  @override
 
  State<ListTile_DropDown> createState() => _ListTile_DropDownState();
}

class _ListTile_DropDownState extends State<ListTile_DropDown> {
  bool _tileExpanded = false;
   bool showVideo= false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       // Divider(color: Theme.of(context).colorScheme.secondary),
            ExpansionTile(
              title: Text(widget.tile_Title),
              trailing: Icon(
                _tileExpanded
                ? Icons.keyboard_arrow_down_outlined
                : Icons.keyboard_arrow_right_outlined),
                
          children: [
            Text(
            widget.tile_Text, 
            textAlign: TextAlign.left,),],
          onExpansionChanged: (bool expanded) {
            setState(() {
              _tileExpanded = expanded;
            });}
        ),
      ]
    );  
  }
}