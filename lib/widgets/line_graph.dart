import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineGraphWidget extends StatelessWidget {
  final List<GraphData> dataPoints; // Data points for the graph
  final String title; // Title of the graph

  const LineGraphWidget({
    super.key,
    required this.dataPoints,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      color: const Color.fromARGB(255, 36, 36, 36), // Semi-transparent background
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300, // Height of the graph
              child: SfCartesianChart(
                backgroundColor: Colors.transparent,
                plotAreaBorderWidth: 0,
                primaryXAxis: CategoryAxis(
                  labelStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(color: Colors.white24),
                ),
                primaryYAxis: NumericAxis(
                  labelStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  majorGridLines: const MajorGridLines(color: Colors.white24),
                  axisLine: const AxisLine(color: Colors.white24),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
                series: <CartesianSeries>[
                  LineSeries<GraphData, String>(
                    dataSource: dataPoints,
                    xValueMapper: (GraphData data, _) => data.label,
                    yValueMapper: (GraphData data, _) => data.value,
                    color: Colors.orangeAccent,
                    width: 3,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      color: Colors.orangeAccent,
                      borderWidth: 2,
                      shape: DataMarkerType.circle,
                    ),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  color: Colors.black,
                  textStyle: const TextStyle(color: Colors.white),
                  header: '',
                  canShowMarker: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GraphData {
  final String label; // Label for the x-axis
  final double value; // Value for the y-axis

  GraphData(this.label, this.value);
}
