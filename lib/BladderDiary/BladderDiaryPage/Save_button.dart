import 'package:flutter/material.dart';

class Save_Button extends StatefulWidget {
  final Function() onpressed;
  
  const Save_Button({super.key, required this.onpressed});

  @override
  State<Save_Button> createState() => _Save_ButtonState();
}

class _Save_ButtonState extends State<Save_Button> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width * 0.40, MediaQuery.of(context).size.height * 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20))
         ),

        onPressed: widget.onpressed,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Save", style: TextStyle(fontSize: 28, color: Colors.black),),],
          ));
  }
}