import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:web_extension/core/local_storage/setting_preferences.dart';

enum LanguageCode { id, en }

@singleton
class LanguageService extends ChangeNotifier {
  static Locale localeEN = Locale(LanguageCode.en.name);
  static Locale localeID = Locale(LanguageCode.id.name);

  final SettingPreferences preferences;

  Locale _current = localeID;

  Locale get currentLocale => _current;

  LanguageService(this.preferences);

  Future<void> initiateLocale() async {
    String? savedLocale = await preferences.getLocale();

    if (savedLocale == null) {
      _current = localeID;
      notifyListeners();

      await preferences.setLocale(LanguageCode.id.name);
      return;
    }

    if (savedLocale == LanguageCode.id.name) {
      await setLocale(LanguageCode.id);
    } else {
      await setLocale(LanguageCode.en);
    }
  }

  Future<void> setLocale(LanguageCode localeCode) async {
    if (localeCode == LanguageCode.id) {
      _current = localeID;
    } else {
      _current = localeEN;
    }
    Intl.defaultLocale = localeCode.name;

    notifyListeners();
    await preferences.setLocale(localeCode.name);
  }
}
