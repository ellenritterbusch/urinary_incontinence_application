import 'package:flutter/material.dart';

class History_Box extends StatefulWidget {
  const History_Box({super.key});

  @override
  State<History_Box> createState() => _History_BoxState();
}

class _History_BoxState extends State<History_Box> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
  width: double.infinity,
  height: 300.0,
  child: Card(child: Text('Hello World!')),
);
  }
}