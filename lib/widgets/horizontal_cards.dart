import 'package:flutter/material.dart';

class HorizontalCards extends StatelessWidget {
  final List<CardData>? cardDataList;
  final bool isSubscriptionPage;

  const HorizontalCards({
    super.key,
    this.cardDataList,
    this.isSubscriptionPage = false,
  });

  List<CardData> get _defaultSubscriptionCards => [
        CardData('Active', 10, 0, Colors.green, isCount: true),
        CardData('Expired', 2, 0, Colors.red, isCount: true),
        CardData('Upcoming', 5, 0, Colors.orange, isCount: true),
      ];

  List<CardData> get _defaultDashboardCards => [
        CardData(
          'Expenses',
          800.0,
          2000.0,
          const Color.fromARGB(138, 244, 67, 54),
          showProgress: true,
        ),
        CardData(
          'Savings',
          1200.0,
          5000.0,
          const Color.fromARGB(255, 21, 162, 92),
          showProgress: true,
        ),
        CardData(
          'Income',
          2000.0,
          3000.0,
          const Color.fromARGB(128, 33, 149, 243),
          showProgress: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final cards = cardDataList ??
        (isSubscriptionPage
            ? _defaultSubscriptionCards
            : _defaultDashboardCards);

    return SizedBox(
      height: isSubscriptionPage ? 120 : 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Card(
              elevation: 10,
              shadowColor: card.color.withAlpha(100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                //set the width of the card
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      card.color.withAlpha(255),
                      card.color.withAlpha(150),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: card.showProgress
                      ? _buildProgressCard(card)
                      : _buildCountCard(card),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressCard(CardData card) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${card.progress.toStringAsFixed(2)} / ${card.value.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        _buildProgressIndicator(card),
      ],
    );
  }

  Widget _buildCountCard(CardData card) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          card.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          card.progress.toInt().toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(CardData card) {
    return Container(
      width: 90,
      height: 80,
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: card.color.withAlpha(204),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: CircularProgressIndicator(
        value: card.value != 0 ? card.progress / card.value : 0,
        backgroundColor: const Color.fromARGB(255, 159, 158, 158),
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 8,
      ),
    );
  }
}

class CardData {
  final String title;
  final double progress;
  final double value;
  final Color color;
  final bool isCount;
  final bool showProgress;

  CardData(
    this.title,
    this.progress,
    this.value,
    this.color, {
    this.isCount = false,
    this.showProgress = false,
  });
}
