import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:web_extension/core/dep_injections/injection_container.dart';
import 'package:web_extension/core/navigation/app_routes.dart';
import 'package:web_extension/core/theme/main_theme.dart';
import 'package:web_extension/shared/services/language_service.dart';
import 'package:web_extension/l10n/app_localizations.dart';

class LunaposApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<LanguageService>(),
      child: const _LunaAppliaction(),
    );
  }
}

class _LunaAppliaction extends StatefulWidget {
  const new();

  @override
  State<_LunaAppliaction> createState() => _LunaAppliactionState();
}

class _LunaAppliactionState extends State<_LunaAppliaction> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = buildAppRouter(locator());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Luna Extension',
      themeMode: ThemeMode.light,
      theme: kAppThemeData,
      routerConfig: _router,
      locale: context.watch<LanguageService>().currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return const Locale('id');
        for (final supportLocale in supportedLocales) {
          if (supportLocale.languageCode == locale.languageCode) {
            return supportLocale;
          }
        }
        return const Locale('id');
      },
    );
  }
}
