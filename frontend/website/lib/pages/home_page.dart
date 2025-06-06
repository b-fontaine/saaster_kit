import 'package:flutter/material.dart';

import '../widgets/custom_header.dart';
import '../widgets/features_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/how_to_use_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // bg-gray-50 to match websitejs App component
      body: Column(
        children: [
          // Sticky header - matches "sticky top-0 z-10" from websitejs
          CustomHeader(scrollController: _scrollController),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: const Column(
                children: [
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
