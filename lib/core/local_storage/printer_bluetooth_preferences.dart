import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_extension/shared/data/printer_device.dart';

abstract class _KEY {
  static const String bluetoothAddress = 'printer_bluetooth_device_address';
  static const String bluetoothName = 'printer_bluetooth_device_name';
}

@singleton
class PrinterBluetoothDevicePreferences {
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

  Future<PrinterDevice?> getActiveDevice() async {
    final address = await getAddress();
    final name = await getName();
    if (address == null || address.isEmpty || name == null || name.isEmpty) {
      return null;
    }
    return PrinterDevice(address: address, name: name);
  }
}
