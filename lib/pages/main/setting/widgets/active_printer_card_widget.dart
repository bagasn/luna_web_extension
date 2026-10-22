import 'package:flutter/material.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/l10n/app_localizations.dart';
import 'package:web_extension/shared/data/printer_device.dart';

class ActivePrinterCardWidget extends StatelessWidget {
  final PrinterDevice? activeDevice;
  final bool isTestingPrint;
  final VoidCallback onTestPrint;
  final VoidCallback onRemoveActive;

  const ActivePrinterCardWidget({
    super.key,
    required this.activeDevice,
    required this.isTestingPrint,
    required this.onTestPrint,
    required this.onRemoveActive,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final current = activeDevice;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: current != null ? AppColors.purple25 : AppColors.charcoal50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: current != null ? AppColors.purple300 : AppColors.charcoal200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.lbl_activeDevice,
                  style: textTheme.labelLarge?.copyWith(
                    color: AppColors.charcoal700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (current != null)
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
                ),
            ],
          ),
          if (current == null)
            Text(
              l10n.txt_noActivePrinter,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.charcoal500,
              ),
            )
          else ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  current.name,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  current.address,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.charcoal700,
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: isTestingPrint ? null : onTestPrint,
                  icon: isTestingPrint
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.print_outlined, size: 18),
                  label: Text(l10n.btn_testPrint),
                ),
                OutlinedButton.icon(
                  onPressed: isTestingPrint ? null : onRemoveActive,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.red700,
                    side: const BorderSide(color: AppColors.red700),
                  ),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: Text(l10n.btn_removeActive),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

