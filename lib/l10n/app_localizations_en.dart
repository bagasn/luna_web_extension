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
  String get lbl_ipAddress => 'IP Address';

  @override
  String get err_invalidEmail => 'Alamat email tidak valid';
}
