import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:prompt_result/feature/app/bloc_providers.dart';
import 'package:prompt_result/feature/app/routing/app_routing.dart';
import 'package:prompt_result/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const App());
}

// Функция для настройки зависимостей
Future<void> configureDependencies() async {
  configureDependencies();
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GetIt locator;

  @override
  void initState() {
    locator = GetIt.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...buildListProviders(locator: locator)],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: goRouter,
        localizationsDelegates: const [
          Locales.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ru'), Locale('en')],
      ),
    );
  }
}
