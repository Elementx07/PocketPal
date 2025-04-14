import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartWidget extends StatelessWidget {
  final List<ChartData> data;

  const PieChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(99, 64, 64, 70),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Category Distribution',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            _buildLegend(context),
            SizedBox(
              height: 400,
              child: SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                    dataSource: data,
                    xValueMapper: (ChartData data, _) => data.category,
                    yValueMapper: (ChartData data, _) => data.value,
                    pointColorMapper: (ChartData data, _) => data.color,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 3,
      physics: const NeverScrollableScrollPhysics(),
      children: data.map((data) => _buildLegendItem(data)).toList(),
    );
  }

  Widget _buildLegendItem(ChartData data) {
    return Row(
      children: [
        Icon(
          _getCategoryIcon(data.category),
          color: data.color,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          data.category,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.fastfood;
      case 'Transport':
        return Icons.directions_car;
      case 'Utilities':
        return Icons.lightbulb;
      case 'Entertainment':
        return Icons.movie;
      default:
        return Icons.category;
    }
  }
}

class ChartData {
  final String category;
  final double value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}

List<ChartData> getPieChartData() {
  return [
    ChartData('Food', 30, Colors.orange),
    ChartData('Transport', 10, Colors.green),
    ChartData('Utilities', 25, Colors.blue),
    ChartData('Entertainment', 35, Colors.yellow),
  ];
}
