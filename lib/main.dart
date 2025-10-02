import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:prompt_result/app/routing/app_routing.dart';
import 'package:prompt_result/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const App());
}

// Функция для настройки зависимостей
Future<void> configureDependencies() async {
  final getIt = GetIt.instance;

  // Регистрация сервисов
  // getIt.registerSingleton<YourService>(YourService());

  // Инициализация других необходимых сервисов
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
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
