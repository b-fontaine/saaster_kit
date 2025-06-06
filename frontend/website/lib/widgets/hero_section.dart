import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Custom hero section that exactly matches the websitejs Hero component
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 768; // md breakpoint

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft, // from-indigo-600
          end: Alignment.centerRight, // to-purple-600
          colors: [
            Color(0xFF4F46E5), // indigo-600
            Color(0xFF7C3AED), // purple-600
          ],
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1280), // max-w-7xl
        margin: const EdgeInsets.symmetric(horizontal: 16), // px-4 sm:px-6 lg:px-8
        padding: EdgeInsets.symmetric(
          vertical: isDesktop ? 96 : 64, // py-16 md:py-24
        ),
        child: isDesktop
            ? Row( // grid md:grid-cols-2
                crossAxisAlignment: CrossAxisAlignment.center, // items-center
                children: [
                  Expanded(child: _buildLeftContent(context)),
                  const SizedBox(width: 32), // gap-8
                  Expanded(child: _buildRightContent()),
                ],
              )
            : Column(
                children: [
                  _buildLeftContent(context),
                  const SizedBox(height: 32),
                  // Hide code preview on mobile (hidden md:block)
                ],
              ),
      ),
    );
  }

  Widget _buildLeftContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // h1 className="text-4xl md:text-5xl font-bold mb-4"
        Text(
          'Launch Your SaaS Faster with SaaSter Kit',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width >= 768 ? 48 : 36, // text-4xl md:text-5xl
            fontWeight: FontWeight.bold, // font-bold
            color: Colors.white, // text-white
            height: 1.1, // Tighter line height for headings
          ),
        ),
        const SizedBox(height: 16), // mb-4

        // p className="text-xl mb-8 text-indigo-100"
        Text(
          'A complete, production-ready starter kit for building modern SaaS applications. Focus on your business logic, we\'ve handled the infrastructure.',
          style: const TextStyle(
            fontSize: 20, // text-xl
            color: Color(0xFFE0E7FF), // text-indigo-100
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32), // mb-8

        // div className="flex flex-wrap gap-4"
        Wrap(
          spacing: 16, // gap-4
          runSpacing: 16,
          children: [
            _buildPrimaryButton(),
            _buildSecondaryButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    // a href="..." className="flex items-center bg-white text-indigo-600 px-6 py-3 rounded-lg font-medium shadow-lg hover:bg-gray-100 transition-colors"
    return ElevatedButton.icon(
      onPressed: () {
        launchUrlString(
          "https://github.com/b-fontaine/saaster_kit",
          webOnlyWindowName: "_blank",
        );
      },
      icon: const Icon(Icons.code, size: 20), // Github size={20}
      label: const Text('Fork on GitHub'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // bg-white
        foregroundColor: const Color(0xFF4F46E5), // text-indigo-600
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // px-6 py-3
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // rounded-lg
        ),
        elevation: 8, // shadow-lg
        shadowColor: Colors.black.withValues(alpha: 0.25),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500, // font-medium
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    // a href="#features" className="bg-transparent border-2 border-white text-white px-6 py-3 rounded-lg font-medium hover:bg-white hover:text-indigo-600 transition-colors"
    return OutlinedButton(
      onPressed: () {
        // TODO: Implement scroll to features section
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent, // bg-transparent
        foregroundColor: Colors.white, // text-white
        side: const BorderSide(color: Colors.white, width: 2), // border-2 border-white
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // px-6 py-3
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // rounded-lg
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500, // font-medium
        ),
      ),
      child: const Text('Explore Features'),
    );
  }

  Widget _buildRightContent() {
    // div className="hidden md:block"
    // div className="bg-white/10 backdrop-blur-sm rounded-xl p-6 shadow-xl border border-white/20"
    return Container(
      padding: const EdgeInsets.all(24), // p-6
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1), // bg-white/10
        borderRadius: BorderRadius.circular(12), // rounded-xl
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2), // border-white/20
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25), // shadow-xl
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // pre className="text-indigo-100 overflow-x-auto"
          Text(
            '# Get started in seconds\n\$ git clone your-fork-url\n\$ docker compose -p saaster up -d\n# Ready to customize and deploy!',
            style: const TextStyle(
              color: Color(0xFFE0E7FF), // text-indigo-100
              fontFamily: 'monospace',
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
