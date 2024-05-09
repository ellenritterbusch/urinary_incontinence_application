import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urinary_incontinence_application/ViewGuides/ListTile_DropDown.dart';
class ViewGuidesPage extends StatefulWidget {
  const ViewGuidesPage({super.key});

  @override
  State<ViewGuidesPage> createState() => _ViewGuidesPageState();
  
}

class _ViewGuidesPageState extends State<ViewGuidesPage> {
  bool _appExpanded = false;
  bool _uconExpanded = false;
  bool showVideo= false;  
  String text = '';

  @override
  
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guides')),
      body: SingleChildScrollView( 
        child: Column(
        children: <Widget>[
          Card.filled(
            child: ExpansionTile(
              title: Text("Guide to UCon"),
              trailing: Icon(
                  _uconExpanded
                    ? Icons.keyboard_arrow_down_outlined
                   : Icons.keyboard_arrow_right_outlined),
                
              children: [
                ListTile_DropDown(
                  tile_Title: 'UCon Overview', 
                  tile_Text: 'Here is an overview of the UCon devices and the various buttons it has'),
                ListTile_DropDown(  
                  tile_Title: 'On/Off Button', 
                  tile_Text: 'Press this button to turn on the UCon device'),
                  ],
              onExpansionChanged: (bool expanded) {
                 setState(() {
                      _uconExpanded = expanded;
                   });
                },
              ),
            ),
          Card.filled(
            child: ExpansionTile(
              title: Text("Guide to app"),
              trailing: Icon(
                  _appExpanded
                  ? Icons.keyboard_arrow_down_outlined
                  : Icons.keyboard_arrow_right_outlined),
                
              children: const [
                ListTile_DropDown(
                  tile_Title: 'App Overview', 
                  tile_Text: 'Here you can see an overview of the app'),
                    ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                    _appExpanded = expanded;
                  });
               },
              ),
            ),
          ],
        ),
      )
    );

  }}