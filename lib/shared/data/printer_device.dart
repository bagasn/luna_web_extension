import 'package:equatable/equatable.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

class PrinterDevice extends Equatable {
  final String address;
  final String name;
  final String? vendorId;
  final String? productId;

  const PrinterDevice({
    required this.address,
    required this.name,
    this.vendorId,
    this.productId,
  });

  factory PrinterDevice.fromPrinter(Printer printer) {
    return PrinterDevice(
      address: printer.address ?? printer.vendorId ?? '',
      name: printer.name ?? '-',
      vendorId: printer.vendorId,
      productId: printer.productId,
    );
  }

  @override
  List<Object?> get props => [address, name, vendorId, productId];
}
