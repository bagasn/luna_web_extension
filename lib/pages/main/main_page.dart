import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_extension/core/dep_injections/injection_container.dart';
import 'package:web_extension/generated/assets.gen.dart';
import 'package:web_extension/generated/colors.gen.dart';
import 'package:web_extension/pages/main/home/cubit/home_cubit.dart';
import 'package:web_extension/pages/main/home/home_view.dart';
import 'package:web_extension/pages/main/setting/bloc/setting_bloc.dart';
import 'package:web_extension/pages/main/setting/setting_nav_view.dart';

class MainPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<HomeCubit>()),
        BlocProvider(
          create: (context) =>
              locator<SettingBloc>()..add(const LoadSettingEvent()),
        ),
      ],
      child: _MainView(),
    );
  }
}

class _MainView extends StatefulWidget {
  const new();

  @override
  State<_MainView> createState() => _MainViewState();
}

class _MainViewState extends State<_MainView> {
  final _navItems = [
    _NavItem(icon: Icon(Icons.computer), label: 'Main'),
    _NavItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];
  final _navViewWidgets = [HomeView(), SettingNavView()];

  int _selectedViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 82,
            decoration: BoxDecoration(color: AppColors.mainColor),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white)),
                  ),
                  child: Assets.icons.icLunaposLogo.svg(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < _navItems.length; i++)
                          _NavItemWidget(
                            icon: _navItems[i].icon,
                            label: _navItems[i].label,
                            isSelected: i == _selectedViewIndex,
                            onTap: () {
                              setState(() {
                                _selectedViewIndex = i;
                              });
                            },
                          ),
                      ],
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

class _NavItemWidget extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const new({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final widgetSize = 82.0;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: widgetSize,
        height: widgetSize,
        padding: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black.withAlpha(60) : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 4,
          children: [
            IconTheme(
              data: IconThemeData(size: 36, color: Colors.white),
              child: icon,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextTheme.of(context).labelLarge
                  ?.copyWith(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final Widget icon;
  final String label;

  _NavItem({required this.icon, required this.label});
}
