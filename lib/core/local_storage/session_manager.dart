import 'package:injectable/injectable.dart';
import 'package:web_extension/core/local_storage/printer_bluetooth_preferences.dart';
import 'package:web_extension/core/local_storage/printer_usb_preferences.dart';
import 'package:web_extension/core/local_storage/setting_preferences.dart';

@singleton
class SessionManager {
  final SettingPreferences setting;
  final PrinterBluetoothDevicePreferences bluetoothDevice;
  final PrinterUsbDevicePreferences usbDevice;

  SessionManager({
    required this.setting,
    required this.bluetoothDevice,
    required this.usbDevice,
  });
}
