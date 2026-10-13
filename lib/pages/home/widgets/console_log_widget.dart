import 'package:flutter/material.dart';
import 'package:web_extension/core/dep_injections/injection_container.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/shared/services/socket_service.dart';

class ConsoleLogWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<ConsoleLogWidget> createState() => _ConsoleLogWidgetState();
}

class _ConsoleLogWidgetState extends State<ConsoleLogWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListenableBuilder(
        listenable: locator<WebSocketService>(),
        builder: (context, child) {
          final socketService = locator<WebSocketService>();
          final logs = socketService.consoleLogs;

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              return _buildTextLog(logs[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildTextLog(ConsoleLogModel log) {
    final style = TextStyle(fontSize: 13);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      // decoration: BoxDecoration(
      //   border: Border(bottom: BorderSide(color: AppColors.charcoal400)),
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            log.createAt,
            style: style.copyWith(color: AppColors.charcoal500),
          ),
          Expanded(
            child: SelectableText(
              log.message,
              selectionColor: Colors.white,
              style: style.copyWith(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
