import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:web_extension/shared/services/socket_service.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final WebSocketService _socketService;

  HomeCubit({required this._socketService})
    : super(HomeState(isServerRunning: false)) {
    if (_socketService.isRunning) {
      emit(HomeState(isServerRunning: true));
    }
  }

  void onStartServer() {
    if (!_socketService.isRunning) {
      _socketService.startServer();
      emit(HomeState(isServerRunning: true));
    }
  }

  void onStopServer() {
    if (_socketService.isRunning) {
      _socketService.stopServer();
      emit(HomeState(isServerRunning: false));
    }
  }
}
