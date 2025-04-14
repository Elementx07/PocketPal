import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/rocket_launch_animation.dart';

class GameModeScreen extends StatefulWidget {
  const GameModeScreen({super.key});

  @override
  State<GameModeScreen> createState() => _GameModeScreenState();
}

class _GameModeScreenState extends State<GameModeScreen> {
  bool showContent = false;

  void _onLaunchComplete() {
    setState(() {
      showContent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Space Loop (replace with your looping clip if needed)
          Container(color: Colors.black),

          // Rocket Launch Animation
          RocketLaunchAnimation(onAnimationComplete: _onLaunchComplete),

          // Post-launch content
          if (showContent)
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    _buildInfoCard(),
                    const SizedBox(height: 16),
                    _buildNextLevelCard(),
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
    );
  }

  Widget _buildInfoCard() {
    return _simpleCard(
      title: "🔥 Streak: 5 days\n🚀 Tier: Silver",
      buttonText: "Claim Reward",
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
