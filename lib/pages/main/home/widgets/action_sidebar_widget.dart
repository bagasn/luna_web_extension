import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_extension/pages/main/home/cubit/home_cubit.dart';

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
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 24,
            children: [
              _buildSocketTriggerView(state, context),
              _buildTextPrintView(context),
            ],
          ),
        );
      },
    );
  }

  final _ipTextPrint = TextEditingController(text: '192.168.0.111');

  Widget _buildTextPrintView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Test Print',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Divider(),
        TextField(
          controller: _ipTextPrint,
          decoration: InputDecoration(
            label: Text('IP Address'),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 6),
        FilledButton(
          onPressed: () {
            context.read<HomeCubit>().onTestPrint(_ipTextPrint.text);
          },
          child: Text('Test Print'),
        ),
      ],
    );
  }

  Widget _buildSocketTriggerView(HomeState state, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Socket Status',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Divider(),
        Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 12,
          children: [
            Icon(
              state.isServerRunning ? Icons.play_circle : Icons.stop_circle,
              color: state.isServerRunning ? Colors.green : Colors.red,
            ),
            Text(state.isServerRunning ? 'Running' : 'Stop'),
          ],
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 16),
          child: FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: Size(150, 52),
              backgroundColor: state.isServerRunning
                  ? Colors.red.shade100
                  : Colors.green.shade100,
              foregroundColor: state.isServerRunning
                  ? Colors.red.shade800
                  : Colors.green.shade800,
            ),
            onPressed: () {
              final bloc = context.read<HomeCubit>();
              if (state.isServerRunning) {
                bloc.onStopServer();
              } else {
                bloc.onStartServer();
              }
            },
            child: Text(state.isServerRunning ? 'Stop Server' : 'Start Server'),
          ),
        ),
      ],
    );
  }
}
