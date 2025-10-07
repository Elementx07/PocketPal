import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/pocket_coin_display.dart';
import 'package:pocket_pal/widgets/notification_item.dart';
import 'package:pocket_pal/widgets/profile_menu.dart';
import 'package:pocket_pal/pages/sign_in.dart';

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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: const Color(0xFF1E1E1E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              width: 300,
                              constraints: const BoxConstraints(maxHeight: 400),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Updates',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close, color: Colors.white60),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(color: Colors.white.withOpacity(0.1)),
                                  Flexible(
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        NotificationItem(
                                          title: 'Zomato',
                                          message: 'Ordered Biryani for ₹200',
                                          timeAgo: '20 minutes ago',
                                          icon: Icons.restaurant,
                                          iconBackgroundColor: Colors.red,
                                        ),
                                        NotificationItem(
                                          title: 'Amazon',
                                          message: 'Purchased Bluetooth headphones for ₹500',
                                          timeAgo: '2 hours ago',
                                          icon: Icons.shopping_bag,
                                          iconBackgroundColor: Colors.orange,
                                        ),
                                        NotificationItem(
                                          title: 'Netflix',
                                          message: 'Subscription renewed for ₹649',
                                          timeAgo: '1 day ago',
                                          icon: Icons.movie,
                                          iconBackgroundColor: Colors.red,
                                        ),
                                        NotificationItem(
                                          title: 'New Reward!',
                                          message: 'You\'ve earned 50 XP for logging in today!',
                                          timeAgo: 'Just now',
                                          icon: Icons.card_giftcard,
                                          iconBackgroundColor: Colors.amber,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  final RenderBox button = context.findRenderObject() as RenderBox;
                  final Offset position = button.localToGlobal(Offset.zero);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          Positioned(
                            top: position.dy + 150, // Adjust this value to position the menu
                            right: 69,
                            child: ProfileMenu(
                              name: 'John Doe',
                              email: 'john.doe@example.com',
                              onLogout: () {
                                // Navigate to sign in screen
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                                  (route) => false, // This removes all previous routes from the stack
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    
                  );
                },
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "🔥 Streak: 6",
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
