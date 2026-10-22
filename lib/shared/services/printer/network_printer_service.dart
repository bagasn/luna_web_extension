import 'dart:io';

import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/network/network_print_result.dart';
import 'package:injectable/injectable.dart';
import 'package:web_extension/shared/constants/error/exceptions.dart';
import 'package:web_extension/shared/utilities/log_util.dart';

@singleton
class NetworkPrinterService {
  static const int defaultPort = 9100;
  static const Duration connectTimeout = Duration(seconds: 5);

  final Set<String> _busyPrinters = {};

  /// Validates input before touching the network.
  void validate({
    required String? ip,
    required int port,
    required List<int> bytes,
  }) {
    if (ip == null ||
        ip.trim().isEmpty ||
        InternetAddress.tryParse(ip.trim()) == null) {
      throw PrintException(
        PrintErrorType.invalidAddress,
        'Invalid printer IP address: $ip',
      );
    }
    if (port < 1 || port > 65535) {
      throw PrintException(
        PrintErrorType.invalidPort,
        'Invalid printer port: $port',
      );
    }
    if (bytes.isEmpty) {
      throw const PrintException(
        PrintErrorType.emptyData,
        'Print data is empty',
      );
    }
    if (bytes.any((b) => b < 0 || b > 255)) {
      throw const PrintException(
        PrintErrorType.invalidData,
        'Print data contains values outside 0-255',
      );
    }
  }

  /// Checks TCP reachability of the printer.
  Future<void> checkConnection(String ip, {int port = defaultPort}) async {
    try {
      final socket = await Socket.connect(ip, port, timeout: connectTimeout);
      socket.destroy();
    } on SocketException catch (error) {
      throw PrintException(
        PrintErrorType.unreachable,
        'Printer $ip:$port is unreachable: ${error.message}',
      );
    } on Exception catch (error) {
      throw PrintException(
        PrintErrorType.unreachable,
        'Printer $ip:$port is unreachable: $error',
      );
    }
  }

  /// Validates, checks connection, then sends bytes. One job per printer at a time.
  Future<void> printBytes({
    required String ip,
    int port = defaultPort,
    required List<int> bytes,
  }) async {
    validate(ip: ip, port: port, bytes: bytes);

    final address = ip.trim();
    final key = '$address:$port';
    if (!_busyPrinters.add(key)) {
      throw PrintException(
        PrintErrorType.busy,
        'Printer $key is busy with another job',
      );
    }

    try {
      await checkConnection(address, port: port);

      final printer = FlutterThermalPrinterNetwork(
        address,
        port: port,
        timeout: connectTimeout,
      );
      final result = await printer.printTicket(bytes);
      if (result != NetworkPrintResult.success) {
        throw PrintException(PrintErrorType.sendFailed, result.msg);
      }
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), stackTrace: stackTrace);
      rethrow;
    } finally {
      _busyPrinters.remove(key);
    }
  }
}
