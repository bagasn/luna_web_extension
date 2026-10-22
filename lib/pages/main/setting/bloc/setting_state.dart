part of 'setting_bloc.dart';

class SettingFeedback extends Equatable {
  final String message;
  final bool isError;
  final int timestamp;

  SettingFeedback({
    required this.message,
    required this.isError,
  }) : timestamp = DateTime.now().microsecondsSinceEpoch;

  factory SettingFeedback.success(String message) =>
      SettingFeedback(message: message, isError: false);

  factory SettingFeedback.error(String message) =>
      SettingFeedback(message: message, isError: true);

  @override
  List<Object?> get props => [message, isError, timestamp];
}

final class SettingState extends Equatable {
  final PrinterDevice? activeBluetoothDevice;
  final PrinterDevice? activeUsbDevice;
  final List<PrinterDevice> scannedBluetoothDevices;
  final List<PrinterDevice> scannedUsbDevices;
  final bool isScanningBluetooth;
  final bool isScanningUsb;
  final bool isSelectingBluetooth;
  final bool isSelectingUsb;
  final bool isTestingBluetooth;
  final bool isTestingUsb;
  final bool isTestingNetwork;
  final SettingFeedback? feedback;

  const SettingState({
    this.activeBluetoothDevice,
    this.activeUsbDevice,
    this.scannedBluetoothDevices = const [],
    this.scannedUsbDevices = const [],
    this.isScanningBluetooth = false,
    this.isScanningUsb = false,
    this.isSelectingBluetooth = false,
    this.isSelectingUsb = false,
    this.isTestingBluetooth = false,
    this.isTestingUsb = false,
    this.isTestingNetwork = false,
    this.feedback,
  });

  SettingState copyWith({
    PrinterDevice? Function()? activeBluetoothDevice,
    PrinterDevice? Function()? activeUsbDevice,
    List<PrinterDevice>? scannedBluetoothDevices,
    List<PrinterDevice>? scannedUsbDevices,
    bool? isScanningBluetooth,
    bool? isScanningUsb,
    bool? isSelectingBluetooth,
    bool? isSelectingUsb,
    bool? isTestingBluetooth,
    bool? isTestingUsb,
    bool? isTestingNetwork,
    SettingFeedback? Function()? feedback,
  }) {
    return SettingState(
      activeBluetoothDevice: activeBluetoothDevice != null
          ? activeBluetoothDevice()
          : this.activeBluetoothDevice,
      activeUsbDevice:
          activeUsbDevice != null ? activeUsbDevice() : this.activeUsbDevice,
      scannedBluetoothDevices:
          scannedBluetoothDevices ?? this.scannedBluetoothDevices,
      scannedUsbDevices: scannedUsbDevices ?? this.scannedUsbDevices,
      isScanningBluetooth: isScanningBluetooth ?? this.isScanningBluetooth,
      isScanningUsb: isScanningUsb ?? this.isScanningUsb,
      isSelectingBluetooth: isSelectingBluetooth ?? this.isSelectingBluetooth,
      isSelectingUsb: isSelectingUsb ?? this.isSelectingUsb,
      isTestingBluetooth: isTestingBluetooth ?? this.isTestingBluetooth,
      isTestingUsb: isTestingUsb ?? this.isTestingUsb,
      isTestingNetwork: isTestingNetwork ?? this.isTestingNetwork,
      feedback: feedback != null ? feedback() : this.feedback,
    );
  }

  @override
  List<Object?> get props => [
        activeBluetoothDevice,
        activeUsbDevice,
        scannedBluetoothDevices,
        scannedUsbDevices,
        isScanningBluetooth,
        isScanningUsb,
        isSelectingBluetooth,
        isSelectingUsb,
        isTestingBluetooth,
        isTestingUsb,
        isTestingNetwork,
        feedback,
      ];
}
