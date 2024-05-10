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
          Divider(color: Theme.of(context).colorScheme.primary),
          Theme(data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
           child: ExpansionTile(
              title: const Text("Guide to UCon", 
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              trailing: Icon(
                  _uconExpanded
                  ? Icons.keyboard_arrow_down_outlined
                  : Icons.keyboard_arrow_right_outlined),
                
              children: const [
               ListTile_DropDown(
                  tile_Title: 'UCon Overview', 
                  tile_Text: 'The picture below illustrates an overview of the UCon device, its remote and the various buttons it has:'),
                ListTile_DropDown(  
                  tile_Title: 'Electode Placement', 
                  tile_Text: ''),
                  ListTile_DropDown(  
                  tile_Title: 'Alarm Guide', 
                  tile_Text: 'Press this button to turn on the UCon device'),
                  ],
              onExpansionChanged: (bool expanded) {
                 setState(() {
                      _uconExpanded = expanded;
                   });
                },
              ),),
            Divider(color: Theme.of(context).colorScheme.primary),
          
          Theme(data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
           child:ExpansionTile(
              title: const Text("Guide to app", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              trailing: Icon(
                  _appExpanded
                  ? Icons.keyboard_arrow_down_outlined
                  : Icons.keyboard_arrow_right_outlined),
                
              children: const [
                ListTile_DropDown(
                  tile_Title: 'App Overview', 
                  tile_Text: 'Below you will find a video guide taking you through the use of the app:'),
                    ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                    _appExpanded = expanded;
                  });
               },
           )),
           Divider(color: Theme.of(context).colorScheme.primary),
          ],
        ),
      )
    );

  }}