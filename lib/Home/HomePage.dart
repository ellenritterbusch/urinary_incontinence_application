
import 'package:flutter/material.dart';
//import 'package:urinary_incontinence_application/bluetooth/find_devices.dart';
import 'package:urinary_incontinence_application/Bluetooth/screens/scan_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: 
       ElevatedButton( onPressed: () {
         
       },
        child: Text('Check Stimulation'),
        ),
        )
     
  ;
  }
}