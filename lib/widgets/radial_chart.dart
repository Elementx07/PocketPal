import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialChart extends StatelessWidget {
  const RadialChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1, 90, 'Food', const Color.fromARGB(255, 219, 130, 41)),
      ChartData(2, 50, 'Transport', const Color.fromARGB(255, 28, 180, 218)),
      ChartData(3, 70, 'Entertainment', const Color.fromARGB(255, 51, 243, 93)),
      ChartData(4, 30, 'Utilities', const Color.fromARGB(255, 243, 51, 51)),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(70, 81, 81, 92),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            SfCircularChart(
              series: <RadialBarSeries<ChartData, int>>[
                RadialBarSeries<ChartData, int>(
                  useSeriesColor: true,
                  trackOpacity: 0.3,
                  cornerStyle: CornerStyle.bothCurve,
                  dataSource: chartData,
                  pointRadiusMapper: (ChartData data, _) => '0.7',
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.xValue,
                  yValueMapper: (ChartData data, _) => data.yValue,
                )
              ],
            ),
            _buildLegend(context, chartData),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(BuildContext context, List<ChartData> chartData) {
    return GridView.count(
      padding: const EdgeInsets.all(1),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 3,
      physics: const NeverScrollableScrollPhysics(),
      children: chartData.map((data) => _buildLegendItem(data)).toList(),
    );
  }

  Widget _buildLegendItem(ChartData data) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: data.color, size: 16),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            data.text,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class ChartData {
  final int xValue;
  final double yValue;
  final String text;
  final Color color;

  ChartData(this.xValue, this.yValue, this.text, this.color);
}