import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/widgets/rocket_launch_animation.dart';
import 'package:pocket_pal/widgets/pocket_coin_display.dart';
import 'package:pocket_pal/widgets/challenge_dialog.dart';
import 'package:pocket_pal/pages/leaderboardscreen.dart';
import 'package:pocket_pal/widgets/game_mode_text.dart';
import 'package:pocket_pal/util/streak_provider.dart';
import 'package:pocket_pal/pages/tiers.dart';
import 'package:pocket_pal/widgets/achievements_card.dart';
import 'package:pocket_pal/widgets/savings_goals_card.dart';

// ... imports remain the same ...

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
  void _goToLeaderboard() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
    );
  }

  void _goToAchievements() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AchievementsScreen()),
    );
  }

  void _goToSavingsGoals() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SavingsGoalScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final streakProvider = Provider.of<StreakCoinProvider>(context);
    final streak = streakProvider.streak;
    final levelInfo = _getLevelAndTitle(streak);

    return Scaffold(
      appBar: showContent
          ? AppBar(
              elevation: 4,
              title: const Text('GAME MODE',
                  style: TextStyle(
                    fontSize: 30,
                    wordSpacing: 4,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arcade',
                    color: Colors.orangeAccent,
                  )),
              backgroundColor: const Color.fromARGB(255, 49, 2, 65),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: PocketCoinsWidget(coins: 300),
                ),
              ],
            )
          : null,
      body: Stack(
        children: [
          RocketLaunchAnimation(onAnimationComplete: _onLaunchComplete),
          if (showContent)
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 24, left: 24, right: 24, bottom: 40),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildInfoCard(levelInfo, streak),
                    const SizedBox(height: 16),
                    _buildTiersButton(),
                    const SizedBox(height: 20),
                    _buildChallengesCard(context),
                    const SizedBox(height: 20),
                    _buildleaderboardbody(context),
                    const SizedBox(height: 20),
                    _buildachievements(context),
                    const SizedBox(height: 20),
                    _savingsgoal(context),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(Map<String, dynamic> levelInfo, int streak) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 8,
      color: Colors.orange, // Card background
      child: SizedBox(
        height: 500,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  child: Column(
                    children: [
                      Text("🔥 STREAK",
                          style: arcadeFont(
                              fontSize: 22, color: Colors.orangeAccent)),
                      const SizedBox(height: 2),
                      Text("6",
                          style: arcadeFont(fontSize: 26, color: Colors.white)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ⚡ Level + Title Card
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                  child: Column(
                    children: [
                      Text(levelInfo['level'],
                          style: arcadeFont(
                              fontSize: 25, color: Colors.orangeAccent)),
                      const SizedBox(height: 4),
                      Text(levelInfo['title'],
                          style: arcadeFont(fontSize: 25, color: Colors.white)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🎁 Rewards Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("• 20 free Pocket Coins",
                      style: arcadeFont(fontSize: 20, color: Colors.black)),
                  Text("• 3 months of Wynk Music",
                      style: arcadeFont(fontSize: 20, color: Colors.black)),
                  Text("• Free cash upto 100rs",
                      style: arcadeFont(fontSize: 20, color: Colors.black)),
                  Text("• Special swags",
                      style: arcadeFont(fontSize: 20, color: Colors.black)),
                ],
              ),

              const Spacer(),

              // 🏆 Claim Reward Button
              ElevatedButton(
                onPressed: () {
                  // reward logic coming soon
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  elevation: 10,
                ),
                child: Text("CLAIM REWARD",
                    style:
                        arcadeFont(fontSize: 14, color: Colors.orangeAccent)),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TiersScreen()),
        );
      },
      icon: const Icon(Icons.military_tech, color: Colors.white),
      label: Text(
        'Check Tiers →',
        style: arcadeFont(fontSize: 16, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        side: const BorderSide(color: Colors.orangeAccent, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 12,
      ),
    );
  }

  Widget _buildChallengesCard(BuildContext context) {
    return Container(
      height: 155,
      width: double.infinity,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("🎮 Do A Challenge",
                  style: arcadeFont(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const ChallengeDialog(),
                  );
                },
                child: Text("Challenges →",
                    style: arcadeFont(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildleaderboardbody(BuildContext context) {
    return Container(
      height: 155,
      width: double.infinity,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("🏆Leaderboard",
                  style: arcadeFont(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  _goToLeaderboard();
                },
                child: Text("LeaderBoard->",
                    style: arcadeFont(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildachievements(BuildContext context) {
    return Container(
      height: 155,
      width: double.infinity,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("💫Achievements",
                  style: arcadeFont(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  _goToAchievements();
                },
                child: Text("Achievements->",
                    style: arcadeFont(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _savingsgoal(BuildContext context) {
    return Container(
      height: 155,
      width: double.infinity,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("🎯Savings Goals",
                  style: arcadeFont(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  _goToSavingsGoals();
                },
                child: Text("Savings Goals->",
                    style: arcadeFont(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, String> _getLevelAndTitle(int streak) {
    if (streak < 10) {
      return {"level": "LEVEL 1", "title": "NOVICE"};
    } else if (streak < 20) {
      return {"level": "LEVEL 2", "title": "APPRENTICE"};
    } else if (streak < 30) {
      return {"level": "LEVEL 3", "title": "ADEPT"};
    } else {
      return {"level": "LEVEL 4", "title": "MASTER"};
    }
  }
}