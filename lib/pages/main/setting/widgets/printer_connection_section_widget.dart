import 'package:flutter/material.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/pages/main/setting/widgets/active_printer_card_widget.dart';
import 'package:web_extension/pages/main/setting/widgets/scanned_printer_list_widget.dart';
import 'package:web_extension/shared/data/printer_device.dart';

class PrinterConnectionSectionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final PrinterDevice? activeDevice;
  final List<PrinterDevice> scannedDevices;
  final bool isScanning;
  final bool isSelecting;
  final bool isTestingPrint;
  final VoidCallback onToggleScan;
  final ValueChanged<PrinterDevice> onSelectDevice;
  final VoidCallback onRemoveActive;
  final VoidCallback onTestPrint;

  const PrinterConnectionSectionWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.activeDevice,
    required this.scannedDevices,
    required this.isScanning,
    required this.isSelecting,
    required this.isTestingPrint,
    required this.onToggleScan,
    required this.onSelectDevice,
    required this.onRemoveActive,
    required this.onTestPrint,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.charcoal200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Row(
            spacing: 10,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.purple25,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.mainColor, size: 22),
              ),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 1),
          ActivePrinterCardWidget(
            activeDevice: activeDevice,
            isTestingPrint: isTestingPrint,
            onTestPrint: onTestPrint,
            onRemoveActive: onRemoveActive,
          ),
          ScannedPrinterListWidget(
            activeDevice: activeDevice,
            scannedDevices: scannedDevices,
            isScanning: isScanning,
            isSelecting: isSelecting,
            onToggleScan: onToggleScan,
            onSelectDevice: onSelectDevice,
          ),
        ],
      ),
    );
  }
}

