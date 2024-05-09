import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class ListTile_DropDown extends StatefulWidget {
  final String tile_Title;
  final String tile_Text;
  final Image ? image;
  final String ? videoURL;

  const ListTile_DropDown({required this.tile_Title, required this.tile_Text, this.image, this.videoURL});


  @override
 
  State<ListTile_DropDown> createState() => _ListTile_DropDownState();
}

class _ListTile_DropDownState extends State<ListTile_DropDown> {
  bool _tileExpanded = false;
  
  @override
  Widget build(BuildContext context) {
    return Card(child:
            ExpansionTile(
              title: Text(widget.tile_Title),
              trailing: Icon(
            _tileExpanded
                ? Icons.keyboard_arrow_down_outlined
                : Icons.keyboard_arrow_right_outlined),
                
          children: [Text(widget.tile_Text),],
          onExpansionChanged: (bool expanded) {
            setState(() {
              _tileExpanded = expanded;
            }
             ); 
             }
             )
    );
  }
}