import 'package:flutter/material.dart';
import 'package:web_extension/pages/main/home/widgets/action_sidebar_widget.dart';
import 'package:web_extension/pages/main/home/widgets/console_log_widget.dart';

class HomeView extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 1, child: ActionSidebarWidget()),
        Expanded(flex: 2, child: ConsoleLogWidget()),
      ],
    );
  }
}
