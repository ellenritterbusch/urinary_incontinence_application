import 'package:flutter/material.dart';

class _Note_ButtonState extends StatefulWidget {
  const _Note_ButtonState({super.key});

  @override
  State<_Note_ButtonState> createState() => __Note_ButtonStateState();
}

class __Note_ButtonStateState extends State<_Note_ButtonState> {
  @override
  Widget build(BuildContext context) { 
   return Scaffold(body: ElevatedButton(
                    onPressed : () {}, 
                    child: Icon(
                        Icons.edit_note, size: 50.0,),
                    ),
                    );
    
;
  }
}