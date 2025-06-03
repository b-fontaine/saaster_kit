import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'dashboard_app_bar.dart';
import 'chart_cards.dart';
import 'documentation_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(),
      backgroundColor: DSColors.backgroundApp,
      body: SingleChildScrollView(
        padding: DSSpacing.paddingLG,
        child: DSResponsiveLayout.responsiveBuilder(
          context: context,
          mobile: const DashboardMobileLayout(),
          tablet: const DashboardTabletLayout(),
          desktop: const DashboardDesktopLayout(),
        ),
      ),
    );
  }
}

class DashboardMobileLayout extends StatelessWidget {
  const DashboardMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const RadarChartCard(),
        DSSpacing.verticalSpacerLG,
        const CandlestickChartCard(),
        DSSpacing.verticalSpacerLG,
        const PieChartCard(),
        DSSpacing.verticalSpacerLG,
        const DocumentationCard(),
      ],
    );
  }
}

class DashboardTabletLayout extends StatelessWidget {
  const DashboardTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(child: RadarChartCard()),
            DSSpacing.horizontalSpacerLG,
            const Expanded(child: CandlestickChartCard()),
          ],
        ),
        DSSpacing.verticalSpacerLG,
        const PieChartCard(),
        DSSpacing.verticalSpacerLG,
        const DocumentationCard(),
      ],
    );
  }
}

class DashboardDesktopLayout extends StatelessWidget {
  const DashboardDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(child: RadarChartCard()),
            DSSpacing.horizontalSpacerLG,
            const Expanded(child: CandlestickChartCard()),
            DSSpacing.horizontalSpacerLG,
            const Expanded(child: PieChartCard()),
          ],
        ),
        DSSpacing.verticalSpacerXL,
        const DocumentationCard(),
      ],
    );
  }
}
