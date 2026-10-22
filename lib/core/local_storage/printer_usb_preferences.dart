import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_extension/shared/data/printer_device.dart';

abstract class _KEY {
  static const String usbAddress = 'printer_usb_device_address';
  static const String usbName = 'printer_usb_device_name';
  static const String usbVendorId = 'printer_usb_device_vendor_id';
  static const String usbProductId = 'printer_usb_device_product_id';
}

@singleton
class PrinterUsbDevicePreferences {
  final _preferences = SharedPreferencesAsync();

  Future<void> setupDevice({
    required String address,
    required String name,
    String? vendorId,
    String? productId,
  }) async {
    await _preferences.setString(_KEY.usbAddress, address);
    await _preferences.setString(_KEY.usbName, name);
    if (vendorId != null) {
      await _preferences.setString(_KEY.usbVendorId, vendorId);
    } else {
      await _preferences.remove(_KEY.usbVendorId);
    }
    if (productId != null) {
      await _preferences.setString(_KEY.usbProductId, productId);
    } else {
      await _preferences.remove(_KEY.usbProductId);
    }
  }

  Future<void> removePrinter() async {
    await _preferences.remove(_KEY.usbAddress);
    await _preferences.remove(_KEY.usbName);
    await _preferences.remove(_KEY.usbVendorId);
    await _preferences.remove(_KEY.usbProductId);
  }

  Future<String?> getAddress() => _preferences.getString(_KEY.usbAddress);

  Future<String?> getName() => _preferences.getString(_KEY.usbName);

  Future<String?> getVendorId() => _preferences.getString(_KEY.usbVendorId);

  Future<String?> getProductId() => _preferences.getString(_KEY.usbProductId);

  Future<PrinterDevice?> getActiveDevice() async {
    final address = await getAddress();
    final name = await getName();
    if (address == null || address.isEmpty || name == null || name.isEmpty) {
      return null;
    }
    final vendorId = await getVendorId();
    final productId = await getProductId();
    return PrinterDevice(
      address: address,
      name: name,
      vendorId: vendorId,
      productId: productId,
    );
  }
}
