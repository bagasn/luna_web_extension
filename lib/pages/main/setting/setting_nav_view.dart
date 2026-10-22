import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/l10n/app_localizations.dart';
import 'package:web_extension/pages/main/setting/bloc/setting_bloc.dart';
import 'package:web_extension/shared/data/printer_device.dart';

class SettingNavView extends StatefulWidget {
  const SettingNavView({super.key});

  @override
  State<SettingNavView> createState() => _SettingNavViewState();
}

class _SettingNavViewState extends State<SettingNavView> {
  final _ipTextPrint = TextEditingController(text: '192.168.0.111');

  @override
  void dispose() {
    _ipTextPrint.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<SettingBloc, SettingState>(
      listenWhen: (previous, current) =>
          previous.feedback != current.feedback && current.feedback != null,
      listener: (context, state) {
        final feedback = state.feedback;
        if (feedback == null) return;

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(feedback.message),
              backgroundColor: feedback.isError
                  ? AppColors.red700
                  : AppColors.green800,
              behavior: SnackBarBehavior.floating,
            ),
          );
        context.read<SettingBloc>().add(const ClearSettingFeedbackEvent());
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 24,
            children: [
              _buildHeader(context, l10n),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 820;
                  final bluetoothCard = _PrinterConnectionSection(
                    icon: Icons.bluetooth,
                    title: l10n.title_bluetoothPrinter,
                    activeDevice: state.activeBluetoothDevice,
                    scannedDevices: state.scannedBluetoothDevices,
                    isScanning: state.isScanningBluetooth,
                    isSelecting: state.isSelectingBluetooth,
                    isTestingPrint: state.isTestingBluetooth,
                    onToggleScan: () {
                      final bloc = context.read<SettingBloc>();
                      if (state.isScanningBluetooth) {
                        bloc.add(const StopScanBluetoothDevicesEvent());
                      } else {
                        bloc.add(const ScanBluetoothDevicesEvent());
                      }
                    },
                    onSelectDevice: (device) {
                      context.read<SettingBloc>().add(
                        SelectBluetoothDeviceEvent(device),
                      );
                    },
                    onRemoveActive: () {
                      context.read<SettingBloc>().add(
                        const RemoveBluetoothDeviceEvent(),
                      );
                    },
                    onTestPrint: () {
                      context.read<SettingBloc>().add(
                        const TestPrintBluetoothEvent(),
                      );
                    },
                  );

                  final usbCard = _PrinterConnectionSection(
                    icon: Icons.usb,
                    title: l10n.title_usbPrinter,
                    activeDevice: state.activeUsbDevice,
                    scannedDevices: state.scannedUsbDevices,
                    isScanning: state.isScanningUsb,
                    isSelecting: state.isSelectingUsb,
                    isTestingPrint: state.isTestingUsb,
                    onToggleScan: () {
                      final bloc = context.read<SettingBloc>();
                      if (state.isScanningUsb) {
                        bloc.add(const StopScanUsbDevicesEvent());
                      } else {
                        bloc.add(const ScanUsbDevicesEvent());
                      }
                    },
                    onSelectDevice: (device) {
                      context.read<SettingBloc>().add(
                        SelectUsbDeviceEvent(device),
                      );
                    },
                    onRemoveActive: () {
                      context.read<SettingBloc>().add(
                        const RemoveUsbDeviceEvent(),
                      );
                    },
                    onTestPrint: () {
                      context.read<SettingBloc>().add(
                        const TestPrintUsbEvent(),
                      );
                    },
                  );

                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: [
                        Expanded(child: bluetoothCard),
                        Expanded(child: usbCard),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 24,
                    children: [bluetoothCard, usbCard],
                  );
                },
              ),
              _buildNetworkPrintSection(context, l10n, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          l10n.title_printerSetting,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        Text(
          l10n.txt_printerSettingSubtitle,
          style: textTheme.bodyMedium?.copyWith(color: AppColors.charcoal700),
        ),
      ],
    );
  }

  Widget _buildNetworkPrintSection(
    BuildContext context,
    AppLocalizations l10n,
    SettingState state,
  ) {
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
                  onPressed: state.isTestingNetwork
                      ? null
                      : () {
                          context.read<SettingBloc>().add(
                            TestPrintNetworkEvent(_ipTextPrint.text),
                          );
                        },
                  icon: state.isTestingNetwork
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

class _PrinterConnectionSection extends StatelessWidget {
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

  const _PrinterConnectionSection({
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

  bool _isSameDevice(PrinterDevice a, PrinterDevice b) {
    return a.address == b.address && a.name == b.name;
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
          _buildActiveDeviceBox(context, l10n, textTheme),
          _buildScannedDevicesSection(context, l10n, textTheme),
        ],
      ),
    );
  }

  Widget _buildActiveDeviceBox(
    BuildContext context,
    AppLocalizations l10n,
    TextTheme textTheme,
  ) {
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

  Widget _buildScannedDevicesSection(
    BuildContext context,
    AppLocalizations l10n,
    TextTheme textTheme,
  ) {
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
