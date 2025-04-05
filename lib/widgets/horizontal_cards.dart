import 'package:flutter/material.dart';

class HorizontalCards extends StatelessWidget {
  const HorizontalCards({super.key});

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.8;

    final List<CardData> cardDataList = [
      CardData('Savings', 1200.0, const Color.fromARGB(255, 21, 162, 92)),
      CardData('Expenses', 800.0, const Color.fromARGB(138, 244, 67, 54)),
      CardData('Income', 2000.0, const Color.fromARGB(128, 33, 149, 243)),
    ];

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cardDataList.length,
        itemBuilder: (context, index) {
          return Container(
            width: cardWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 10,
              shadowColor: cardDataList[index].color.withAlpha(100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      cardDataList[index].color.withAlpha(255),
                      cardDataList[index].color.withAlpha(150),
                    ],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cardDataList[index].title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '\$${cardDataList[index].value.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: cardDataList[index].color.withAlpha(204),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                value: cardDataList[index].value / 2000, // Example progress value
                                backgroundColor: Colors.grey.withAlpha(100),
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardData {
  final String title;
  final double value;
  final Color color;

  CardData(this.title, this.value, this.color);
}