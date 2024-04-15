import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:urinary_incontinence_application/bluetooth_by_vicotor/screens/ucon_device_screen.dart';
import 'package:urinary_incontinence_application/bluetooth_by_vicotor/widgets/ucon_device_tile.dart';
import 'package:urinary_incontinence_application/bluetooth_by_vicotor/widgets/ucon_scan_result.dart';

import 'device_screen.dart';
import '../utils/snackbar.dart';
import '../utils/extra.dart';

class UconScan extends StatefulWidget {
  UconScan({Key? key}) : super(key: key);
  final String remoteId = 'A40020C2-2DA0-9B61-B94F-4332828925BE';
  BluetoothDevice ucon = BluetoothDevice.fromId('A40020C2-2DA0-9B61-B94F-4332828925BE');
  final String uconDevice = 'A40020C2-2DA0-9B61-B94F-4332828925BE';
  @override
  State<UconScan> createState() => _UconScan();
}

class _UconScan extends State<UconScan> {
  List<BluetoothDevice> _systemDevices = [];
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;
  
  @override
  void initState() {
    super.initState();

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {              //Viser resultater af scanning
      _scanResults = results;
      if (mounted) {
        setState(() {});
      }
    }, onError: (e) {
      Snackbar.show(ABC.b, prettyException("Scan Error:", e), success: false);
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {                   //State: Scanner den?
      _isScanning = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Future onScanPressed() async {                                                          //Når man trykker SCAN
    try {
      _systemDevices = await FlutterBluePlus.systemDevices;                                           //Success! 
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("System Devices Error:", e), success: false);               //ERROR
    }
    try {
      // Start scanning w/ timeout
      // Optional: you can use `stopScan()` as an alternative to using a timeout
      // Note: scan filters use an *or* behavior. i.e. if you set `withServices` & `withNames`
      //   we return all the advertisments that match any of the specified services *or* any
      //   of the specified names.
      await FlutterBluePlus.startScan(withServices: [Guid("A40020C2-2DA0-9B61-B94F-4332828925BE")], withNames:["UCon STIM"],); //Filter som filtrer efter ID og navn.;
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e), success: false);                    //Start scan error
    }
    if (mounted) {
      setState(() {});
    }
  }
  Future onStopPressed() async {
    try {
      FlutterBluePlus.stopScan();
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e), success: false);
    }
  }

  void onConnectPressed(BluetoothDevice ucon) {
    ucon.connectAndUpdateStream().catchError((e) {
      Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
    });
    MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => UconDeviceScreen(ucon: ucon), 
        settings: const RouteSettings(name: '/UconDeviceScreen')                    //Navigerer til deviceScreen
    );
    Navigator.of(context).push(route);
  }

  Future onRefresh() {
    if (_isScanning == false) {
      FlutterBluePlus.startScan(withServices: [Guid("A40020C2-2DA0-9B61-B94F-4332828925BE")], timeout: const Duration(seconds: 15));
    }
    if (mounted) {
      setState(() {});
    }
    return Future.delayed(const Duration(milliseconds: 500));
  }

  Widget buildScanButton(BuildContext context) {
    if (FlutterBluePlus.isScanningNow) {
      return FloatingActionButton(
        onPressed: onStopPressed,
        backgroundColor: Colors.red,
        child: const Icon(Icons.stop),
      );
    } else {
      return FloatingActionButton(onPressed: onScanPressed, child: const Text("SCAN"));
    }
  }

  List<Widget> _buildSystemDeviceTiles(BuildContext context) {
    return _systemDevices
        .map(
          (d) => UconDeviceTile(
            ucon: d,
            onOpen: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UconDeviceScreen(ucon: d),
                settings: const RouteSettings(name: '/UconDeviceScreen'),                         //Navigerer til devicescreen
              ),
            ),
            onConnect: () => onConnectPressed(d),
          ),
        )
        .toList();
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    return _scanResults
        .map(
          (r) => UconScanResultTile(
            result: r,
            onTap: () => onConnectPressed(r.device)),
          )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyB,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find your UCon device'),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            children: <Widget>[
              ..._buildSystemDeviceTiles(context),
              ..._buildScanResultTiles(context),
            ],
          ),
        ),
        floatingActionButton: buildScanButton(context),
      ),
    );
  }
  
}


