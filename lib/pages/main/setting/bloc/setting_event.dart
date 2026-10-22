part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

final class LoadSettingEvent extends SettingEvent {
  const LoadSettingEvent();
}

final class ScanBluetoothDevicesEvent extends SettingEvent {
  const ScanBluetoothDevicesEvent();
}

final class StopScanBluetoothDevicesEvent extends SettingEvent {
  const StopScanBluetoothDevicesEvent();
}

final class BluetoothDevicesUpdatedEvent extends SettingEvent {
  final List<PrinterDevice> devices;

  const BluetoothDevicesUpdatedEvent(this.devices);

  @override
  List<Object?> get props => [devices];
}

final class SelectBluetoothDeviceEvent extends SettingEvent {
  final PrinterDevice device;

  const SelectBluetoothDeviceEvent(this.device);

  @override
  List<Object?> get props => [device];
}

final class RemoveBluetoothDeviceEvent extends SettingEvent {
  const RemoveBluetoothDeviceEvent();
}

final class TestPrintBluetoothEvent extends SettingEvent {
  const TestPrintBluetoothEvent();
}

final class ScanUsbDevicesEvent extends SettingEvent {
  const ScanUsbDevicesEvent();
}

final class StopScanUsbDevicesEvent extends SettingEvent {
  const StopScanUsbDevicesEvent();
}

final class UsbDevicesUpdatedEvent extends SettingEvent {
  final List<PrinterDevice> devices;

  const UsbDevicesUpdatedEvent(this.devices);

  @override
  List<Object?> get props => [devices];
}

final class SelectUsbDeviceEvent extends SettingEvent {
  final PrinterDevice device;

  const SelectUsbDeviceEvent(this.device);

  @override
  List<Object?> get props => [device];
}

final class RemoveUsbDeviceEvent extends SettingEvent {
  const RemoveUsbDeviceEvent();
}

final class TestPrintUsbEvent extends SettingEvent {
  const TestPrintUsbEvent();
}

final class TestPrintNetworkEvent extends SettingEvent {
  final String ipAddress;

  const TestPrintNetworkEvent(this.ipAddress);

  @override
  List<Object?> get props => [ipAddress];
}

final class ClearSettingFeedbackEvent extends SettingEvent {
  const ClearSettingFeedbackEvent();
}
