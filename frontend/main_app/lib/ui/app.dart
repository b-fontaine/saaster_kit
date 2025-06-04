import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:saaster/domain/usecases/login_user.dart' show LoginUser;

import '../domain/usecases/get_is_connected.dart';
import '../injection.dart' show getIt;
import 'widgets/dashboard.dart';
import 'widgets/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  Stream<bool> getStream() {
    final isConnected = getIt<GetIsConnected>();
    isConnected();
    return isConnected.stream;
  }

  void login() {
    final loginInteractor = getIt<LoginUser>();
    loginInteractor();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaaSter Connect',
      theme: AppTheme.lightTheme,
      home: StreamBuilder(
        stream: getStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return const Dashboard();
            }
            return const LoginPage();
          }
          return const AppLoadingScreen();
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
