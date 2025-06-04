import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:design_system/design_system.dart';
import '../../domain/usecases/login_user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: DSSpacing.paddingLG,
            child: DSCards.appElevatedCard(
              elevation: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  Text(
                    'SaaSter Connect',
                    style: DSTypography.appTextTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: DSColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  DSSpacing.verticalSpacerXL,
                  DSButtons.primaryAppButton(
                    text: 'Login or register',
                    onPressed: () {
                      GetIt.instance<LoginUser>()();
                    },
                    isFullWidth: true,
                    context: context,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
