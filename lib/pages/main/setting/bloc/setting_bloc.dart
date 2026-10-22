import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:injectable/injectable.dart';
import 'package:web_extension/shared/data/printer_device.dart';
import 'package:web_extension/shared/services/printer/bluetooth_printer_service.dart';
import 'package:web_extension/shared/services/printer/network_printer_service.dart';
import 'package:web_extension/shared/services/printer/usb_printer_service.dart';
import 'package:web_extension/shared/services/socket_service.dart';
import 'package:web_extension/shared/utilities/log_util.dart';

part 'setting_event.dart';
part 'setting_state.dart';

@injectable
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final BluetoothPrinterService _bluetoothService;
  final UsbPrinterService _usbService;
  final NetworkPrinterService _networkService;
  final WebSocketService _socketService;

  StreamSubscription<List<Printer>>? _bluetoothScanSubscription;
  StreamSubscription<List<Printer>>? _usbScanSubscription;

  SettingBloc(
    this._bluetoothService,
    this._usbService,
    this._networkService,
    this._socketService,
  ) : super(const SettingState()) {
    on<LoadSettingEvent>(_onLoadSetting);
    on<ScanBluetoothDevicesEvent>(_onScanBluetoothDevices);
    on<StopScanBluetoothDevicesEvent>(_onStopScanBluetoothDevices);
    on<BluetoothDevicesUpdatedEvent>(_onBluetoothDevicesUpdated);
    on<SelectBluetoothDeviceEvent>(_onSelectBluetoothDevice);
    on<RemoveBluetoothDeviceEvent>(_onRemoveBluetoothDevice);
    on<TestPrintBluetoothEvent>(_onTestPrintBluetooth);
    on<ScanUsbDevicesEvent>(_onScanUsbDevices);
    on<StopScanUsbDevicesEvent>(_onStopScanUsbDevices);
    on<UsbDevicesUpdatedEvent>(_onUsbDevicesUpdated);
    on<SelectUsbDeviceEvent>(_onSelectUsbDevice);
    on<RemoveUsbDeviceEvent>(_onRemoveUsbDevice);
    on<TestPrintUsbEvent>(_onTestPrintUsb);
    on<TestPrintNetworkEvent>(_onTestPrintNetwork);
    on<ClearSettingFeedbackEvent>(_onClearFeedback);
  }

  Future<void> _onLoadSetting(
    LoadSettingEvent event,
    Emitter<SettingState> emit,
  ) async {
    try {
      final activeBt = await _bluetoothService.getActiveDevice();
      final activeUsb = await _usbService.getActiveDevice();
      emit(
        state.copyWith(
          activeBluetoothDevice: () => activeBt,
          activeUsbDevice: () => activeUsb,
        ),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
    }
  }

  Future<void> _onScanBluetoothDevices(
    ScanBluetoothDevicesEvent event,
    Emitter<SettingState> emit,
  ) async {
    try {
      if (state.isScanningUsb) {
        await _usbScanSubscription?.cancel();
        _usbScanSubscription = null;
        await _usbService.stopScan();
      }

      emit(
        state.copyWith(
          isScanningBluetooth: true,
          isScanningUsb: false,
          feedback: () => null,
        ),
      );

      await _bluetoothScanSubscription?.cancel();
      final stream = await _bluetoothService.scanBluetoothDevices();
      _bluetoothScanSubscription = stream.listen(
        (printers) {
          final devices = printers.map(PrinterDevice.fromPrinter).toList();
          add(BluetoothDevicesUpdatedEvent(devices));
        },
        onError: (Object error, StackTrace stackTrace) {
          LogUtil.e(error.toString(), stackTrace: stackTrace);
        },
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      emit(
        state.copyWith(
          isScanningBluetooth: false,
          feedback: () => SettingFeedback.error(error.toString()),
        ),
      );
    }
  }

  Future<void> _onStopScanBluetoothDevices(
    StopScanBluetoothDevicesEvent event,
    Emitter<SettingState> emit,
  ) async {
    await _bluetoothScanSubscription?.cancel();
    _bluetoothScanSubscription = null;
    await _bluetoothService.stopScan();
    emit(state.copyWith(isScanningBluetooth: false));
  }

  void _onBluetoothDevicesUpdated(
    BluetoothDevicesUpdatedEvent event,
    Emitter<SettingState> emit,
  ) {
    emit(state.copyWith(scannedBluetoothDevices: event.devices));
  }

  Future<void> _onSelectBluetoothDevice(
    SelectBluetoothDeviceEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(isSelectingBluetooth: true, feedback: () => null));
    try {
      await _bluetoothService.setActiveDevice(event.device);
      _socketService.addConsoleLog(
        'Bluetooth printer set active: ${event.device.name} (${event.device.address})',
      );
      emit(
        state.copyWith(
          activeBluetoothDevice: () => event.device,
          isSelectingBluetooth: false,
          feedback: () => SettingFeedback.success(
            'Printer Bluetooth "${event.device.name}" berhasil diaktifkan',
          ),
        ),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      emit(
        state.copyWith(
          isSelectingBluetooth: false,
          feedback: () => SettingFeedback.error(error.toString()),
        ),
      );
    }
  }

  Future<void> _onRemoveBluetoothDevice(
    RemoveBluetoothDeviceEvent event,
    Emitter<SettingState> emit,
  ) async {
    try {
      final previousName = state.activeBluetoothDevice?.name ?? '';
      await _bluetoothService.removeActiveDevice();
      _socketService.addConsoleLog(
        'Removed active Bluetooth printer: $previousName',
      );
      emit(
        state.copyWith(
          activeBluetoothDevice: () => null,
          feedback: () => SettingFeedback.success(
            'Printer Bluetooth aktif berhasil dihapus',
          ),
        ),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      emit(
        state.copyWith(
          feedback: () => SettingFeedback.error(error.toString()),
        ),
      );
    }
  }

  Future<void> _onTestPrintBluetooth(
    TestPrintBluetoothEvent event,
    Emitter<SettingState> emit,
  ) async {
    final activeDevice = state.activeBluetoothDevice;
    if (activeDevice == null) return;

    emit(state.copyWith(isTestingBluetooth: true, feedback: () => null));
    _socketService.addConsoleLog(
      'Test print Bluetooth into ${activeDevice.name} (${activeDevice.address})',
    );

    try {
      await _bluetoothService.testPrint();
      _socketService.addConsoleLog('Test print Bluetooth success');
      emit(
        state.copyWith(
          isTestingBluetooth: false,
          feedback: () => SettingFeedback.success(
            'Test print Bluetooth ke "${activeDevice.name}" berhasil',
          ),
        ),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      _socketService.addConsoleLog('Test print Bluetooth failed.\n$error');
      emit(
        state.copyWith(
          isTestingBluetooth: false,
          feedback: () => SettingFeedback.error(error.toString()),
        ),
      );
    }
  }

  Future<void> _onScanUsbDevices(
    ScanUsbDevicesEvent event,
    Emitter<SettingState> emit,
  ) async {
    try {
      if (state.isScanningBluetooth) {
        await _bluetoothScanSubscription?.cancel();
        _bluetoothScanSubscription = null;
        await _bluetoothService.stopScan();
      }

      emit(
        state.copyWith(
          isScanningUsb: true,
          isScanningBluetooth: false,
          feedback: () => null,
        ),
      );

      await _usbScanSubscription?.cancel();
      final stream = await _usbService.scanUsbDevices();
      _usbScanSubscription = stream.listen(
        (printers) {
          final devices = printers.map(PrinterDevice.fromPrinter).toList();
          add(UsbDevicesUpdatedEvent(devices));
        },
        onError: (Object error, StackTrace stackTrace) {
          LogUtil.e(error.toString(), stackTrace: stackTrace);
        },
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      emit(
        state.copyWith(
          isScanningUsb: false,
          feedback: () => SettingFeedback.error(error.toString()),
        ),
      );
    }
  }

  Future<void> _onStopScanUsbDevices(
    StopScanUsbDevicesEvent event,
    Emitter<SettingState> emit,
  ) async {
    await _usbScanSubscription?.cancel();
    _usbScanSubscription = null;
    await _usbService.stopScan();
    emit(state.copyWith(isScanningUsb: false));
  }

  void _onUsbDevicesUpdated(
    UsbDevicesUpdatedEvent event,
    Emitter<SettingState> emit,
  ) {
    emit(state.copyWith(scannedUsbDevices: event.devices));
  }

  Future<void> _onSelectUsbDevice(
    SelectUsbDeviceEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(isSelectingUsb: true, feedback: () => null));
    try {
      await _usbService.setActiveDevice(event.device);
      _socketService.addConsoleLog(
        'USB printer set active: ${event.device.name} (${event.device.address})',
      );
      emit(
        state.copyWith(
          activeUsbDevice: () => event.device,
          isSelectingUsb: false,
          feedback: () => SettingFeedback.success(
            'Printer USB "${event.device.name}" berhasil diaktifkan',
          ),
        ),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      emit(
        state.copyWith(
          isSelectingUsb: false,
          feedback: () => SettingFeedback.error(error.toString()),
        ),
      );
    }
  }

  Future<void> _onRemoveUsbDevice(
    RemoveUsbDeviceEvent event,
    Emitter<SettingState> emit,
  ) async {
    try {
      final previousName = state.activeUsbDevice?.name ?? '';
      await _usbService.removeActiveDevice();
      _socketService.addConsoleLog('Removed active USB printer: $previousName');
      emit(
        state.copyWith(
          activeUsbDevice: () => null,
          feedback: () => SettingFeedback.success(
            'Printer USB aktif berhasil dihapus',
          ),
        ),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      emit(
        state.copyWith(
          feedback: () => SettingFeedback.error(error.toString()),
        ),
      );
    }
  }

  Future<void> _onTestPrintUsb(
    TestPrintUsbEvent event,
    Emitter<SettingState> emit,
  ) async {
    final activeDevice = state.activeUsbDevice;
    if (activeDevice == null) return;

    emit(state.copyWith(isTestingUsb: true, feedback: () => null));
    _socketService.addConsoleLog(
      'Test print USB into ${activeDevice.name} (${activeDevice.address})',
    );

    try {
      await _usbService.testPrint();
      _socketService.addConsoleLog('Test print USB success');
      emit(
        state.copyWith(
          isTestingUsb: false,
          feedback: () => SettingFeedback.success(
            'Test print USB ke "${activeDevice.name}" berhasil',
          ),
        ),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      _socketService.addConsoleLog('Test print USB failed.\n$error');
      emit(
        state.copyWith(
          isTestingUsb: false,
          feedback: () => SettingFeedback.error(error.toString()),
        ),
      );
    }
  }

  Future<void> _onTestPrintNetwork(
    TestPrintNetworkEvent event,
    Emitter<SettingState> emit,
  ) async {
    final ip = event.ipAddress.trim();
    emit(state.copyWith(isTestingNetwork: true, feedback: () => null));
    _socketService.addConsoleLog('Test print Network into $ip:9100');

    try {
      await _networkService.testPrint(ip: ip);
      _socketService.addConsoleLog('Test print Network success');
      emit(
        state.copyWith(
          isTestingNetwork: false,
          feedback: () => SettingFeedback.success(
            'Test print Network ke "$ip" berhasil',
          ),
        ),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      _socketService.addConsoleLog('Test print Network failed.\n$error');
      emit(
        state.copyWith(
          isTestingNetwork: false,
          feedback: () => SettingFeedback.error(error.toString()),
        ),
      );
    }
  }

  void _onClearFeedback(
    ClearSettingFeedbackEvent event,
    Emitter<SettingState> emit,
  ) {
    emit(state.copyWith(feedback: () => null));
  }

  @override
  Future<void> close() async {
    await _bluetoothScanSubscription?.cancel();
    await _usbScanSubscription?.cancel();
    await _bluetoothService.stopScan();
    await _usbService.stopScan();
    return super.close();
  }
}
