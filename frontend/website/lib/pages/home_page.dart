import 'package:flutter/material.dart';

import '../widgets/custom_header.dart';
import '../widgets/features_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/how_to_use_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // bg-gray-50 to match websitejs App component
      body: Column(
        children: [
          // Sticky header - matches "sticky top-0 z-10" from websitejs
          const CustomHeader(),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  HeroSection(),
                  FeaturesSection(),
                  HowToUseSection(),
                  FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
