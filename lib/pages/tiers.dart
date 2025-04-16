import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/game_mode_text.dart'; // For arcadeFont
import 'package:pocket_pal/widgets/cosmos.dart'; // For Cosmos background

class TiersScreen extends StatelessWidget {
  const TiersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of tier data
    final tiers = [
      {
        'level': 'LEVEL 1',
        'title': 'NOVICE',
        'days': '25 DAYS',
        'points': [
          '20 free Pocket Coins',
          '3 months of Wynk Music',
          'Free cash upto 100rs',
          'Special swags'
        ]
      },
      {
        'level': 'LEVEL 2',
        'title': 'CHAMP',
        'days': '50 DAYS',
        'points': [
          '6 months of free Amazon Prime',
          'Comprehensive branding package',
          '6 months of Wynk Music',
          'Special Swags'
        ]
      },
      {
        'level': 'LEVEL 3',
        'title': 'GOD MODE',
        'days': '90 DAYS',
        'points': [
          'Amazon Gift Card worth 1500rs',
          '3 Months free Xbox Game Pass',
          'Exclusive discounts on popular fashion brands',
          'Special PocketPal Momento'
        ]
      },
    ];

    // Scroll controller for the PageView
    final PageController pageController = PageController(viewportFraction: 0.9);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          const CosmosBackground(),
          Column(
            children: [
              const SizedBox(height: 160),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: tiers.length,
                    itemBuilder: (context, index) {
                      final tier = tiers[index];
                      return _buildTierCard(context, tier);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTierCard(BuildContext context, Map<String, dynamic> tierData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 10,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9, // Wider cards
          height: 450, // Reduced card height
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSubCard(
                    tierData['level'], tierData['title'], tierData['days']),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildBulletPoints(tierData['points']),
                  ),
                ),
                const SizedBox(height: 20),
                _buildClaimButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubCard(String level, String title, String days) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
        child: Column(
          children: [
            Text(level, style: arcadeFont(fontSize: 22, color: Colors.white)),
            const SizedBox(height: 2),
            Text(title, style: arcadeFont(fontSize: 22, color: Colors.white)),
            const SizedBox(height: 2),
            Text(days, style: arcadeFont(fontSize: 30, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoints(List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points
          .map((point) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0), // Increased vertical padding
                child: Text(
                  "• $point",
                  style: arcadeFont(
                      fontSize: 20, color: Colors.black), // Increased font size
                ),
              ))
          .toList(),
    );
  }

  Widget _buildClaimButton() {
    return ElevatedButton(
      onPressed: () {
        // Claim logic goes here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 18),
        elevation: 10,
      ),
      child: Text("CLAIM",
          style: arcadeFont(
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 4,
          )),
    );
  }
}
