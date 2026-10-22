import 'package:flutter/material.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/l10n/app_localizations.dart';
import 'package:web_extension/shared/data/printer_device.dart';

class ScannedPrinterListWidget extends StatelessWidget {
  final PrinterDevice? activeDevice;
  final List<PrinterDevice> scannedDevices;
  final bool isScanning;
  final bool isSelecting;
  final VoidCallback onToggleScan;
  final ValueChanged<PrinterDevice> onSelectDevice;

  const ScannedPrinterListWidget({
    super.key,
    required this.activeDevice,
    required this.scannedDevices,
    required this.isScanning,
    required this.isSelecting,
    required this.onToggleScan,
    required this.onSelectDevice,
  });

  bool _isSameDevice(PrinterDevice a, PrinterDevice b) {
    return a.address == b.address && a.name == b.name;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.lbl_availableDevices,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: onToggleScan,
              icon: Icon(
                isScanning ? Icons.stop_circle_outlined : Icons.search,
                size: 18,
              ),
              label: Text(
                isScanning ? l10n.btn_stopScan : l10n.btn_scanPrinter,
              ),
            ),
          ],
        ),
        if (isScanning)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 6,
            children: [
              const LinearProgressIndicator(),
              Text(
                l10n.txt_scanningDevices,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.charcoal700,
                ),
              ),
            ],
          ),
        if (scannedDevices.isEmpty && !isScanning)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.charcoal50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              l10n.txt_noScannedDevices,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.charcoal500,
              ),
            ),
          )
        else if (scannedDevices.isNotEmpty)
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 260),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: scannedDevices.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final device = scannedDevices[index];
                final isActive = activeDevice != null &&
                    _isSameDevice(activeDevice!, device);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              device.name,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              device.address,
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.charcoal700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isActive)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            l10n.lbl_active,
                            style: textTheme.labelSmall?.copyWith(
                              color: AppColors.green800,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      else
                        FilledButton(
                          onPressed: isSelecting
                              ? null
                              : () => onSelectDevice(device),
                          child: Text(l10n.btn_setActive),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

