import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urinary_incontinence_application/ViewGuides/ListTile_DropDown.dart';
class ViewGuidesPage extends StatefulWidget {
  const ViewGuidesPage({super.key});

  @override
  State<ViewGuidesPage> createState() => _ViewGuidesPageState();
  
}

class _ViewGuidesPageState extends State<ViewGuidesPage> {
  bool _appExpanded = false; //Boolean for the App guide super tile being expanded. Each instance of the LT_DD tile for the App guide will be visible when true
  bool _uconExpanded = false; //Boolean for the UCon guide super tile being expanded. Each instance of the LT_DD tile for the UCon guide will be visible when true

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
              title: const Text("Guide to UCon", //The UCon guide super tile. Put each instance of LT_DD with UCon guides in here
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              trailing: Icon(
                  _uconExpanded //Arrow icon points right when the tile isn't expanded and down when it is.
                  ? Icons.keyboard_arrow_down_outlined
                  : Icons.keyboard_arrow_right_outlined),
                
              children: const [ //Here are all of the individual tiles with guide info
               ListTile_DropDown(
                  tile_Title: 'UCon Overview', 
                  tile_Text: 'The picture below illustrates an overview of the UCon device, its remote and the various buttons it has:',
                   tile_Text2: 'Look at the guides below to learn more about the function of the buttons',
                   imageAsset: 'assets/image/Remote_overview.png',
                   videoAsset: '',),
                ListTile_DropDown(  
                  tile_Title: 'Electode Placement Female', 
                  tile_Text: 'The image below shows the placement of the electrodes in relation to the clitoris',
                   tile_Text2: 'Be sure to place the reference electrode near your hip',
                   imageAsset: 'assets/image/Electrode_placement_female.png',
                   videoAsset: '',), 
                ListTile_DropDown(  
                  tile_Title: 'Electode Placement Male', 
                  tile_Text: 'The image below shows the placement of the electrodes in relation to the penis',
                   tile_Text2: 'Be sure to place the reference electrode near your hip',
                   imageAsset: 'assets/image/Electrode_placement_male.png',
                   videoAsset: '',),
                ListTile_DropDown(  
                  tile_Title: 'Alarm Guide', 
                  tile_Text: 'Here you can see what the various buttons mean',
                  tile_Text2: 'Be sure to check your alarms',
                   imageAsset: 'assets/image/UCon_alarm_overview.png',
                   videoAsset: '',)
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
              title: const Text("Guide to app", //The app guide super tile. Put each instance of LT_DD with app guides in here
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              trailing: Icon(
                  _appExpanded //Arrow icon points right when the tile isn't expanded and down when it is.
                  ? Icons.keyboard_arrow_down_outlined 
                  : Icons.keyboard_arrow_right_outlined),
                
              children: const [ //Here are all of the individual tiles with guide info
                ListTile_DropDown(
                  tile_Title: 'App Overview', 
                  tile_Text: 'In this app, you can record bladder diaries which automatically receive data from your UCon device. If you want, you can also see data about your use of the system, so you can see how it affects your condition.', 
                  tile_Text2: 'Below you will find a video guide taking you through the use of the app',
                   imageAsset: '',
                   videoAsset: 'assets/video/UseofAppVideo.mp4',),
                  
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