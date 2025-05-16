import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../injection.dart';
import 'router.dart';

class UiModule extends StatelessWidget {
  final AppRouter _router = getIt<AppRouter>();
  UiModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "SaaSter kit",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: _router.goRouter,
    );
  }
}
