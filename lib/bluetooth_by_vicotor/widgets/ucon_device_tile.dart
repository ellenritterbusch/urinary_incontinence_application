//Kopi og redigeret version af System_Device_Tile
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class UconDeviceTile extends StatefulWidget {
  final BluetoothDevice ucon = BluetoothDevice.fromId('A40020C2-2DA0-9B61-B94F-4332828925BE');
  final VoidCallback onOpen;
  final VoidCallback onConnect;
  final String remoteId = 'A40020C2-2DA0-9B61-B94F-4332828925BE';
  


     UconDeviceTile({
    required this.onOpen,
    required this.onConnect,
    Key? key, required BluetoothDevice ucon,
  }) : super(key: key);

  @override
  State<UconDeviceTile> createState() => _UconDeviceTileState();
}

class _UconDeviceTileState extends State<UconDeviceTile> {
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;

  @override
  void initState() {
    super.initState();

    _connectionStateSubscription = widget.ucon.connectionState.listen((state) {
      _connectionState = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    super.dispose();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.ucon.platformName),                                    //Device name
      subtitle: Text(widget.ucon.remoteId.str),                                 //Device remoteId f.eks. "3ED41DDB-0B8B-1014-732D-B2B5B251BNAF"
      trailing: ElevatedButton(
        onPressed: isConnected ? widget.onOpen : widget.onConnect,                //If connected use either Open or Connect button
        child: isConnected ? const Text('OPEN') : const Text('CONNECT'),          //If connected, show "open" else show "Connect"
      ),
    );
  }
}
