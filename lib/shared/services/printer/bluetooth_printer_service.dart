import 'dart:async';

import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:injectable/injectable.dart';
import 'package:web_extension/core/local_storage/printer_bluetooth_preferences.dart';

@singleton
class BluetoothPrinterService {
  final PrinterBluetoothDevicePreferences _preference;

  BluetoothPrinterService(this._preference);

  final printerPlugin = FlutterThermalPrinter.instance;

  StreamSubscription<List<Printer>>? _subscription;

  Future<void> setActiveDevice() async {}

  Future<Stream<List<Printer>>> scanBluetoothDevices() async {
    await printerPlugin.getPrinters(connectionTypes: [ConnectionType.BLE]);

    return printerPlugin.devicesStream;
  }
}
