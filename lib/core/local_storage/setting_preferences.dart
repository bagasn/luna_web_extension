import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class _KEY {
  static const language = 'SETTING_APP_LANGUAGE';
}

@singleton
class SettingPreferences {
  final _preferences = SharedPreferencesAsync();

  Future<String?> getLocale() => _preferences.getString(_KEY.language);

  Future<void> setLocale(String localeCode) async {
    await _preferences.setString(_KEY.language, localeCode);
  }

  Future<void> clear() async {
    await _preferences.remove(_KEY.language);
  }
}
