// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Printer Extension';

  @override
  String get app_copyright =>
      '© 2026 - PT LUNA Aplikasi Indonesia. All rights reserved.';

  @override
  String get app_lunaposBrandingText =>
      'Satu Aplikasi Kasir untuk Semua Jenis Usaha';

  @override
  String get title_selectDateRange => 'Pilih Rentang Tanggal';

  @override
  String get title_selectItem => 'Pilih Item';

  @override
  String get title_filter => 'Filter';

  @override
  String get title_printerSetting => 'Printer Settings';

  @override
  String get title_bluetoothPrinter => 'Bluetooth Printer';

  @override
  String get title_usbPrinter => 'USB Printer';

  @override
  String get title_networkPrinter => 'Network Printer (LAN)';

  @override
  String get title_serverPrinter => 'Printer Server';

  @override
  String get title_serverStatus => 'Server Status';

  @override
  String get title_consoleLog => 'Console Log';

  @override
  String get btn_needHelp => 'Butuh Bantuan';

  @override
  String get btn_refresh => 'Ulangi';

  @override
  String get btn_save => 'Simpan';

  @override
  String get btn_clear => 'Reset';

  @override
  String get btn_showDetail => 'Lihat Detail';

  @override
  String get btn_submit => 'Submit';

  @override
  String get btn_apply => 'Terapkan';

  @override
  String get btn_seeAll => 'Lihat Semua';

  @override
  String get btn_edit => 'Ubah';

  @override
  String get btn_add => 'Tambah';

  @override
  String get btn_delete => 'Hapus';

  @override
  String get btn_skip => 'Lewati';

  @override
  String get btn_scanPrinter => 'Scan Devices';

  @override
  String get btn_stopScan => 'Stop Scan';

  @override
  String get btn_setActive => 'Set Active';

  @override
  String get btn_removeActive => 'Remove Active';

  @override
  String get btn_testPrint => 'Test Print';

  @override
  String get btn_startServer => 'Start Server';

  @override
  String get btn_stopServer => 'Stop Server';

  @override
  String get txt_server => 'Server';

  @override
  String get txt_open => 'Open';

  @override
  String get txt_closed => 'Selesai';

  @override
  String get txt_paid => 'Dibayar';

  @override
  String get txt_printerSettingSubtitle =>
      'Configure active Bluetooth and USB printer devices, and run test prints.';

  @override
  String get txt_serverPrinterSubtitle =>
      'Manage the local WebSocket server connection and monitor printing activity logs.';

  @override
  String get txt_noActivePrinter =>
      'No printer device is currently set as active.';

  @override
  String get txt_noScannedDevices =>
      'No devices found yet. Press Scan to search for devices.';

  @override
  String get txt_scanningDevices => 'Scanning for printer devices...';

  @override
  String get txt_networkPrinterDesc =>
      'Network connection does not need to be set as an active device. Enter the printer IP address to run a Test Print.';

  @override
  String get txt_noConsoleLogs => 'No log activity yet.';

  @override
  String get lbl_shortTrillion => 'T';

  @override
  String get lbl_shortBillion => 'M';

  @override
  String get lbl_shortMillion => 'Jt';

  @override
  String get lbl_shortThousand => 'Rb';

  @override
  String get lbl_firstName => 'Nama Depan';

  @override
  String get lbl_lastName => 'Nama Belakang';

  @override
  String get lbl_pickImage => 'Pilih Gambar';

  @override
  String get lbl_activeDevice => 'Active Device';

  @override
  String get lbl_availableDevices => 'Available Devices';

  @override
  String get lbl_active => 'Active';

  @override
  String get lbl_serverStatus => 'Server Status';

  @override
  String get lbl_running => 'Running';

  @override
  String get lbl_stopped => 'Stopped';

  @override
  String get lbl_serverPort => 'Server Port';

  @override
  String get txt_serverPortHint =>
      'The port the web app uses to connect to this local server.';

  @override
  String get err_invalidPort => 'Port must be a number between 1024 - 65535';

  @override
  String get lbl_ipAddress => 'IP Address';

  @override
  String get err_invalidEmail => 'Alamat email tidak valid';
}
