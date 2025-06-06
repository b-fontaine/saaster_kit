import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: DSSpacing.getPagePadding(context),
      color: const Color(0xFF111827), // Gray-900
      child: Column(
        children: [
          const SizedBox(height: 48),
          DSResponsiveLayout.responsiveRowColumn(
            context: context,
            breakpoint: 768,
            spacing: 24,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            columnMainAxisAlignment: MainAxisAlignment.center,
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side - Company info
              Column(
                crossAxisAlignment: DSBreakpoints.isMobile(context)
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    'SaaSter Kit',
                    style: const TextStyle(
                      fontSize: 24, // text-2xl
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A free, open-source starter kit for SaaS applications',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9CA3AF), // gray-400
                    ),
                    textAlign: DSBreakpoints.isMobile(context)
                        ? TextAlign.center
                        : TextAlign.start,
                  ),
                ],
              ),
              // Right side - GitHub link and disclaimer
              Column(
                crossAxisAlignment: DSBreakpoints.isMobile(context)
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      launchUrlString(
                        "https://github.com/b-fontaine/saaster_kit",
                        webOnlyWindowName: "_blank",
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.code,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'GitHub Repository',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This project is not for sale and is completely free to use.',
                    style: const TextStyle(
                      fontSize: 14, // text-sm
                      color: Color(0xFF9CA3AF), // gray-400
                    ),
                    textAlign: DSBreakpoints.isMobile(context)
                        ? TextAlign.center
                        : TextAlign.end,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

