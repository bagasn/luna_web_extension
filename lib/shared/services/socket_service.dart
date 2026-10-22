import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_extension/shared/constants/error/exceptions.dart';
import 'package:web_extension/shared/services/printer/network_printer_service.dart';
import 'package:web_extension/shared/utilities/date_formatter.dart';
import 'package:web_extension/shared/utilities/log_util.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum ConsoleLogType { debug, info, error }

class ConsoleLogModel {
  final String createAt;
  final String message;
  final ConsoleLogType type;

  const new({
    required this.createAt,
    required this.message,
    this.type = ConsoleLogType.info,
  });
}

@singleton
class WebSocketService extends ChangeNotifier {
  WebSocketService(this._printerService);

  final NetworkPrinterService _printerService;

  HttpServer? _server;
  bool get isRunning => _server != null;

  final List<ConsoleLogModel> _consoleLogs = [];
  List<ConsoleLogModel> get consoleLogs => List.unmodifiable(_consoleLogs);

  Future<void> startServer({int port = 8921}) async {
    if (isRunning) return;

    final wsHandler = webSocketHandler(((webSocket, subprotocol) {
      addConsoleLog('Socket connected in protocol: $subprotocol');

      webSocket.stream.listen(
        (data) async {
          _onDataSocketListener(data, channel: webSocket);
        },
        onDone: () {
          addConsoleLog('Socket disconnected');
        },
      );
    }));

    try {
      _server = await shelf_io.serve(
        (request) {
          if (request.method == 'OPTIONS') {
            return Response.ok(
              '',
              headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
                'Access-Control-Allow-Headers': 'Origin, Content-Type',
              },
            );
          }

          return wsHandler(request);
        },
        InternetAddress.loopbackIPv4,
        port,
      );
      addConsoleLog('Server is running in port: $port');
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      addConsoleLog('Gagal menjalankan server\n$error');
    }
  }

  void _onDataSocketListener(
    dynamic data, {
    required WebSocketChannel channel,
  }) async {
    try {
      final body = jsonDecode(data);
      final targetIp = body['ipAddress'] as String?;
      final printBytes = ((body['bytes'] as List?) ?? const []).cast<int>();

      addConsoleLog('Get request for printing into address: $targetIp');

      final socket = await Socket.connect(
        targetIp,
        9100,
        timeout: const Duration(seconds: 5),
      );

      socket.add(printBytes);
      await socket.flush();
      await socket.close();

      addConsoleLog('Successfully printing data into address $targetIp');

      channel.sink.add(jsonEncode({'status': 'success'}));
    } on PrintException catch (error) {
      addConsoleLog('Failure: ${error.message}');
      channel.sink.add(
        jsonEncode({
          'status': 'failed',
          'message': error.message,
          'code': error.errorType.name,
        }),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      addConsoleLog('Failure: $error');
      channel.sink.add(
        jsonEncode({'status': 'failed', 'message': error.toString()}),
      );
    }
  }

  Future<void> stopServer() async {
    if (!isRunning) return;

    await _server?.close(force: true);
    _server = null;
    addConsoleLog('Server killed');
  }

  void addConsoleLog(String message) {
    try {
      final dateValue = DateFormatter.dateToString(
        DateTime.now(),
        pattern: 'dd/MM HH:mm:ss',
      );
      _consoleLogs.add(ConsoleLogModel(createAt: dateValue, message: message));
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
    } finally {
      notifyListeners();
    }
  }
}
