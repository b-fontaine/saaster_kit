import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DSLandingScaffold.heroSection(
      context: context,
      title: 'Build SaaS Applications Faster with SaaSter Kit',
      subtitle:
          'A complete, production-ready SaaS starter kit with microservices architecture, authentication, billing, and more. Start building your next big idea today.',
      primaryAction: DSButtons.primaryLandingButton(
        text: 'Get Started',
        onPressed: () {
          // Implement call-to-action
          launchUrlString("/app", webOnlyWindowName: "_self");
        },
      ),
      secondaryAction: DSButtons.secondaryLandingButton(
        text: 'Learn More',
        onPressed: () {
          // Implement secondary action
          launchUrlString(
            "https://github.com/b-fontaine/saaster_kit",
            webOnlyWindowName: "_self",
          );
        },
      ),
      image: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
      backgroundColor: Colors.transparent,
      titleTextAlign: TextAlign.start,
      subtitleTextAlign: TextAlign.start,
    );
  }
}
