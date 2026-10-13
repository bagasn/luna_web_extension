import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_extension/pages/home/cubit/home_cubit.dart';

class ActionSidebarWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                    state.isServerRunning
                        ? Icons.play_circle
                        : Icons.stop_circle,
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
                  child: Text(
                    state.isServerRunning ? 'Stop Server' : 'Start Server',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
