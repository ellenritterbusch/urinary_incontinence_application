import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:urinary_incontinence_application/bluetooth/flutterblueapp.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/bluetooth/screens/ucon_scan.dart';

class MyBluetooth extends StatefulWidget {
  const MyBluetooth({super.key});

  @override
  State<MyBluetooth> createState() => _MyBluetoothState();
}

class _MyBluetoothState extends State<MyBluetooth> {
    BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;
  
  
  @override                     //Checks whether bluetooth is turned on?
  void initState() {
    super.initState();
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

 @override                      //If bluetooth is turned off, cancel
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override                    //If bluetooth is turned off, display text
  Widget build(BuildContext context) {
    Widget screen = _adapterState == BluetoothAdapterState.on
        ? UconScan()                                            //If bluetooth is on, go to UconScan()
        //: BluetoothOffScreen(adapterState: _adapterState);
        : const Scaffold(                                             //If bluetooth is off, show text
           body:
            Text(
              'Bluetooth is turned off. Turn it on in your phone settings.',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold, 
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
        );
        

    return MaterialApp(
      color: const Color.fromARGB(207, 102, 147, 233),
      home: screen,
      navigatorObservers: [BluetoothAdapterStateObserver()],
      debugShowCheckedModeBanner: false, //removing "debug" markat
    );
  }
  
}