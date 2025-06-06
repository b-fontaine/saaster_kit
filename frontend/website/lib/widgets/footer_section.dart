import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Footer section that exactly matches the websitejs Footer component
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    // footer className="bg-gray-900 text-white py-12"
    return Container(
      color: DSColors.gray900, // bg-gray-900
      child: DSResponsiveLayout.responsiveContainer(
        maxWidth: 1280, // max-w-7xl
        padding: ResponsiveUtils.responsivePadding(
          context,
          defaultPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48), // px-4 py-12
          sm: const EdgeInsets.symmetric(horizontal: 24, vertical: 48), // sm:px-6 py-12
          lg: const EdgeInsets.symmetric(horizontal: 32, vertical: 48), // lg:px-8 py-12
        ),
        child: const _FooterContent(),
      ),
    );
  }
}

// Separate widget classes for better performance and reusability
class _FooterContent extends StatelessWidget {
  const _FooterContent();

  @override
  Widget build(BuildContext context) {
    // div className="flex flex-col md:flex-row justify-between items-center"
    return ResponsiveUtils.responsiveValue<Widget>(
      context: context,
      defaultValue: const Column(
        children: [
          _CompanyInfo(),
          SizedBox(height: 24), // mb-6 md:mb-0 equivalent
          _GitHubSection(),
        ],
      ),
      md: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // justify-between
        crossAxisAlignment: CrossAxisAlignment.center, // items-center
        children: [
          _CompanyInfo(),
          _GitHubSection(),
        ],
      ),
    );
  }
}

class _CompanyInfo extends StatelessWidget {
  const _CompanyInfo();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    // div className="mb-6 md:mb-0"
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // div className="text-2xl font-bold text-white mb-2"
        Text(
          'SaaSter Kit',
          style: DSTypography.text2Xl(context).copyWith(
            fontWeight: FontWeight.bold, // font-bold
            color: Colors.white, // text-white
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 8), // mb-2
        // p className="text-gray-400"
        Text(
          'A free, open-source starter kit for SaaS applications',
          style: DSTypography.textBase(context).copyWith(
            color: DSColors.gray400, // text-gray-400
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
      ],
    );
  }
}

class _GitHubSection extends StatefulWidget {
  const _GitHubSection();

  @override
  State<_GitHubSection> createState() => _GitHubSectionState();
}

class _GitHubSectionState extends State<_GitHubSection> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    // div className="flex flex-col items-center md:items-end"
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      children: [
        // a href="..." className="flex items-center text-white hover:text-indigo-300 transition-colors mb-2"
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: () {
              launchUrlString(
                "https://github.com/b-fontaine/saaster_kit",
                webOnlyWindowName: "_blank",
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200), // transition-colors
              child: Row(
                mainAxisSize: MainAxisSize.min, // flex items-center
                children: [
                  // Github size={20} className="mr-2"
                  Icon(
                    Icons.code, // Using code icon as Github equivalent
                    color: _isHovered 
                        ? const Color(0xFFA5B4FC) // hover:text-indigo-300
                        : Colors.white, // text-white
                    size: 20,
                  ),
                  const SizedBox(width: 8), // mr-2
                  // span
                  Text(
                    'GitHub Repository',
                    style: DSTypography.textBase(context).copyWith(
                      color: _isHovered 
                          ? const Color(0xFFA5B4FC) // hover:text-indigo-300
                          : Colors.white, // text-white
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8), // mb-2
        // p className="text-gray-400 text-sm"
        Text(
          'This project is not for sale and is completely free to use.',
          style: DSTypography.textSm(context).copyWith(
            color: DSColors.gray400, // text-gray-400
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.end,
        ),
      ],
    );
  }
}

