import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback onLogout; // Add this new parameter

  const ProfileMenu({
    super.key,
    required this.name,
    required this.email,
    required this.onLogout, // Add this to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            _buildMenuItem(context, Icons.person, 'Profile'),
            _buildMenuItem(context, Icons.calendar_today, 'Subscription Tracker'),
            _buildMenuItem(context, Icons.upload, 'Uploads'),
            _buildMenuItem(context, Icons.leaderboard, 'Leaderboards'),
            _buildMenuItem(context, Icons.settings, 'Settings'),
            const Divider(color: Colors.white24),
            _buildMenuItem(context, Icons.logout, 'Log out', isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, {bool isLogout = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(); // Close the menu
          if (isLogout) {
            onLogout(); // Call the logout callback
          }
          // Add other navigation logic here for other menu items
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: isLogout ? Colors.red : Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: isLogout ? Colors.red : Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}