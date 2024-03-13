import 'package:flutter/material.dart';

class BladderDiaryPage extends StatefulWidget {
  const BladderDiaryPage({super.key});

  @override
  State<BladderDiaryPage> createState() => _BladderDiaryPageState();
}

class _BladderDiaryPageState extends State<BladderDiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
      ),
      body: 

      //////////// track and evaluate button //////////
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon( 
            onPressed: () {
            },
            icon: const Icon(Icons.add_reaction), 
            label: const Text("Evaluate")),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed:() {
            
            },
            icon: const Icon(Icons.add),
            label: const Text("Track")),
        )
      ],)
    );
  }
}