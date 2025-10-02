import 'package:flutter/material.dart';
import 'package:prompt_result/core/internal/di/si.dart' as si;
import 'package:prompt_result/feature/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const App());
}

Future<void> configureDependencies() async {
  si.configureDependencies();
}
