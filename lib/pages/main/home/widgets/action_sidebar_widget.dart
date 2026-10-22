import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/l10n/app_localizations.dart';
import 'package:web_extension/pages/main/home/cubit/home_cubit.dart';
import 'package:web_extension/pages/main/home/widgets/server_port_field_widget.dart';

class ActionSidebarWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<ActionSidebarWidget> createState() => _ActionSidebarWidgetState();
}

class _ActionSidebarWidgetState extends State<ActionSidebarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: _buildSocketTriggerCard(state, context),
        );
      },
    );
  }

  Widget _buildSocketTriggerCard(HomeState state, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final isRunning = state.isServerRunning;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.charcoal200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                child: const Icon(
                  Icons.dns_outlined,
                  color: AppColors.mainColor,
                  size: 22,
                ),
              ),
              Expanded(
                child: Text(
                  l10n.title_serverStatus,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isRunning ? AppColors.purple25 : AppColors.charcoal50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isRunning ? AppColors.purple300 : AppColors.charcoal200,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.lbl_serverStatus,
                    style: textTheme.labelLarge?.copyWith(
                      color: AppColors.charcoal700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isRunning ? AppColors.green100 : AppColors.red100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6,
                    children: [
                      Icon(
                        isRunning ? Icons.play_circle : Icons.stop_circle,
                        size: 16,
                        color: isRunning
                            ? AppColors.green800
                            : AppColors.red700,
                      ),
                      Text(
                        isRunning ? l10n.lbl_running : l10n.lbl_stopped,
                        style: textTheme.labelSmall?.copyWith(
                          color: isRunning
                              ? AppColors.green800
                              : AppColors.red700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const ServerPortFieldWidget(),
          SizedBox(
            height: 48,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: isRunning
                    ? AppColors.red100
                    : AppColors.green100,
                foregroundColor: isRunning
                    ? AppColors.red700
                    : AppColors.green800,
              ),
              onPressed: !isRunning && !HomeCubit.isValidInput(state.port)
                  ? null
                  : () {
                      final bloc = context.read<HomeCubit>();
                      if (isRunning) {
                        bloc.onStopServer();
                      } else {
                        bloc.onStartServer();
                      }
                    },
              icon: Icon(
                isRunning
                    ? Icons.stop_circle_outlined
                    : Icons.play_circle_outline,
                size: 20,
              ),
              label: Text(
                isRunning ? l10n.btn_stopServer : l10n.btn_startServer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
