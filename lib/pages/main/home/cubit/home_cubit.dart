import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:web_extension/core/local_storage/setting_preferences.dart';
import 'package:web_extension/shared/services/socket_service.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  static const int defaultPort = 8921;
  static const int minPort = 1024;
  static const int maxPort = 65535;

  final WebSocketService _socketService;
  final SettingPreferences _settingPreferences;

  HomeCubit({
    required this._socketService,
    required this._settingPreferences,
  }) : super(HomeState(isServerRunning: false)) {
    if (_socketService.isRunning) {
      emit(state.copyWith(isServerRunning: true));
    }
    _loadPort();
  }

  Future<void> _loadPort() async {
    final port = await _settingPreferences.getLastServerPort();
    if (!isClosed) emit(state.copyWith(port: port));
  }

  /// Returns `true` if [port] is a valid usable port number.
  static bool isValidPort(int? port) =>
      port != null && port >= minPort && port <= maxPort;

  /// Empty input (null) is allowed and falls back to [defaultPort].
  static bool isValidInput(int? port) => port == null || isValidPort(port);

  void onPortChanged(int? port) {
    if (state.isServerRunning) return;
    emit(state.copyWith(port: port, clearPort: port == null));
  }

  bool get canStart => !state.isServerRunning && isValidInput(state.port);

  Future<void> onStartServer() async {
    final inputPort = state.port;
    if (_socketService.isRunning || !isValidInput(inputPort)) return;
    final port = inputPort ?? defaultPort;

    await _socketService.startServer(port: port);
    if (_socketService.isRunning) {
      await _settingPreferences.setLastServerPort(port);
    }
    if (!isClosed) {
      emit(state.copyWith(isServerRunning: _socketService.isRunning));
    }
  }

  Future<void> onStopServer() async {
    if (_socketService.isRunning) {
      await _socketService.stopServer();
      emit(state.copyWith(isServerRunning: false));
    }
  }
}
