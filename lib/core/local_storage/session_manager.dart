import 'package:injectable/injectable.dart';
import 'package:web_extension/core/local_storage/setting_preferences.dart';

@singleton
class SessionManager {
  final SettingPreferences setting;

  SessionManager({required this.setting});
}
