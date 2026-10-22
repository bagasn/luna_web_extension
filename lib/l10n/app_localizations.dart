import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @app_name.
  ///
  /// In id, this message translates to:
  /// **'Printer Extension'**
  String get app_name;

  /// No description provided for @app_copyright.
  ///
  /// In id, this message translates to:
  /// **'© 2026 - PT LUNA Aplikasi Indonesia. All rights reserved.'**
  String get app_copyright;

  /// No description provided for @app_lunaposBrandingText.
  ///
  /// In id, this message translates to:
  /// **'Satu Aplikasi Kasir untuk Semua Jenis Usaha'**
  String get app_lunaposBrandingText;

  /// No description provided for @title_selectDateRange.
  ///
  /// In id, this message translates to:
  /// **'Pilih Rentang Tanggal'**
  String get title_selectDateRange;

  /// No description provided for @title_selectItem.
  ///
  /// In id, this message translates to:
  /// **'Pilih Item'**
  String get title_selectItem;

  /// No description provided for @title_filter.
  ///
  /// In id, this message translates to:
  /// **'Filter'**
  String get title_filter;

  /// No description provided for @title_printerSetting.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan Printer'**
  String get title_printerSetting;

  /// No description provided for @title_bluetoothPrinter.
  ///
  /// In id, this message translates to:
  /// **'Printer Bluetooth'**
  String get title_bluetoothPrinter;

  /// No description provided for @title_usbPrinter.
  ///
  /// In id, this message translates to:
  /// **'Printer USB'**
  String get title_usbPrinter;

  /// No description provided for @title_networkPrinter.
  ///
  /// In id, this message translates to:
  /// **'Printer Network (LAN)'**
  String get title_networkPrinter;

  /// No description provided for @btn_needHelp.
  ///
  /// In id, this message translates to:
  /// **'Butuh Bantuan'**
  String get btn_needHelp;

  /// No description provided for @btn_refresh.
  ///
  /// In id, this message translates to:
  /// **'Ulangi'**
  String get btn_refresh;

  /// No description provided for @btn_save.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get btn_save;

  /// No description provided for @btn_clear.
  ///
  /// In id, this message translates to:
  /// **'Reset'**
  String get btn_clear;

  /// No description provided for @btn_showDetail.
  ///
  /// In id, this message translates to:
  /// **'Lihat Detail'**
  String get btn_showDetail;

  /// No description provided for @btn_submit.
  ///
  /// In id, this message translates to:
  /// **'Submit'**
  String get btn_submit;

  /// No description provided for @btn_apply.
  ///
  /// In id, this message translates to:
  /// **'Terapkan'**
  String get btn_apply;

  /// No description provided for @btn_seeAll.
  ///
  /// In id, this message translates to:
  /// **'Lihat Semua'**
  String get btn_seeAll;

  /// No description provided for @btn_edit.
  ///
  /// In id, this message translates to:
  /// **'Ubah'**
  String get btn_edit;

  /// No description provided for @btn_add.
  ///
  /// In id, this message translates to:
  /// **'Tambah'**
  String get btn_add;

  /// No description provided for @btn_delete.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get btn_delete;

  /// No description provided for @btn_skip.
  ///
  /// In id, this message translates to:
  /// **'Lewati'**
  String get btn_skip;

  /// No description provided for @btn_scanPrinter.
  ///
  /// In id, this message translates to:
  /// **'Scan Perangkat'**
  String get btn_scanPrinter;

  /// No description provided for @btn_stopScan.
  ///
  /// In id, this message translates to:
  /// **'Hentikan Scan'**
  String get btn_stopScan;

  /// No description provided for @btn_setActive.
  ///
  /// In id, this message translates to:
  /// **'Jadikan Aktif'**
  String get btn_setActive;

  /// No description provided for @btn_removeActive.
  ///
  /// In id, this message translates to:
  /// **'Hapus Aktif'**
  String get btn_removeActive;

  /// No description provided for @btn_testPrint.
  ///
  /// In id, this message translates to:
  /// **'Test Print'**
  String get btn_testPrint;

  /// No description provided for @txt_server.
  ///
  /// In id, this message translates to:
  /// **'Server'**
  String get txt_server;

  /// No description provided for @txt_open.
  ///
  /// In id, this message translates to:
  /// **'Open'**
  String get txt_open;

  /// No description provided for @txt_closed.
  ///
  /// In id, this message translates to:
  /// **'Selesai'**
  String get txt_closed;

  /// No description provided for @txt_paid.
  ///
  /// In id, this message translates to:
  /// **'Dibayar'**
  String get txt_paid;

  /// No description provided for @txt_printerSettingSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Atur perangkat printer Bluetooth dan USB yang aktif, serta lakukan uji cetak (Test Print).'**
  String get txt_printerSettingSubtitle;

  /// No description provided for @txt_noActivePrinter.
  ///
  /// In id, this message translates to:
  /// **'Belum ada perangkat printer yang dipilih sebagai aktif.'**
  String get txt_noActivePrinter;

  /// No description provided for @txt_noScannedDevices.
  ///
  /// In id, this message translates to:
  /// **'Belum ada perangkat ditemukan. Tekan tombol Scan untuk mencari perangkat.'**
  String get txt_noScannedDevices;

  /// No description provided for @txt_scanningDevices.
  ///
  /// In id, this message translates to:
  /// **'Sedang mencari perangkat printer...'**
  String get txt_scanningDevices;

  /// No description provided for @txt_networkPrinterDesc.
  ///
  /// In id, this message translates to:
  /// **'Koneksi Network tidak perlu diatur sebagai perangkat aktif. Masukkan alamat IP printer untuk melakukan Test Print.'**
  String get txt_networkPrinterDesc;

  /// No description provided for @lbl_shortTrillion.
  ///
  /// In id, this message translates to:
  /// **'T'**
  String get lbl_shortTrillion;

  /// No description provided for @lbl_shortBillion.
  ///
  /// In id, this message translates to:
  /// **'M'**
  String get lbl_shortBillion;

  /// No description provided for @lbl_shortMillion.
  ///
  /// In id, this message translates to:
  /// **'Jt'**
  String get lbl_shortMillion;

  /// No description provided for @lbl_shortThousand.
  ///
  /// In id, this message translates to:
  /// **'Rb'**
  String get lbl_shortThousand;

  /// No description provided for @lbl_firstName.
  ///
  /// In id, this message translates to:
  /// **'Nama Depan'**
  String get lbl_firstName;

  /// No description provided for @lbl_lastName.
  ///
  /// In id, this message translates to:
  /// **'Nama Belakang'**
  String get lbl_lastName;

  /// No description provided for @lbl_pickImage.
  ///
  /// In id, this message translates to:
  /// **'Pilih Gambar'**
  String get lbl_pickImage;

  /// No description provided for @lbl_activeDevice.
  ///
  /// In id, this message translates to:
  /// **'Perangkat Aktif'**
  String get lbl_activeDevice;

  /// No description provided for @lbl_availableDevices.
  ///
  /// In id, this message translates to:
  /// **'Perangkat Tersedia'**
  String get lbl_availableDevices;

  /// No description provided for @lbl_active.
  ///
  /// In id, this message translates to:
  /// **'Aktif'**
  String get lbl_active;

  /// No description provided for @lbl_ipAddress.
  ///
  /// In id, this message translates to:
  /// **'Alamat IP'**
  String get lbl_ipAddress;

  /// No description provided for @err_invalidEmail.
  ///
  /// In id, this message translates to:
  /// **'Alamat email tidak valid'**
  String get err_invalidEmail;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
