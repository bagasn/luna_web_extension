import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:web_extension/core/dep_injections/injection_container.config.dart';

final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  final logger = Logger(
    filter: DevelopmentFilter(),
    printer: PrettyPrinter(
      printEmojis: false,
      colors: kIsWeb ? true : Platform.isAndroid,
      levelColors: _logLevelColorsDefault,
    ),
  );

  locator.registerSingleton(logger);
  locator.init();
}

final _logLevelColorsDefault = {
  Level.trace: const AnsiColor.fg(7),
  Level.debug: const AnsiColor.fg(10),
  Level.info: const AnsiColor.fg(12),
  Level.warning: const AnsiColor.fg(11),
  Level.error: const AnsiColor.fg(9),
  Level.fatal: const AnsiColor.fg(13),
};
