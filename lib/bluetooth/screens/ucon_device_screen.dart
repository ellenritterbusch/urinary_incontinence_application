import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../widgets/service_tile.dart';
import '../widgets/characteristic_tile.dart';
import '../widgets/descriptor_tile.dart';
import '../utils/snackbar.dart';
import '../utils/extra.dart';

class UconDeviceScreen extends StatefulWidget {
  //final BluetoothDevice device;
  final BluetoothDevice ucon = BluetoothDevice.fromId('A40020C2-2DA0-9B61-B94F-4332828925BE');        //vi laver device ud fra ID
  UconDeviceScreen({super.key, required BluetoothDevice ucon});                                       //Kræver key, og device
  
  final DeviceIdentifier uconId =  const DeviceIdentifier('A40020C2-2DA0-9B61-B94F-4332828925BE');   //DeviceIdentifier (Ved ærligt ikke helt om den her gør noget)

  @override
  State<UconDeviceScreen> createState() => _UconDeviceScreenState();
}

class _UconDeviceScreenState extends State<UconDeviceScreen> {
  int? _rssi;                                                                             //RSSI (Received signal strengh indicator) som kan være null 
  int? _mtuSize;                                                                          //MTU som kan være null takket være ?-tegnet
  late BluetoothConnectionState _connectionState;                     //Disconnected state 
  List<BluetoothService> _services = [];                                                  //Array til services list
  bool _isDiscoveringServices = false;                                                    //Leder den lige nu?
  bool _isConnecting = false;                                                             //Connecter den lige nu?
  bool _isDisconnecting = false;  
   Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();                                                        //Er den ved at disconnecte?

  late BluetoothDevice ucon = BluetoothDevice.fromId('A40020C2-2DA0-9B61-B94F-4332828925BE');
  late DeviceIdentifier remoteId =  const DeviceIdentifier('A40020C2-2DA0-9B61-B94F-4332828925BE');


  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;         
  late StreamSubscription<bool> _isConnectingSubscription;
  late StreamSubscription<bool> _isDisconnectingSubscription;
  late StreamSubscription<int> _mtuSubscription;
  
  @override
  void initState() {
    super.initState();

    _connectionStateSubscription = widget.ucon.connectionState.listen((state) async {
      _connectionState = state;
      if (state == BluetoothConnectionState.connected) {                              //If connection is established
        _services = [];                                                               //Show services
      }
      if (state == BluetoothConnectionState.connected && _rssi == null) {             //If connection is established and RSSI = null
        _rssi = await widget.ucon.readRssi();                                       //Her læser vi RSSI
      }
      if (mounted) {
        setState(() {});
      }
    });

    _mtuSubscription = widget.ucon.mtu.listen((value) {
      _mtuSize = value;
      if (mounted) {
        setState(() {});
      }
    });

    _isConnectingSubscription = widget.ucon.isConnecting.listen((value) {
      _isConnecting = value;
      if (mounted) {
        setState(() {});
      }
    });

    _isDisconnectingSubscription = widget.ucon.isDisconnecting.listen((value) {
      _isDisconnecting = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();                    //Cancelling connection 
    _mtuSubscription.cancel();                                //Cancellation of MTU-subscribtion
    _isConnectingSubscription.cancel();                       //Cancelling while connecting
    _isDisconnectingSubscription.cancel();                    //cancelling while disconnecting
    super.dispose();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;      //Tjekker om vi er forbundet
  }

  Future onConnectPressed() async {                           //Når man trykker på connect
    try {
      await widget.ucon.connectAndUpdateStream();
      Snackbar.show(ABC.c, "Connect: Success", success: true);
    } catch (e) {
      if (e is FlutterBluePlusException && e.code == FbpErrorCode.connectionCanceled.index) {
        // ignore connections cancelled by the user
      } else {
        Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
      }
    }
  }

  Future onCancelPressed() async {                          //Når man canceller
    try {
      await widget.ucon.disconnectAndUpdateStream(queue: false);
      Snackbar.show(ABC.c, "Cancel: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Cancel Error:", e), success: false);
    }
  }

  Future onDisconnectPressed() async {                      //Når man trykker disconnect
    try {
      await widget.ucon.disconnectAndUpdateStream();
      Snackbar.show(ABC.c, "Disconnect: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Disconnect Error:", e), success: false);
    }
  }

