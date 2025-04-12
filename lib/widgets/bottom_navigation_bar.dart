import 'package:flutter/material.dart';
import 'package:pocket_pal/pages/subscription_page.dart';

class PocketPalBottomNavigationBar extends StatelessWidget {
  const PocketPalBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color.fromARGB(255, 49, 2, 65),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          backgroundColor: Color.fromARGB(255, 49, 2, 65),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions),
          label: 'Subscriptons',
          backgroundColor: Color.fromARGB(255, 49, 2, 65),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.gamepad),
          label: 'Game Mode',
          backgroundColor: Color.fromARGB(255, 49, 2, 65),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      onTap: (index) {
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SubscriptionPage()),
          );
        } else {
          onItemTapped(index);
        }
      },
    );
  }
}
