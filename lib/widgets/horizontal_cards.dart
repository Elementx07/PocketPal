import 'package:flutter/material.dart';
import 'line_graph.dart';

class HorizontalCards extends StatelessWidget {
  final List<CardData>? cardDataList;

  const HorizontalCards({
    super.key,
    this.cardDataList,
  });

  List<CardData> get _defaultCards => [
        CardData(
          'Total Savings',
          2400.0,
          3200.0,
          const Color(0xFFE091E8),
          subtitle: '3 Months',
          icon: Icons.trending_up,
        ),
        CardData(
          'Expenses',
          960.0,
          1200.0,
          const Color(0xFFFF7F7F),
          subtitle: 'This Month',
          icon: Icons.receipt_outlined,
        ),
        CardData(
          'Savings',
          300.0,
          500.0,
          const Color(0xFFFFB84D),
          subtitle: 'This Month',
          icon: Icons.savings_outlined,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final cards = cardDataList ?? _defaultCards;

    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () => _showGraphDialog(context, card),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: card.color,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildCard(card),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(CardData card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              card.icon,
              color: Colors.white,
              size: 24,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: card.progress / card.value,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 4,
                  ),
                ),
                Text(
                  '${(card.progress / card.value * 100).round()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Text(
          '₹${card.value.round()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          card.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Text(
          card.subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _showGraphDialog(BuildContext context, CardData card) {
    final List<GraphData> sampleData = [
      GraphData('Jan', 100),
      GraphData('Feb', 200),
      GraphData('Mar', 300),
      GraphData('Apr', 400),
    ];

    print('Opening dialog with data: ${sampleData.map((d) => '${d.label}: ${d.value}').join(', ')}'); // Debug print

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 36, 36, 36),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineGraphWidget(
                      dataPoints: sampleData,
                      title: '${card.title} Trends',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CardData {
  final String title;
  final double progress;
  final double value;
  final Color color;
  final String subtitle;
  final IconData icon;

  CardData(
    this.title,
    this.progress,
    this.value,
    this.color, {
    this.subtitle = '',
    this.icon = Icons.circle,
  });
}

// Remove this class and use the one from line_graph.dart