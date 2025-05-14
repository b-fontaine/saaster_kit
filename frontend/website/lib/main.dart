import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const SaasterKitApp());
}

class SaasterKitApp extends StatelessWidget {
  const SaasterKitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saaster Kit',
      theme: LandingTheme.lightTheme,
      darkTheme: LandingTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
