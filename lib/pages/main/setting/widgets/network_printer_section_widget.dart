import 'package:flutter/material.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/l10n/app_localizations.dart';

class NetworkPrinterSectionWidget extends StatefulWidget {
  final bool isTestingNetwork;
  final ValueChanged<String> onTestPrint;

  const NetworkPrinterSectionWidget({
    super.key,
    required this.isTestingNetwork,
    required this.onTestPrint,
  });

  @override
  State<NetworkPrinterSectionWidget> createState() =>
      _NetworkPrinterSectionWidgetState();
}

class _NetworkPrinterSectionWidgetState
    extends State<NetworkPrinterSectionWidget> {
  final _ipTextPrint = TextEditingController();

  @override
  void dispose() {
    _ipTextPrint.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
        spacing: 12,
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
                child: const Icon(
                  Icons.lan_outlined,
                  color: AppColors.mainColor,
                  size: 22,
                ),
              ),
              Expanded(
                child: Text(
                  l10n.title_networkPrinter,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 1),
          Text(
            l10n.txt_networkPrinterDesc,
            style: textTheme.bodySmall?.copyWith(color: AppColors.charcoal700),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              Expanded(
                child: TextField(
                  controller: _ipTextPrint,
                  decoration: InputDecoration(
                    labelText: l10n.lbl_ipAddress,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(
                height: 46,
                child: FilledButton.icon(
                  onPressed: widget.isTestingNetwork
                      ? null
                      : () => widget.onTestPrint(_ipTextPrint.text),
                  icon: widget.isTestingNetwork
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
