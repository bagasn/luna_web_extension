import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:injectable/injectable.dart';
import 'package:web_extension/core/dep_injections/injection_container.dart';
import 'package:web_extension/shared/services/printer/network_printer_service.dart';
import 'package:web_extension/shared/services/socket_service.dart';
import 'package:web_extension/shared/utilities/log_util.dart';

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

  void onStartServer() async {
    if (!_socketService.isRunning) {
      await _socketService.startServer();
      emit(HomeState(isServerRunning: true));
    }
  }

  void onStopServer() {
    if (_socketService.isRunning) {
      _socketService.stopServer();
      emit(HomeState(isServerRunning: false));
    }
  }

  void onTestPrint(String ipAddress) async {
    final printer = locator<NetworkPrinterService>();

    _socketService.addConsoleLog('Test print into $ipAddress:9100');

    try {
      // await printer.checkConnection(ipAddress);
      // _socketService.addConsoleLog('Test connection to $ipAddress is success');

      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);

      final bytes = <int>[
        ...generator.text('Test Print'),
        ...generator.feed(1),
        ...generator.cut(),
      ];

      final socket = await Socket.connect(
        ipAddress,
        9100,
        timeout: const Duration(seconds: 5),
      );

      socket.add(bytes);
      await socket.flush();
      await socket.close();

      _socketService.addConsoleLog('Print is Success');
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      _socketService.addConsoleLog('Test Print Failed.\n$error');
    }
  }
}
