import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _KEY {
  static const String bluetoothAddress = 'printer_usb_device_address';
  static const String bluetoothName = 'printer_usb_device_name';
}

@singleton
class PrinterUsbDevicePreferences {
  final _preferences = SharedPreferencesAsync();

  Future<void> setupDevice({
    required String address,
    required String name,
  }) async {
    await _preferences.setString(_KEY.bluetoothAddress, address);
    await _preferences.setString(_KEY.bluetoothName, name);
  }

  Future<void> removePrinter() async {
    await _preferences.remove(_KEY.bluetoothAddress);
    await _preferences.remove(_KEY.bluetoothName);
  }

  Future<String?> getAddress() => _preferences.getString(_KEY.bluetoothAddress);

  Future<String?> getName() => _preferences.getString(_KEY.bluetoothName);
}
