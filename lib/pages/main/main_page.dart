import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_extension/core/dep_injections/injection_container.dart';
import 'package:web_extension/generated/assets.gen.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/pages/main/home/cubit/home_cubit.dart';
import 'package:web_extension/pages/main/home/home_view.dart';

class MainPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => locator<HomeCubit>())],
      child: HomeView(),
    );
  }
}

class MainView extends StatefulWidget {
  const new({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _navViewWidgets = [HomeView()];

  int _selectedViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 100,
            decoration: BoxDecoration(color: AppColors.mainColor),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Assets.icons.icLunaposLogo.svg(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.home, color: Colors.white)],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _navViewWidgets[_selectedViewIndex]),
        ],
      ),
    );
  }
}
