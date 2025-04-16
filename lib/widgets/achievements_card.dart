import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/game_mode_text.dart'; // arcadeFont
import 'package:pocket_pal/widgets/cosmos.dart'; // CosmosBackground

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CosmosBackground(), // Space background
          Positioned.fill(
            child: Container(
                color: Colors.black.withOpacity(0.65)), // Dark overlay
          ),
          // Back button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Title
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Text(
              'Achievements',
              style: arcadeFont().copyWith(
                fontSize: 36,
                color: Colors.orangeAccent,
                shadows: [
                  const Shadow(
                    blurRadius: 10,
                    color: Colors.orange,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Achievements List
          Positioned.fill(
            top: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: const [
                  AchievementTile(
                    icon: Icons.emoji_events,
                    iconColor: Colors.orangeAccent,
                    title: 'Consistent Saver',
                    subtitle:
                        'Top 25% of savers in your network\nUnlocked on Apr 5, 2025',
                    progress: null,
                  ),
                  AchievementTile(
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                    title: 'Budget Master',
                    subtitle: 'Stay under budget for 3 consecutive months',
                    progress: ProgressData(
                      percentage: 75,
                      progressText: '1 month remaining',
                    ),
                  ),
                  AchievementTile(
                    icon: Icons.savings_outlined,
                    iconColor: Colors.orange,
                    title: 'First Milestone',
                    subtitle: 'Save your first ₹1000\nUnlocked on Mar 15, 2025',
                    progress: null,
                  ),
                  AchievementTile(
                    icon: Icons.local_fire_department,
                    iconColor: Colors.redAccent,
                    title: '30-Day Streak',
                    subtitle: 'Log in to the app for 30 consecutive days',
                    progress: ProgressData(
                      percentage: 20,
                      progressText: '6 days completed, 24 to go',
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
}

class AchievementTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final ProgressData? progress;

  const AchievementTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white24, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 48),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (progress != null) ...[
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress!.percentage / 100,
                  backgroundColor: Colors.white12,
                  color: Colors.orange,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                progress!.progressText,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ProgressData {
  final int percentage;
  final String progressText;

  const ProgressData({required this.percentage, required this.progressText});
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AchievementsScreen(),
  ));
}
