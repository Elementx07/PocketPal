import 'package:flutter/material.dart';

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
