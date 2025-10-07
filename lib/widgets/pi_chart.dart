import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Sample data for the Pie Chart
class ChartData {
  final String category;
  final double amount;
  final Color color;

  ChartData(this.category, this.amount, this.color);
}

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  static final List<ChartData> _chartData = [
    ChartData('Food', 300, Colors.green),
    ChartData('Transport', 150, Colors.purple),
    ChartData('Entertainment', 200, Colors.red),
    ChartData('Utilities', 100, Colors.orange),
    ChartData('Medicine', 250, Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Text(
            'Expense Breakdown',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SfCircularChart(
              backgroundColor: Colors.transparent,
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                textStyle: const TextStyle(color: Colors.white),
              ),
              series: <PieSeries<ChartData, String>>[
                PieSeries<ChartData, String>(
                  dataSource: _chartData,
                  xValueMapper: (ChartData data, _) => data.category,
                  yValueMapper: (ChartData data, _) => data.amount,
                  pointColorMapper: (ChartData data, _) => data.color,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  enableTooltip: true,
                  explode: true,
                  explodeIndex: 0,
                ),
              ],
              tooltipBehavior: TooltipBehavior(
                enable: true,
                textStyle: const TextStyle(color: Colors.white),
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
