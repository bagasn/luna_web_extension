class PrinterDevice {
  final String address;
  final String name;
  final String? vendorId;
  final String? productId;

  PrinterDevice({
    required this.address,
    required this.name,
    this.vendorId,
    this.productId,
  });
}
