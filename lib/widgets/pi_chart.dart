import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/providers/expense_provider.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        final expenses = provider.expenses;
        
        // Group expenses by category
        final Map<String, double> categoryTotals = {};
        for (var expense in expenses) {
          if (expense.category != 'Income') {
            categoryTotals[expense.category] = (categoryTotals[expense.category] ?? 0) + expense.amount;
          }
        }

        // Convert to ChartData
        final data = categoryTotals.entries.map((entry) {
          return ChartData(
            entry.key,
            entry.value,
            _getCategoryColor(entry.key),
          );
        }).toList();

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
                _buildLegend(context, data),
                SizedBox(
                  height: 400,
                  child: SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries<ChartData, String>(
                        dataSource: data,
                        xValueMapper: (ChartData data, _) => data.category,
                        yValueMapper: (ChartData data, _) => data.value,
                        pointColorMapper: (ChartData data, _) => data.color,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.outside,
                          textStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.pink[100]!;
      case 'Drinks':
        return Colors.green[200]!;
      case 'Transport':
        return Colors.blue[200]!;
      case 'Shopping':
        return Colors.purple[200]!;
      case 'Entertainment':
        return Colors.orange[200]!;
      case 'Housing':
        return Colors.green;
      case 'Electronics':
        return Colors.blue;
      case 'Medical':
        return Colors.red[300]!;
      case 'Misc':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Widget _buildLegend(BuildContext context, List<ChartData> data) {
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
