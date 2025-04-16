import 'package:flutter/material.dart';
import 'dart:math';
// import 'package:provider/provider.dart';
import 'package:pocket_pal/widgets/cosmos.dart';
// import 'package:pocket_pal/util/streak_provider.dart';
import 'package:pocket_pal/widgets/game_mode_text.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final streakProvider = Provider.of<StreakCoinProvider>(context);
    // final streak = streakProvider.streak;
    final streak = 6;
    final levelInfo = _getLevelAndTitle(streak);

    final users = _generateLeaderboardUsers(streak);

    return Scaffold(
      body: Stack(
        children: [
          const CosmosBackground(),
          // Adding a dark overlay to improve visibility of the main card
          Positioned.fill(
            child: Container(
              color: Colors.black
                  .withOpacity(0.5), // Dark overlay to make the card pop
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 100,
            left: 24,
            right: 24,
            child: _buildFloatingCard(levelInfo, streak),
          ),
          Positioned.fill(
            top: 420,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: _buildLeaderboard(users),
            ),
          ),
        ],
      ),
    );
  }

  /// One card with three stacked info sub-cards
  Widget _buildFloatingCard(Map<String, String> levelInfo, int streak) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.black,
      elevation: 15, // Increased elevation for better contrast
      shadowColor:
          Colors.orangeAccent.withOpacity(0.5), // Shadow color to make it pop
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Main Card with leaderboard and user stats
            _infoSubCard("Leaderboard", Colors.orange),
            const SizedBox(height: 12),
            _infoSubCard("YOUR STREAK: 6 🔥", Colors.orange),
            const SizedBox(height: 12),
            _infoSubCard("LEVEL: ${levelInfo['level']}\n${levelInfo['title']}",
                Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _infoSubCard(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: arcadeFont(fontSize: 20, color: color),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _generateLeaderboardUsers(int userStreak) {
    List<String> sampleNames = [
      "NovaBlitz",
      "PixelRogue",
      "LunaTrek",
      "VoidStrider",
      "StarSynth",
      "BitRunner",
      "SynthWave",
      "DataKnight",
      "EchoPulse",
      "CircuitWolf"
    ];

    // Random number generator
    Random random = Random();

    // Generate 19 dummy users with random streaks between 1 and 90
    List<Map<String, dynamic>> users = List.generate(19, (i) {
      int streak = random.nextInt(90) + 1; // Random streak between 1 and 90
      return {
        "name": sampleNames[i % sampleNames.length],
        "streak": streak,
        "isUser": false,
      };
    });

    // Add real user
    users.add({
      "name": "pocketKing",
      "streak": userStreak,
      "isUser": true,
    });

    // Sort users by streak DESCENDING
    users.sort((a, b) => b['streak'].compareTo(a['streak']));

    // Assign ranks ASCENDING from 80 to 99
    for (int i = 0; i < users.length; i++) {
      users[i]['rank'] = 80 + i;
    }

    return users;
  }

  Widget _buildLeaderboard(List<Map<String, dynamic>> users) {
    return Column(
      children: users.map((user) {
        return Card(
          color: user['isUser']
              ? Colors.orangeAccent.withOpacity(0.3)
              : Colors.white10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  user['isUser'] ? Colors.orangeAccent : Colors.deepPurple,
              radius: 16,
              child: Text(
                "${user['rank']}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              user['name'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: user['isUser'] ? Colors.orangeAccent : Colors.white,
              ),
            ),
            trailing: Text(
              "${user['streak']} days",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: user['isUser'] ? Colors.orangeAccent : Colors.white,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Map<String, String> _getLevelAndTitle(int streak) {
    if (streak < 10) {
      return {"level": "1", "title": "NOVICE"};
    } else if (streak < 20) {
      return {"level": "2", "title": "APPRENTICE"};
    } else if (streak < 30) {
      return {"level": "3", "title": "ADEPT"};
    } else {
      return {"level": "4", "title": "MASTER"};
    }
  }
}
