import 'package:flutter/material.dart';
import 'package:web_extension/core/application.dart';
import 'package:web_extension/core/dep_injections/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const LunaposApp());
}
