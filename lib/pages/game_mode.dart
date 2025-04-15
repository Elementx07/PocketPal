import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/rocket_launch_animation.dart';
import 'package:pocket_pal/widgets/game_mode_text.dart';
import 'package:pocket_pal/widgets/pocket_coin_display.dart';
import 'package:rive/rive.dart';

class GameModeScreen extends StatefulWidget {
  const GameModeScreen({super.key});

  @override
  State<GameModeScreen> createState() => _GameModeScreenState();
}

class _GameModeScreenState extends State<GameModeScreen> {
  bool showContent = false;

  int pocketCoins = 300;

  void _onLaunchComplete() {
    setState(() {
      showContent = true;
    });
  }

  void _showLeaderboardPopup(BuildContext context) {
    print("LEADERBOARD BUTTON TAPPED");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("🏆 Leaderboard"),
        content: Text("This is the leaderboard popup."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RocketLaunchAnimation(onAnimationComplete: _onLaunchComplete),
          if (showContent)
            Positioned.fill(
              child: Builder(
                builder: (innerContext) => Stack(
                  children: [
                    Positioned(
                      top: 50,
                      left: 20,
                      child: PocketCoinsWidget(coins: pocketCoins),
                    ),
                    Positioned(
                      top: 50,
                      right: 20,
                      child: IconButton(
                        onPressed: () => _showLeaderboardPopup(innerContext),
                        icon: const Icon(Icons.leaderboard, size: 30),
                        color: Colors.white,
                      ),
                    ),
                    Positioned.fill(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            top: 100, left: 24, right: 24, bottom: 40),
                        child: Column(
                          children: [
                            _buildInfoCard(),
                            const SizedBox(height: 16),
                            _buildTiersButton(),
                            const SizedBox(height: 16),
                            _buildChallengesCard(),
                            const SizedBox(height: 16),
                            _buildPlaceholder("🏆 Leaderboard"),
                            const SizedBox(height: 16),
                            _buildPlaceholder("🎯 Daily Spin Wheel"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 8,
      child: SizedBox(
        height: 500,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 70.0, vertical: 16.0),
                  child: Column(
                    children: [
                      Text("LEVEL 1",
                          style: arcadeFont(fontSize: 25, color: Colors.black)),
                      SizedBox(height: 8),
                      Text("NOVICE",
                          style: arcadeFont(fontSize: 25, color: Colors.black)),
                      SizedBox(height: 8),
                      Text("25 DAYS",
                          style: arcadeFont(fontSize: 30, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Text(
                  "• 20 free Pocket Coins\n\n• 3 months of Wynk Music\n\n• Free Cash upto 100rs\n\n• Special Swags",
                  style: arcadeFont(
                      fontSize: 18, color: Colors.black, letterSpacing: 2)),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  elevation: 10,
                ),
                child: Text("Claim Reward",
                    style: arcadeFont(fontSize: 14, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTiersButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Do the tier dance here
      },
      icon: Icon(Icons.military_tech),
      label: Text(
        'Check Tiers ->',
        style: arcadeFont(fontSize: 16, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 10,
      ),
    );
  }

  Widget _buildNextLevelCard() {
    return _simpleCard(
      title: "Next Tier Progress",
      buttonText: "View All Tiers",
    );
  }

  Widget _buildChallengesCard() {
    return _simpleCard(title: "💡 Challenges", buttonText: "Check Challenges");
  }

  Widget _buildPlaceholder(String title) {
    return _simpleCard(title: title, buttonText: "Coming Soon");
  }

  Widget _simpleCard({required String title, required String buttonText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () {}, child: Text(buttonText)),
          ],
        ),
      ),
    );
  }
}