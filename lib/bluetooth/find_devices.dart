
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:urinary_incontinence_application/bluetooth/mybluetooth.dart';


class FindDevice extends StatefulWidget {
  const FindDevice({super.key});

  @override
  State<FindDevice> createState() => _FindDeviceState();
}

class _FindDeviceState extends State<FindDevice> {
    StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed:() {
            showModalBottomSheet(
              context: context, 
              builder: (BuildContext context) {
                return const SizedBox(
                  height: 400,
                  child: MyBluetooth(),
                );
              }
            );
          },
          child: const Text('Find UCon device'),
          ),
      ],
    );
  }
  
}

class BluetoothAdapterStateObserver extends NavigatorObserver {
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == '/FindDevice') {
      // Start listening to Bluetooth state changes when a new route is pushed
      _adapterStateSubscription ??= FlutterBluePlus.adapterState.listen((state) {
        if (state != BluetoothAdapterState.on) {
          // Pop the current route if Bluetooth is off
          navigator?.pop();
        }
      });
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    // Cancel the subscription when the route is popped
    _adapterStateSubscription?.cancel();
    _adapterStateSubscription = null;
  }
}
