import 'dart:async';

import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:injectable/injectable.dart';
import 'package:web_extension/core/local_storage/printer_usb_preferences.dart';
import 'package:web_extension/shared/constants/error/exceptions.dart';
import 'package:web_extension/shared/data/printer_device.dart';
import 'package:web_extension/shared/utilities/log_util.dart';

@singleton
class UsbPrinterService {
  final PrinterUsbDevicePreferences _preference;

  UsbPrinterService(this._preference);

  final printerPlugin = FlutterThermalPrinter.instance;

  Future<PrinterDevice?> getActiveDevice() => _preference.getActiveDevice();

  Future<void> setActiveDevice(PrinterDevice device) async {
    final printer = _toPrinter(device);
    final isConnected = await printerPlugin.connect(printer);
    if (!isConnected) {
      throw PrintException(
        PrintErrorType.unreachable,
        'Gagal terhubung ke printer USB: ${device.name}',
      );
    }
    await _preference.setupDevice(
      address: device.address,
      name: device.name,
      vendorId: device.vendorId,
      productId: device.productId,
    );
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

  Future<Stream<List<Printer>>> scanUsbDevices() async {
    await printerPlugin.getPrinters(
      refreshDuration: const Duration(milliseconds: 500),
      connectionTypes: [ConnectionType.USB],
    );

    return printerPlugin.devicesStream.map(
      (devices) =>
          devices.where((d) => d.connectionType == ConnectionType.USB).toList(),
    );
  }

  Future<void> stopScan() async {
    await printerPlugin.stopScan();
  }

  void _validateBytes(List<int> bytes) {
    if (bytes.isEmpty) {
      throw const PrintException(
        PrintErrorType.emptyData,
        'Print data is empty',
      );
    }
    if (bytes.any((b) => b < 0 || b > 255)) {
      throw const PrintException(
        PrintErrorType.invalidData,
        'Print data contains values outside 0-255',
      );
    }
  }

  Future<PrinterDevice> requireActiveDevice() async {
    final activeDevice = await _preference.getActiveDevice();
    if (activeDevice == null) {
      throw const PrintException(
        PrintErrorType.noActiveDevice,
        'Belum ada printer USB yang aktif',
      );
    }
    return activeDevice;
  }

  Future<void> printBytes(List<int> bytes) async {
    _validateBytes(bytes);

    final activeDevice = await requireActiveDevice();
    final printer = _toPrinter(activeDevice);
    final isConnected = await printerPlugin.connect(printer);
    if (!isConnected) {
      throw PrintException(
        PrintErrorType.unreachable,
        'Printer USB ${activeDevice.name} (${activeDevice.address}) tidak terjangkau',
      );
    }

    try {
      await printerPlugin.printData(printer, bytes, longData: true);
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      throw PrintException(
        PrintErrorType.sendFailed,
        'Gagal mengirim data cetak ke printer USB ${activeDevice.name}: $error',
      );
    }
  }

  Future<void> testPrint() async {
    final activeDevice = await requireActiveDevice();

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
      ...generator.text(
        'Test Print (USB)',
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
      vendorId: device.vendorId ?? device.address,
      productId: device.productId ?? 'N/A',
      connectionType: ConnectionType.USB,
    );
  }
}
