import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class HowToUseSection extends StatelessWidget {
  const HowToUseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: DSSpacing.getPagePadding(context),
      color: const Color(0xFFF9FAFB), // Gray-50 to match websitejs
      child: Column(
        children: [
          const SizedBox(height: 60),
          Text(
            'Getting Started is Simple',
            style: const TextStyle(
              fontSize: 36, // text-3xl
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827), // gray-900
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Fork the project, clone your repository, and launch with a single command.',
            style: const TextStyle(
              fontSize: 20, // text-xl
              color: Color(0xFF6B7280), // gray-600
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Container(
            constraints: const BoxConstraints(maxWidth: 768), // Match websitejs max-w-3xl
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: const Color(0xFFE5E7EB)), // gray-200
            ),
            child: Column(
              children: [
                // Terminal header - match websitejs bg-gray-800
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1F2937), // gray-800
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.terminal,
                        color: const Color(0xFF9CA3AF), // gray-400
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Terminal',
                        style: TextStyle(
                          color: const Color(0xFFE5E7EB), // gray-200
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                // Terminal content - match websitejs bg-gray-900
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF111827), // gray-900
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTerminalStep(
                        '# Step 1: Fork the SaaSter Kit repository',
                        'Visit https://github.com/b-fontaine/saaster_kit and click "Fork"',
                      ),
                      const SizedBox(height: 16),
                      _buildTerminalStep(
                        '# Step 2: Clone your forked repository',
                        'git clone https://github.com/your-username/saaster_kit.git\ncd saaster_kit',
                      ),
                      const SizedBox(height: 16),
                      _buildTerminalStep(
                        '# Step 3: Launch the SaaSter Kit',
                        'docker compose -p saaster up -d',
                      ),
                      const SizedBox(height: 16),
                      _buildTerminalStep(
                        '# That\'s it! Your SaaS infrastructure is now running',
                        null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Text(
            'Comprehensive documentation is available in the repository README files.',
            style: const TextStyle(
              fontSize: 18, // text-lg
              color: Color(0xFF374151), // gray-700
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'SaaSter Kit is completely free to use and includes example prompts for AI tools like Augment Code, Cursor, or Devin.',
            style: const TextStyle(
              fontSize: 18, // text-lg
              color: Color(0xFF374151), // gray-700
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildTerminalStep(String comment, String? command) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment,
          style: const TextStyle(
            color: Color(0xFF10B981), // green-400 to match websitejs
            fontFamily: 'monospace',
            fontSize: 14,
            height: 1.5,
          ),
        ),
        if (command != null) ...[
          const SizedBox(height: 4),
          Text(
            command,
            style: const TextStyle(
              color: Color(0xFFE5E7EB), // gray-200
              fontFamily: 'monospace',
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}
