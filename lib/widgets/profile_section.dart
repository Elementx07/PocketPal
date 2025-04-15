import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/util/streak_provider.dart';
import 'package:pocket_pal/widgets/pocket_coin_display.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.isProfileVisible,
    required this.onVisibilityChanged,
  });

  final bool isProfileVisible;
  final ValueChanged<bool> onVisibilityChanged;

  @override
  Widget build(BuildContext context) {
    final streak = context.watch<StreakCoinProvider>().streak;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 5 && !isProfileVisible) {
          onVisibilityChanged(true);
        } else if (details.delta.dy < -5 && isProfileVisible) {
          onVisibilityChanged(false);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 49, 2, 65),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      PocketCoinsWidget(coins: 300),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              Image.asset('assets/123.jpg', height: 75, width: 70),
              const SizedBox(height: 10),
              Text(
                "🔥 Streak: $streak",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
