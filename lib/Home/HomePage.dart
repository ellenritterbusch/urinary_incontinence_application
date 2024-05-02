import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/Notifications/SetNotifications.dart';
import 'package:urinary_incontinence_application/bluetooth/find_devices.dart';

import '../Visualization/HomePage/History_Box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Widget knap(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const FindDevice()
    );
  }

  @override
  Widget build(BuildContext context) {
     return const Scaffold(
      body: History_Box(),
     );
  }
}