import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:urinary_incontinence_application/ViewGuides/VideoPlayer.dart';
import 'package:urinary_incontinence_application/ViewGuides/ImageAsset.dart';
class ListTile_DropDown extends StatefulWidget {
  final String tile_Title;
  final String tile_Text;
  final String imageAsset;
  final String tile_Text2;
  final String videoAsset;

  const ListTile_DropDown({required this.tile_Title, required this.tile_Text, required this.tile_Text2, required this.imageAsset, required this.videoAsset});


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
            Padding(
              padding: EdgeInsets.all(8.0),
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
              Padding(padding: EdgeInsets.all(8.0)),

              Text(widget.tile_Text2, textAlign: TextAlign.left,),

                  
              VideoAsset(videoAssetString: widget.videoAsset, videoLink:''),
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


//     return Card(child:
//             Column(
//               children: [
//                 ExpansionTile(
//                   title: Text(widget.tile_Title),
//                   trailing: Icon(
//                 _tileExpanded
//                     ? Icons.keyboard_arrow_down_outlined
//                     : Icons.keyboard_arrow_right_outlined),
                    
//                           children: [
//                             Text(widget.tile_Text),
//                             ImageAsset(imageAsset: 'assets/image/image_example.png'),
//                            const Card(
//                               child: VideoAsset(videoAssetString: 'assets/video/video_example.mp4', videoLink:''),
//                                   ),
                          
//                       ],
//                           onExpansionChanged: (bool expanded) {
//                 setState(() {
//                   _tileExpanded = expanded;
//                 }
//                  ); 
//                  }
//                  ),
//                  const Card(
//                   child: Text('data')
//                  ),
                 
// ],
//             )
//     );