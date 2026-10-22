import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/l10n/app_localizations.dart';
import 'package:web_extension/pages/main/setting/bloc/setting_bloc.dart';
import 'package:web_extension/pages/main/setting/widgets/network_printer_section_widget.dart';
import 'package:web_extension/pages/main/setting/widgets/printer_connection_section_widget.dart';

class SettingNavView extends StatelessWidget {
  const SettingNavView({super.key});

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
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, l10n),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16,
                  children: [
                    NetworkPrinterSectionWidget(
                      isTestingNetwork: state.isTestingNetwork,
                      onTestPrint: (ipAddress) {
                        context.read<SettingBloc>().add(
                          TestPrintNetworkEvent(ipAddress),
                        );
                      },
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 820;
                        final bluetoothCard = PrinterConnectionSectionWidget(
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

                        final usbCard = PrinterConnectionSectionWidget(
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
                            spacing: 16,
                            children: [
                              Expanded(child: bluetoothCard),
                              Expanded(child: usbCard),
                            ],
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 16,
                          children: [bluetoothCard, usbCard],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      elevation: 1,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.charcoal700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
