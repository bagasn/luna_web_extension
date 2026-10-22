import 'dart:async';

import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:injectable/injectable.dart';
import 'package:web_extension/core/local_storage/printer_bluetooth_preferences.dart';
import 'package:web_extension/shared/constants/error/exceptions.dart';
import 'package:web_extension/shared/data/printer_device.dart';
import 'package:web_extension/shared/utilities/log_util.dart';

@singleton
class BluetoothPrinterService {
  final PrinterBluetoothDevicePreferences _preference;

  BluetoothPrinterService(this._preference);

  final printerPlugin = FlutterThermalPrinter.instance;

  Future<PrinterDevice?> getActiveDevice() => _preference.getActiveDevice();

  Future<void> setActiveDevice(PrinterDevice device) async {
    final printer = _toPrinter(device);
    final isConnected = await printerPlugin.connect(printer);
    if (!isConnected) {
      throw PrintException(
        PrintErrorType.unreachable,
        'Gagal terhubung ke printer Bluetooth: ${device.name}',
      );
    }
    await _preference.setupDevice(address: device.address, name: device.name);
  }

  Future<void> removeActiveDevice() async {
    final activeDevice = await _preference.getActiveDevice();
    if (activeDevice != null) {
      try {
        await printerPlugin.disconnect(_toPrinter(activeDevice));
      } catch (error, stackTrace) {
        LogUtil.e(error.toString(), stackTrace: stackTrace);
      }
    }
    await _preference.removePrinter();
  }

  Future<Stream<List<Printer>>> scanBluetoothDevices() async {
    await printerPlugin.getPrinters(connectionTypes: [ConnectionType.BLE]);

    return printerPlugin.devicesStream.map(
      (devices) =>
          devices.where((d) => d.connectionType == ConnectionType.BLE).toList(),
    );
  }

  Future<void> stopScan() async {
    await printerPlugin.stopScan();
  }

  Future<void> printBytes(List<int> bytes) async {
    if (bytes.isEmpty) {
      throw const PrintException(
        PrintErrorType.emptyData,
        'Print data is empty',
      );
    }

    final activeDevice = await _preference.getActiveDevice();
    if (activeDevice == null) {
      throw const PrintException(
        PrintErrorType.invalidAddress,
        'Belum ada printer Bluetooth yang aktif',
      );
    }

    final printer = _toPrinter(activeDevice);
    final isConnected = await printerPlugin.connect(printer);
    if (!isConnected) {
      throw PrintException(
        PrintErrorType.unreachable,
        'Printer Bluetooth ${activeDevice.name} tidak terjangkau',
      );
    }

    try {
      await printerPlugin.printData(printer, bytes, longData: true);
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      throw PrintException(PrintErrorType.sendFailed, error.toString());
    }
  }

  Future<void> testPrint() async {
    final activeDevice = await _preference.getActiveDevice();
    if (activeDevice == null) {
      throw const PrintException(
        PrintErrorType.invalidAddress,
        'Belum ada printer Bluetooth yang aktif',
      );
    }

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    final bytes = <int>[
      ...generator.text(
        'LUNA POS',
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
      ...generator.hr(),
      ...generator.text(
        'Test Print (Bluetooth)',
        styles: const PosStyles(align: PosAlign.center),
      ),
      ...generator.text(
        'Device: ${activeDevice.name}',
        styles: const PosStyles(align: PosAlign.center),
      ),
      ...generator.text(
        'Address: ${activeDevice.address}',
        styles: const PosStyles(align: PosAlign.center),
      ),
      ...generator.feed(1),
      ...generator.cut(),
    ];

    await printBytes(bytes);
  }

  Printer _toPrinter(PrinterDevice device) {
    return Printer(
      address: device.address,
      name: device.name,
      connectionType: ConnectionType.BLE,
    );
  }
}
