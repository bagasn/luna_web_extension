enum PrintErrorType {
  invalidPrinterType,
  noActiveDevice,
  invalidAddress,
  invalidPort,
  emptyData,
  invalidData,
  unreachable,
  busy,
  sendFailed,
}

class PrintException implements Exception {
  final PrintErrorType errorType;
  final String message;

  const PrintException(this.errorType, this.message);

  @override
  String toString() => message;
}
