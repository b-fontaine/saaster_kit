import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:design_system/design_system.dart';

import '../domain/usecases/get_is_connected.dart';
import 'widgets/login_page.dart';
import 'widgets/dashboard.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaaSter Connect',
      theme: AppTheme.lightTheme,
      home: FutureBuilder<bool>(
        future: GetIt.instance<GetIsConnected>()(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingScreen();
          }
          
          if (snapshot.hasError) {
            return const LoginPage();
          }
          
          final isConnected = snapshot.data ?? false;
          
          if (!isConnected) {
            return const LoginPage();
          } else {
            return const Dashboard();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppLoadingScreen extends StatelessWidget {
  const AppLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: DSColors.primaryApp,
                borderRadius: DSBorders.borderRadiusCircular,
              ),
              child: Icon(
                Icons.business,
                size: 40,
                color: DSColors.textOnPrimary,
              ),
            ),
            DSSpacing.verticalSpacerLG,
            const CircularProgressIndicator(),
            DSSpacing.verticalSpacerMD,
            Text(
              'Loading SaaSter Connect...',
              style: DSTypography.appTextTheme.bodyLarge?.copyWith(
                color: DSColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
