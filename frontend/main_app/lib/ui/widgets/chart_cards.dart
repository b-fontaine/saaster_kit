import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:design_system/design_system.dart';

class RadarChartCard extends StatelessWidget {
  const RadarChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DSCards.appElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Radar',
            style: DSTypography.appTextTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          DSSpacing.verticalSpacerMD,
          SizedBox(
            height: 300,
            child: RadarChart(
              RadarChartData(
                dataSets: [
                  RadarDataSet(
                    fillColor: DSColors.primaryApp.withValues(alpha: 0.2),
                    borderColor: DSColors.primaryApp,
                    entryRadius: 3,
                    dataEntries: [
                      const RadarEntry(value: 80),
                      const RadarEntry(value: 90),
                      const RadarEntry(value: 70),
                      const RadarEntry(value: 85),
                      const RadarEntry(value: 75),
                      const RadarEntry(value: 95),
                    ],
                  ),
                ],
                radarShape: RadarShape.polygon,
                tickCount: 5,
                titleTextStyle: DSTypography.appTextTheme.bodySmall!,
                getTitle: (index, angle) {
                  const titles = [
                    'Performance',
                    'Security',
                    'Scalability',
                    'Reliability',
                    'Usability',
                    'Efficiency'
                  ];
                  return RadarChartTitle(
                    text: titles[index],
                    angle: angle,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CandlestickChartCard extends StatelessWidget {
  const CandlestickChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DSCards.appElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Revenue Trends',
            style: DSTypography.appTextTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          DSSpacing.verticalSpacerMD,
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '\$${value.toInt()}k',
                          style: DSTypography.appTextTheme.bodySmall,
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                        if (value.toInt() < months.length) {
                          return Text(
                            months[value.toInt()],
                            style: DSTypography.appTextTheme.bodySmall,
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 30),
                      FlSpot(1, 45),
                      FlSpot(2, 35),
                      FlSpot(3, 60),
                      FlSpot(4, 55),
                      FlSpot(5, 80),
                    ],
                    isCurved: true,
                    color: DSColors.primaryApp,
                    barWidth: 3,
                    belowBarData: BarAreaData(
                      show: true,
                      color: DSColors.primaryApp.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PieChartCard extends StatelessWidget {
  const PieChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DSCards.appElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Distribution',
            style: DSTypography.appTextTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          DSSpacing.verticalSpacerMD,
          SizedBox(
            height: 300,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 40,
                    title: '40%',
                    color: DSColors.primaryApp,
                    radius: 100,
                    titleStyle: DSTypography.appTextTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    value: 30,
                    title: '30%',
                    color: DSColors.successApp,
                    radius: 100,
                    titleStyle: DSTypography.appTextTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    value: 20,
                    title: '20%',
                    color: DSColors.warningApp,
                    radius: 100,
                    titleStyle: DSTypography.appTextTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    value: 10,
                    title: '10%',
                    color: DSColors.errorApp,
                    radius: 100,
                    titleStyle: DSTypography.appTextTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
          DSSpacing.verticalSpacerMD,
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      children: [
        _buildLegendItem('Premium Users', DSColors.primaryApp),
        _buildLegendItem('Standard Users', DSColors.successApp),
        _buildLegendItem('Basic Users', DSColors.warningApp),
        _buildLegendItem('Trial Users', DSColors.errorApp),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          DSSpacing.horizontalSpacerSM,
          Text(
            label,
            style: DSTypography.appTextTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
