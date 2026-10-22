// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../pages/main/home/cubit/home_cubit.dart' as _i239;
import '../../pages/main/setting/bloc/setting_bloc.dart' as _i335;
import '../../shared/services/language_service.dart' as _i480;
import '../../shared/services/printer/bluetooth_printer_service.dart' as _i565;
import '../../shared/services/printer/network_printer_service.dart' as _i969;
import '../../shared/services/printer/usb_printer_service.dart' as _i385;
import '../../shared/services/socket_service.dart' as _i1024;
import '../local_storage/printer_bluetooth_preferences.dart' as _i242;
import '../local_storage/printer_usb_preferences.dart' as _i248;
import '../local_storage/session_manager.dart' as _i671;
import '../local_storage/setting_preferences.dart' as _i329;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i242.PrinterBluetoothDevicePreferences>(
      () => _i242.PrinterBluetoothDevicePreferences(),
    );
    gh.singleton<_i248.PrinterUsbDevicePreferences>(
      () => _i248.PrinterUsbDevicePreferences(),
    );
    gh.singleton<_i329.SettingPreferences>(() => _i329.SettingPreferences());
    gh.singleton<_i969.NetworkPrinterService>(
      () => _i969.NetworkPrinterService(),
    );
    gh.singleton<_i565.BluetoothPrinterService>(
      () => _i565.BluetoothPrinterService(
        gh<_i242.PrinterBluetoothDevicePreferences>(),
      ),
    );
    gh.singleton<_i385.UsbPrinterService>(
      () => _i385.UsbPrinterService(gh<_i248.PrinterUsbDevicePreferences>()),
    );
    gh.singleton<_i1024.WebSocketService>(
      () => _i1024.WebSocketService(gh<_i969.NetworkPrinterService>()),
    );
    gh.factory<_i335.SettingBloc>(
      () => _i335.SettingBloc(
        gh<_i565.BluetoothPrinterService>(),
        gh<_i385.UsbPrinterService>(),
        gh<_i969.NetworkPrinterService>(),
        gh<_i1024.WebSocketService>(),
      ),
    );
    gh.singleton<_i671.SessionManager>(
      () => _i671.SessionManager(
        setting: gh<_i329.SettingPreferences>(),
        bluetoothDevice: gh<_i242.PrinterBluetoothDevicePreferences>(),
        usbDevice: gh<_i248.PrinterUsbDevicePreferences>(),
      ),
    );
    gh.singleton<_i480.LanguageService>(
      () => _i480.LanguageService(gh<_i329.SettingPreferences>()),
    );
    gh.factory<_i239.HomeCubit>(
      () => _i239.HomeCubit(
        socketService: gh<_i1024.WebSocketService>(),
        settingPreferences: gh<_i329.SettingPreferences>(),
      ),
    );
    return this;
  }
}
