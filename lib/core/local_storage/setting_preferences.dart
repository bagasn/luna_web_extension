import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _KEY {
  static const language = 'SETTING_APP_LANGUAGE';
  static const lastServerPort = 'SETTING_LAST_SERVER_PORT';
}

@singleton
class SettingPreferences {
  final _preferences = SharedPreferencesAsync();

  Future<void> setLocale(String localeCode) async {
    await _preferences.setString(_KEY.language, localeCode);
  }

  Future<String?> getLocale() => _preferences.getString(_KEY.language);

  Future<void> setLastServerPort(int serverPort) async {
    await _preferences.setInt(_KEY.lastServerPort, serverPort);
  }

  Future<int> getLastServerPort() async {
    final value = await _preferences.getInt(_KEY.lastServerPort);
    return value ?? 8921;
  }

  Future<void> clear() async {
    await _preferences.remove(_KEY.language);
    await _preferences.remove(_KEY.lastServerPort);
  }
}
