import 'package:flutter/material.dart';
import 'package:web_extension/core/dep_injections/injection_container.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/l10n/app_localizations.dart';
import 'package:web_extension/shared/services/web_socket_service.dart';

class ConsoleLogWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<ConsoleLogWidget> createState() => _ConsoleLogWidgetState();
}

class _ConsoleLogWidgetState extends State<ConsoleLogWidget> {
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
                child: const Icon(
                  Icons.terminal_outlined,
                  color: AppColors.mainColor,
                  size: 22,
                ),
              ),
              Expanded(
                child: Text(
                  l10n.title_consoleLog,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 1),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.charcoal950,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListenableBuilder(
                listenable: locator<WebSocketService>(),
                builder: (context, child) {
                  final socketService = locator<WebSocketService>();
                  final logs = socketService.consoleLogs;

                  if (logs.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.txt_noConsoleLogs,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.charcoal500,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      return _buildTextLog(logs[index]);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextLog(ConsoleLogModel log) {
    Color logColor;
    switch (log.type) {
      case ConsoleLogType.debug:
        logColor = Colors.green.shade400;
        break;
      case ConsoleLogType.info:
        logColor = Colors.blue.shade400;
        break;
      case ConsoleLogType.error:
        logColor = Colors.red.shade400;
        break;
    }
    const style = TextStyle(fontSize: 14);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(
              log.createAt,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style.copyWith(color: AppColors.charcoal500),
            ),
          ),
          Expanded(
            child: SelectableText(
              log.message,
              selectionColor: Colors.white24,
              style: style.copyWith(color: logColor),
            ),
          ),
        ],
      ),
    );
  }
}
