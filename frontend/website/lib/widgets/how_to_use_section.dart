import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// How to use section that exactly matches the websitejs HowToUse component
class HowToUseSection extends StatelessWidget {
  const HowToUseSection({super.key});

  @override
  Widget build(BuildContext context) {
    // section id="how-to-use" className="py-16 bg-gray-50"
    return Container(
      color: DSColors.gray50, // bg-gray-50
      child: DSResponsiveLayout.responsiveContainer(
        maxWidth: 1280, // max-w-7xl
        padding: ResponsiveUtils.responsivePadding(
          context,
          defaultPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64), // px-4 py-16
          sm: const EdgeInsets.symmetric(horizontal: 24, vertical: 64), // sm:px-6 py-16
          lg: const EdgeInsets.symmetric(horizontal: 32, vertical: 64), // lg:px-8 py-16
        ),
        child: const Column(
          children: [
            _HowToUseHeader(),
            SizedBox(height: 48), // mb-12 equivalent
            _TerminalMockup(),
            SizedBox(height: 48), // mt-12 equivalent
            _DocumentationInfo(),
          ],
        ),
      ),
    );
  }
}

// Separate widget classes for better performance and reusability
class _HowToUseHeader extends StatelessWidget {
  const _HowToUseHeader();

  @override
  Widget build(BuildContext context) {
    // div className="text-center mb-12"
    return Column(
      children: [
        // h2 className="text-3xl font-bold text-gray-900 mb-4"
        Text(
          'Getting Started is Simple',
          style: DSTypography.text3Xl(context).copyWith(
            fontWeight: FontWeight.bold, // font-bold
            color: DSColors.gray900, // text-gray-900
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16), // mb-4
        // p className="text-xl text-gray-600 max-w-3xl mx-auto"
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 768), // max-w-3xl
          child: Text(
            'Fork the project, clone your repository, and launch with a single command.',
            style: DSTypography.textXl(context).copyWith(
              color: DSColors.gray600, // text-gray-600
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _TerminalMockup extends StatelessWidget {
  const _TerminalMockup();

  @override
  Widget build(BuildContext context) {
    // div className="bg-white rounded-xl shadow-md overflow-hidden border border-gray-200 max-w-3xl mx-auto"
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 768), // max-w-3xl
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // bg-white
          borderRadius: BorderRadius.circular(12), // rounded-xl
          border: Border.all(color: DSColors.gray200), // border-gray-200
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1), // shadow-md
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Column(
          children: [
            _TerminalHeader(),
            _TerminalContent(),
          ],
        ),
      ),
    );
  }
}

class _TerminalHeader extends StatelessWidget {
  const _TerminalHeader();

  @override
  Widget build(BuildContext context) {
    // div className="bg-gray-800 px-4 py-3 flex items-center"
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // px-4 py-3
      decoration: const BoxDecoration(
        color: DSColors.gray800, // bg-gray-800
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          // Terminal size={20} className="text-gray-400 mr-2" - Using terminal icon to match lucide-react Terminal
          Icon(
            LucideIcons.terminal,
            color: DSColors.gray400, // text-gray-400
            size: 20,
          ),
          const SizedBox(width: 8), // mr-2
          // span className="text-gray-200 font-medium"
          Text(
            'Terminal',
            style: DSTypography.textSm(context).copyWith(
              color: DSColors.gray200, // text-gray-200
              fontWeight: FontWeight.w500, // font-medium
              fontFamily: 'monospace', // font-mono to match websitejs
            ),
          ),
        ],
      ),
    );
  }
}

class _TerminalContent extends StatelessWidget {
  const _TerminalContent();

  static const List<_TerminalStep> _steps = [
    _TerminalStep(
      comment: '# Step 1: Fork the SaaSter Kit repository',
      command: 'Visit https://github.com/b-fontaine/saaster_kit and click "Fork"',
      isOpaque: true,
    ),
    _TerminalStep(
      comment: '# Step 2: Clone your forked repository',
      command: 'git clone https://github.com/your-username/saaster_kit.git\ncd saaster_kit',
      isOpaque: false,
    ),
    _TerminalStep(
      comment: '# Step 3: Launch the SaaSter Kit',
      command: 'docker compose -p saaster up -d',
      isOpaque: false,
    ),
    _TerminalStep(
      comment: '# That\'s it! Your SaaS infrastructure is now running',
      command: null,
      isOpaque: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // div className="p-6 bg-gray-900 text-gray-200 font-mono text-sm overflow-x-auto"
    return Container(
      padding: const EdgeInsets.all(24), // p-6
      decoration: const BoxDecoration(
        color: DSColors.gray900, // bg-gray-900
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _steps
            .asMap()
            .entries
            .map((entry) => Padding(
                  padding: EdgeInsets.only(bottom: entry.key < _steps.length - 1 ? 16 : 0), // mb-4
                  child: _TerminalStepWidget(step: entry.value),
                ))
            .toList(),
      ),
    );
  }
}

class _TerminalStepWidget extends StatelessWidget {
  final _TerminalStep step;

  const _TerminalStepWidget({required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // span className="text-green-400"
        Text(
          step.comment,
          style: DSTypography.textSm(context).copyWith(
            color: const Color(0xFF10B981), // text-green-400
            fontFamily: 'monospace', // font-mono to match websitejs
            height: 1.5,
          ),
        ),
        if (step.command != null) ...[
          // br
          const SizedBox(height: 4),
          // span with opacity-70 or normal
          Text(
            step.command!,
            style: DSTypography.textSm(context).copyWith(
              color: step.isOpaque 
                  ? DSColors.gray200.withValues(alpha: 0.7) // opacity-70 to match websitejs
                  : DSColors.gray200, // text-gray-200
              fontFamily: 'monospace', // font-mono to match websitejs
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

class _DocumentationInfo extends StatelessWidget {
  const _DocumentationInfo();

  @override
  Widget build(BuildContext context) {
    // div className="mt-12 text-center"
    return Column(
      children: [
        // p className="text-lg text-gray-700 mb-6"
        Text(
          'Comprehensive documentation is available in the repository README files.',
          style: DSTypography.textLg(context).copyWith(
            color: DSColors.gray700, // text-gray-700
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24), // mb-6
        // p className="text-lg text-gray-700"
        Text(
          'SaaSter Kit is completely free to use and includes example prompts for AI tools like Augment Code, Cursor, or Devin.',
          style: DSTypography.textLg(context).copyWith(
            color: DSColors.gray700, // text-gray-700
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _TerminalStep {
  final String comment;
  final String? command;
  final bool isOpaque;

  const _TerminalStep({
    required this.comment,
    required this.command,
    required this.isOpaque,
  });
}
