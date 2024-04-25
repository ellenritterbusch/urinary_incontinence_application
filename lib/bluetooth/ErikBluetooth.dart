import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';



class BleConstants {
  // Services
  static const uconServiceUUID = "0000180f-0000-1000-8000-00805f9b34fb";
  
  // Read characteristics
  static const readCharacteristic = "00002a6e-0000-1000-8000-00805f9b34fb";

  // Write characteristic
  static const writeCharacteristic = "";
  
// Characteristics intended just to be read
  static const List<String> readCharacteristics = [
    readCharacteristic,
 
];
}
  /// Gets the BluetoothCharacteristics of the Services and saves it into a List
  Future<Map<BleCharacteristicsEnum, BluetoothCharacteristic>> discoverBluetoothServiceAndCharacteristic(
      BluetoothDevice device) async {
    // Get a list of BluetoothServices
    final services = await device.discoverServices(); //discovers Services of the BluetoothDevice
    // Get a list of BluetoothCharacteristics
    Map<BleCharacteristicsEnum, BluetoothCharacteristic> characteristics = {};
    for (var service in services) {
      if (BleConstants.uconServiceUUID.contains(service.uuid.str128.toLowerCase())) {
        // Discover characteristics that we want to use for notifications, read, write
        final discoveredCharacteristics = service.characteristics;
        for (var characteristic in discoveredCharacteristics) {
characteristics[BleCharacteristicsExtension.fromUuid(characteristic.uuid.str128.toLowerCase())] = characteristic;
        }
      }
    }
    return characteristics; 
    
     characteristics.forEach((key, bleCharacteristic) async {
      if (BleConstants.readCharacteristics.contains(key.toUuid())) {
        List<int> value = await bleCharacteristic.read();
        print(value);
      }
    });
  }


  // Read each of characteristics that has read property in the map of characteristics
  


  enum BleCharacteristicsEnum {
  temperatureCharacteristic,
  chargingCharacteristic,

}
extension BleCharacteristicsExtension on BleCharacteristicsEnum {
  String toUuid() {
    switch (this) {
      case BleCharacteristicsEnum.temperatureCharacteristic:
        return BleConstants.readCharacteristic;
       default:
        return "unknown";
    }
    
  }
  static BleCharacteristicsEnum fromUuid(String uuid) {
    var map = {
      BleConstants.readCharacteristic: BleCharacteristicsEnum.temperatureCharacteristic,
    };

    return map[uuid.toLowerCase()] ?? BleCharacteristicsEnum.unknown;
  }}