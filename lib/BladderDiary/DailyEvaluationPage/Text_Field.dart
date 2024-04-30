import 'package:flutter/material.dart';

class Text_Field extends StatefulWidget {
  final Function onPressed;
  final TextEditingController controller;
  const Text_Field({required this.onPressed, required this.controller, super.key});

  @override
  State<Text_Field> createState() => _Text_FieldState();
}

class _Text_FieldState extends State<Text_Field> {

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextField(
                      controller: widget.controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Describe your day',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                      maxLines: 3,
                      onChanged: widget.onPressed()
                    ),
    );
  }
}