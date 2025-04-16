import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/daily_challenge_button.dart';
import 'package:pocket_pal/widgets/game_mode_text.dart';

class ChallengeDialog extends StatelessWidget {
  const ChallengeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.95), // Black background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 🎯 Daily Challenge
              Text(
                "🎯 Daily Challenge",
                style: arcadeFont(fontSize: 20, color: Colors.orangeAccent),
              ),
              const SizedBox(height: 12),
              const DailyChallengeButton(),
              const SizedBox(height: 30),

              /// 🧠 Active Challenges
              Text(
                "🧠 Active Challenges",
                style: arcadeFont(fontSize: 20, color: Colors.orangeAccent),
              ),
              const SizedBox(height: 16),
              _buildActiveChallenge(
                title: "Coffee Break Challenge",
                reward: "100 p",
                description: "Skip coffee shop visits for a week",
                progressText: "3/7 Days",
                progressPercent: 0.42,
              ),
              const SizedBox(height: 16),
              _buildActiveChallenge(
                title: "No Uber Week",
                reward: "80 pc",
                description: "Use public transport for a full week",
                progressText: "2/7 Days",
                progressPercent: 0.28,
              ),
              const SizedBox(height: 30),

              /// 🔒 Challenge History
              Text(
                "📜 Challenge History",
                style: arcadeFont(fontSize: 20, color: Colors.orangeAccent),
              ),
              const SizedBox(height: 16),
              _buildOldChallenge("Walk 2000 steps before 6 PM – COMPLETED"),
              _buildOldChallenge("No fast food for 3 days – COMPLETED"),
              _buildOldChallenge("Drink 2L water daily for 5 days – COMPLETED"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveChallenge({
    required String title,
    required String reward,
    required String description,
    required String progressText,
    required double progressPercent,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8), // Dark background for cards
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orangeAccent, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: arcadeFont(fontSize: 16, color: Colors.white),
                ),
              ),
              Text(
                reward,
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                progressText,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "${(progressPercent * 100).toInt()}%",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progressPercent,
            backgroundColor: Colors.white24,
            color: Colors.orangeAccent,
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildOldChallenge(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6), // Darker background for history
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
