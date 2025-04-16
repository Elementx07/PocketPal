import 'package:flutter/material.dart';

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
          icon: Icon(Icons.history),
          label: 'Recent',
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
        onItemTapped(index);
       
      },
    );
  }
}
