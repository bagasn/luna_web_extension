import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_extension/shared/constants/error/exceptions.dart';
import 'package:web_extension/shared/services/printer/bluetooth_printer_service.dart';
import 'package:web_extension/shared/services/printer/network_printer_service.dart';
import 'package:web_extension/shared/services/printer/usb_printer_service.dart';
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
  WebSocketService(
    this._networkPrinterService,
    this._bluetoothPrinterService,
    this._usbPrinterService,
  );

  final NetworkPrinterService _networkPrinterService;
  final BluetoothPrinterService _bluetoothPrinterService;
  final UsbPrinterService _usbPrinterService;

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
      addConsoleLog(
        'Gagal menjalankan server\n$error',
        type: ConsoleLogType.error,
      );
    }
  }

  void _onDataSocketListener(
    dynamic data, {
    required WebSocketChannel channel,
  }) async {
    try {
      final decoded = jsonDecode(data);
      if (decoded is! Map<String, dynamic>) {
        throw const PrintException(
          PrintErrorType.invalidData,
          'Invalid print request payload',
        );
      }

      final printerType = (decoded['printerType'] as String?)
          ?.trim()
          .toLowerCase();
      final printBytes = ((decoded['bytes'] as List?) ?? const []).cast<int>();

      switch (printerType) {
        case 'bluetooth':
          final activeDevice = await _bluetoothPrinterService
              .requireActiveDevice();
          addConsoleLog(
            'Get request for printing via Bluetooth: ${activeDevice.name} (${activeDevice.address})',
          );
          await _bluetoothPrinterService.printBytes(printBytes);
          addConsoleLog(
            'Successfully printing data via Bluetooth: ${activeDevice.name}',
            type: ConsoleLogType.debug,
          );
          break;

        case 'usb':
          final activeDevice = await _usbPrinterService.requireActiveDevice();
          addConsoleLog(
            'Get request for printing via USB: ${activeDevice.name} (${activeDevice.address})',
          );
          await _usbPrinterService.printBytes(printBytes);
          addConsoleLog(
            'Successfully printing data via USB: ${activeDevice.name}',
            type: ConsoleLogType.debug,
          );
          break;

        case 'network':
        case null:
        case '':
          final targetIp = decoded['ipAddress'] as String?;
          final targetPort =
              (decoded['port'] as int?) ?? NetworkPrinterService.defaultPort;
          addConsoleLog('Get request for printing into address: $targetIp');
          await _networkPrinterService.printBytes(
            ip: targetIp ?? '',
            port: targetPort,
            bytes: printBytes,
          );
          addConsoleLog(
            'Successfully printing data into address $targetIp',
            type: ConsoleLogType.debug,
          );
          break;

        default:
          throw PrintException(
            PrintErrorType.invalidPrinterType,
            'Tipe koneksi printer tidak dikenali: $printerType',
          );
      }

      channel.sink.add(jsonEncode({'status': 'success'}));
    } on PrintException catch (error) {
      addConsoleLog('Failure: ${error.message}', type: ConsoleLogType.error);
      channel.sink.add(
        jsonEncode({
          'status': 'failed',
          'message': error.message,
          'code': error.errorType.name,
        }),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      addConsoleLog('Failure: $error', type: ConsoleLogType.error);
      channel.sink.add(
        jsonEncode({
          'status': 'failed',
          'message': error.toString(),
          'code': PrintErrorType.sendFailed.name,
        }),
      );
    }
  }

  Future<void> stopServer() async {
    if (!isRunning) return;

    await _server?.close(force: true);
    _server = null;
    addConsoleLog('Server killed');
  }

  void addConsoleLog(
    String message, {
    ConsoleLogType type = ConsoleLogType.info,
  }) {
    try {
      final dateValue = DateFormatter.dateToString(
        DateTime.now(),
        pattern: 'dd/MM HH:mm:ss',
      );
      _consoleLogs.add(
        ConsoleLogModel(createAt: dateValue, message: message, type: type),
      );
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
    } finally {
      notifyListeners();
    }
  }
}
