import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/bluetooth/flutterblueapp.dart';

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
       ElevatedButton(
        child: const Text('Bluetooth'), 
        onPressed: () {showModalBottomSheet(
          context: context, 
          builder: (BuildContext context) {
            return const SizedBox(
              height: 400,
              child: Center(),
        );},
        );},
         ),
      );
  }
}
