import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_extension/core/dep_injections/injection_container.dart';
import 'package:web_extension/generated/assets.gen.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/pages/home/cubit/home_cubit.dart';
import 'package:web_extension/pages/home/widgets/action_sidebar_widget.dart';
import 'package:web_extension/pages/home/widgets/console_log_widget.dart';

class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<HomeCubit>(),
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const new();

  @override
  State<_HomeView> createState() => __HomeViewState();
}

class __HomeViewState extends State<_HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        title: Row(
          spacing: 16,
          children: [Assets.icons.icLunaposLogo.svg(), Text('Web Extension')],
        ),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 1, child: ActionSidebarWidget()),
          Expanded(flex: 2, child: ConsoleLogWidget()),
        ],
      ),
    );
  }
}
