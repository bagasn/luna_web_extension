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

import '../../shared/services/language_service.dart' as _i480;
import '../../shared/services/socket_service.dart' as _i1024;
import '../local_storage/session_manager.dart' as _i671;
import '../local_storage/setting_preferences.dart' as _i329;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i329.SettingPreferences>(() => _i329.SettingPreferences());
    gh.singleton<_i1024.WebSocketService>(() => _i1024.WebSocketService());
    gh.singleton<_i671.SessionManager>(
      () => _i671.SessionManager(setting: gh<_i329.SettingPreferences>()),
    );
    gh.singleton<_i480.LanguageService>(
      () => _i480.LanguageService(gh<_i329.SettingPreferences>()),
    );
    return this;
  }
}
