
import 'package:flutter/material.dart';
//import 'package:urinary_incontinence_application/bluetooth/find_devices.dart';
import 'package:urinary_incontinence_application/Bluetooth/screens/scan_screen.dart';
import 'package:urinary_incontinence_application/Bluetooth/widgets/system_device_tile.dart';
import 'package:urinary_incontinence_application/Bluetooth/widgets/characteristic_tile.dart';
import "package:urinary_incontinence_application/Bluetooth/utils/snackbar.dart";
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

String displayedText = '';
 final CharacteristicTileState characteristicTile = CharacteristicTileState();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: 
      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
      children: [ ElevatedButton(
              onPressed: () async { await characteristicTile.onReadPressed();
                                    await characteristicTile.onWritePressed();
                                setState(() {
                 displayedText = CharacteristicTileState.readResults;
                });
                  },              
            child: Text('Check Stimulation Setting'),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ), child:
            Text(
              displayedText,
              style: TextStyle(fontSize: 20),
            ),),],)
      
        )
     
  ;
  }
}