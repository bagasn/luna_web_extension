// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

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
  String get title_printerSetting => 'Pengaturan Printer';

  @override
  String get title_bluetoothPrinter => 'Printer Bluetooth';

  @override
  String get title_usbPrinter => 'Printer USB';

  @override
  String get title_networkPrinter => 'Printer Network (LAN)';

  @override
  String get title_serverPrinter => 'Server Printer';

  @override
  String get title_serverStatus => 'Status Server';

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
  String get btn_scanPrinter => 'Scan Perangkat';

  @override
  String get btn_stopScan => 'Hentikan Scan';

  @override
  String get btn_setActive => 'Jadikan Aktif';

  @override
  String get btn_removeActive => 'Hapus Aktif';

  @override
  String get btn_testPrint => 'Test Print';

  @override
  String get btn_startServer => 'Jalankan Server';

  @override
  String get btn_stopServer => 'Hentikan Server';

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
      'Atur perangkat printer Bluetooth dan USB yang aktif, serta lakukan uji cetak (Test Print).';

  @override
  String get txt_serverPrinterSubtitle =>
      'Kelola koneksi server WebSocket lokal dan pantau log aktivitas pencetakan.';

  @override
  String get txt_noActivePrinter =>
      'Belum ada perangkat printer yang dipilih sebagai aktif.';

  @override
  String get txt_noScannedDevices =>
      'Belum ada perangkat ditemukan. Tekan tombol Scan untuk mencari perangkat.';

  @override
  String get txt_scanningDevices => 'Sedang mencari perangkat printer...';

  @override
  String get txt_networkPrinterDesc =>
      'Koneksi Network tidak perlu diatur sebagai perangkat aktif. Masukkan alamat IP printer untuk melakukan Test Print.';

  @override
  String get txt_noConsoleLogs => 'Belum ada aktivitas log.';

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
  String get lbl_activeDevice => 'Perangkat Aktif';

  @override
  String get lbl_availableDevices => 'Perangkat Tersedia';

  @override
  String get lbl_active => 'Aktif';

  @override
  String get lbl_serverStatus => 'Status Server';

  @override
  String get lbl_running => 'Berjalan';

  @override
  String get lbl_stopped => 'Berhenti';

  @override
  String get lbl_serverPort => 'Port Server';

  @override
  String get txt_serverPortHint =>
      'Port yang digunakan web app untuk terhubung ke server lokal ini.';

  @override
  String get err_invalidPort => 'Port harus berupa angka 1024 - 65535';

  @override
  String get lbl_ipAddress => 'Alamat IP';

  @override
  String get err_invalidEmail => 'Alamat email tidak valid';
}
