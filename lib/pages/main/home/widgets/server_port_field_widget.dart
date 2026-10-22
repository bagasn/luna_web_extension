import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_extension/l10n/app_localizations.dart';
import 'package:web_extension/pages/main/home/cubit/home_cubit.dart';

class ServerPortFieldWidget extends StatefulWidget {
  const ServerPortFieldWidget({super.key});

  @override
  State<ServerPortFieldWidget> createState() => _ServerPortFieldWidgetState();
}

class _ServerPortFieldWidgetState extends State<ServerPortFieldWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<HomeCubit>().state.port?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validate(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return null;
    return HomeCubit.isValidPort(int.tryParse(value))
        ? null
        : l10n.err_invalidPort;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<HomeCubit, HomeState>(
      // Sync the field when the saved port is loaded asynchronously.
      listenWhen: (previous, current) =>
          previous.port != current.port &&
          current.port != null &&
          int.tryParse(_controller.text) != current.port,
      listener: (context, state) => _controller.text = state.port.toString(),
      builder: (context, state) {
        return TextFormField(
          controller: _controller,
          enabled: !state.isServerRunning,
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.always,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
          validator: (value) => _validate(value, l10n),
          onChanged: (value) =>
              context.read<HomeCubit>().onPortChanged(int.tryParse(value)),
          decoration: InputDecoration(
            labelText: l10n.lbl_serverPort,
            hintText: HomeCubit.defaultPort.toString(),
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        );
      },
    );
  }
}
