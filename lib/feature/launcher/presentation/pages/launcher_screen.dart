import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prompt_result/feature/app/routing/path_route.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(decoration: InputDecoration(hint: Text('Describe what you want to see...'))),
          ElevatedButton(
            onPressed: () => context.goNamed(AppRoute.imageGenerator),
            child: Text('Generate'),
          ),
        ],
      ),
    );
  }
}