  Future onDiscoverServicesPressed() async {
    if (mounted) {
      setState(() {
        _isDiscoveringServices = true;
      });
    }
    try {
      _services = await widget.ucon.discoverServices();
      Snackbar.show(ABC.c, "Discover Services: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Discover Services Error:", e), success: false);
    }
    if (mounted) {
      setState(() {
        _isDiscoveringServices = false;
      });
    }
  }

  Future onRequestMtuPressed() async {                                        //Ændring af MTU
    try {
      await widget.ucon.requestMtu(223, predelay: 0);
      Snackbar.show(ABC.c, "Request Mtu: Success", success: true);                      //Success
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Change Mtu Error:", e), success: false);    //Fejl
    }
  }

  Future readCharacteristic(BluetoothCharacteristic characteristic) async{
      List<int> value = await characteristic.read();
      setState(() {
        readValues[characteristic.uuid] = value;
      });
  }
  
  List<Widget> _buildServiceTiles(BuildContext context, BluetoothDevice d) {
    return _services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics.map((c) => _buildCharacteristicTile(c)).toList(),
          ),
        )
        .toList();
  }

  CharacteristicTile _buildCharacteristicTile(BluetoothCharacteristic c) {
    return CharacteristicTile(
      characteristic: c,
      descriptorTiles: c.descriptors.map((d) => DescriptorTile(descriptor: d)).toList(),
    );
  }

  Widget buildSpinner(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(14.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CircularProgressIndicator(
          backgroundColor: Colors.black12,
          color: Colors.black26,
        ),
      ),
    );
  }

  Widget buildRemoteId(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('${widget.ucon.remoteId}'),
    ); 
  }

  Widget buildRssiTile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isConnected ? const Icon(Icons.bluetooth_connected) : const Icon(Icons.bluetooth_disabled),
        Text(((isConnected && _rssi != null) ? '${_rssi!} dBm' : ''), style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }

  Widget buildGetServices(BuildContext context) {
    return IndexedStack(
      index: (_isDiscoveringServices) ? 1 : 0,
      children: <Widget>[
        TextButton(
          onPressed: onDiscoverServicesPressed,
          child: const Text("Get Services"),
        ),
        const IconButton(
          icon: SizedBox(
            width: 18.0,
            height: 18.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.grey),
            ),
          ),
          onPressed: null,
        )
      ],
    );
  }

  Widget buildMtuTile(BuildContext context) {                     //Under device Tile hvor der står MTU size, antal af bytes og en blyant.
    return ListTile(
        title: const Text('MTU Size'),
        subtitle: Text('$_mtuSize bytes'),                        //Maximum transmission unit = MTU. mængde af data der sendes i en packet
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: onRequestMtuPressed,
        ));
  }

  Widget buildConnectButton(BuildContext context) {
    return Row(children: [
      if (_isConnecting || _isDisconnecting) buildSpinner(context),
      TextButton(
          onPressed: _isConnecting ? onCancelPressed : (isConnected ? onDisconnectPressed : onConnectPressed),
          child: Text(
            _isConnecting ? "CANCEL" : (isConnected ? "DISCONNECT" : "CONNECT"),
            style: Theme.of(context).primaryTextTheme.labelLarge?.copyWith(color: Colors.white),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyC,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.ucon.platformName),  
          actions: [buildConnectButton(context)],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildRemoteId(context),
              ListTile(
                leading: buildRssiTile(context),
                title: Text('Device is ${_connectionState.toString().split('.')[1]}.'),
                trailing: buildGetServices(context),
              ),
              //buildMtuTile(context),
              ..._buildServiceTiles(context, widget.ucon),
            ],
          ),
        ),
      ),
    );
  }
}
