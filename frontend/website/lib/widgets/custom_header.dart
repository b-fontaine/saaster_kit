import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Custom header widget that exactly matches the websitejs Header component
class CustomHeader extends StatefulWidget {
  const CustomHeader({super.key});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 768; // md breakpoint

    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // bg-white
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05), // shadow-sm
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center( // Center the content
        child: Column(
          children: [
            // Main header content
            Container(
              constraints: const BoxConstraints(maxWidth: 1280), // max-w-7xl
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth >= 1024 ? 32 : (screenWidth >= 640 ? 24 : 16), // px-4 sm:px-6 lg:px-8
                vertical: 16, // py-4
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // justify-between
                children: [
                  // Logo section
                  Row(
                    children: [
                      Text(
                        'SaaSter Kit',
                        style: const TextStyle(
                          fontSize: 24, // text-2xl
                          fontWeight: FontWeight.bold, // font-bold
                          color: Color(0xFF4F46E5), // text-indigo-600
                        ),
                      ),
                    ],
                  ),

                  // Desktop navigation
                  if (isDesktop) ...[
                    Row(
                      children: [
                        _buildNavLink('Features', () {
                          // TODO: Implement scroll to features section
                        }),
                        const SizedBox(width: 32), // space-x-8
                        _buildNavLink('How to Use', () {
                          // TODO: Implement scroll to how-to-use section
                        }),
                        const SizedBox(width: 32), // space-x-8
                        _buildGitHubLink(),
                      ],
                    ),
                  ] else ...[
                    // Mobile hamburger menu
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isMenuOpen = !isMenuOpen;
                        });
                      },
                      icon: Icon(
                        isMenuOpen ? Icons.close : Icons.menu,
                        size: 24,
                        color: const Color(0xFF374151), // text-gray-700
                      ),
                      splashColor: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                      highlightColor: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                    ),
                  ],
                ],
              ),
            ),

            // Mobile menu dropdown
            if (!isDesktop && isMenuOpen) ...[
              Container(
                constraints: const BoxConstraints(maxWidth: 1280), // max-w-7xl
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth >= 1024 ? 32 : (screenWidth >= 640 ? 24 : 16), // px-4 sm:px-6 lg:px-8
                  vertical: 8, // py-2 pb-4
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMobileNavLink('Features', () {
                      setState(() {
                        isMenuOpen = false;
                      });
                      // TODO: Implement scroll to features section
                    }),
                    _buildMobileNavLink('How to Use', () {
                      setState(() {
                        isMenuOpen = false;
                      });
                      // TODO: Implement scroll to how-to-use section
                    }),
                    _buildMobileGitHubLink(() {
                      setState(() {
                        isMenuOpen = false;
                      });
                    }),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF374151), // text-gray-700
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildGitHubLink() {
    return InkWell(
      onTap: () {
        launchUrlString(
          "https://github.com/b-fontaine/saaster_kit",
          webOnlyWindowName: "_blank",
        );
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.code, // Using code icon as GitHub substitute
              size: 18,
              color: const Color(0xFF374151), // text-gray-700
            ),
            const SizedBox(width: 4), // mr-1
            Text(
              'GitHub',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF374151), // text-gray-700
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8), // py-2
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF374151), // text-gray-700
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileGitHubLink(VoidCallback onClose) {
    return InkWell(
      onTap: () {
        onClose();
        launchUrlString(
          "https://github.com/b-fontaine/saaster_kit",
          webOnlyWindowName: "_blank",
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8), // py-2
        child: Row(
          children: [
            Icon(
              Icons.code, // Using code icon as GitHub substitute
              size: 18,
              color: const Color(0xFF374151), // text-gray-700
            ),
            const SizedBox(width: 4), // mr-1
            Text(
              'GitHub',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF374151), // text-gray-700
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
