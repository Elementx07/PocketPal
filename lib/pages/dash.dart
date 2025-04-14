import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/bottom_navigation_bar.dart';
import 'package:pocket_pal/widgets/horizontal_cards.dart';
import 'package:pocket_pal/widgets/profile_section.dart';
import 'package:pocket_pal/widgets/pi_chart.dart';

import 'package:rive/rive.dart';



import 'package:pocket_pal/pages/game_mode.dart';

import 'package:pocket_pal/pages/expense_add_sheet.dart';



class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _selectedIndex = 0;
  bool _isProfileVisible = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Builder(builder: (context) => _buildBody(context)),
      // ExpenseTrackerScreen(),
      // SubscriptionTrackerScreen(),
      GameModeScreen()
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,

      body: screens[_selectedIndex],

      floatingActionButton: Transform.scale(
        scale: 1.2,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.grey[900],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              builder: (BuildContext context) => const ExpenseBottomSheet(),
            );
          },
          backgroundColor: const Color.fromARGB(255, 106, 34, 131),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      bottomNavigationBar: PocketPalBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          ProfileSection(
            isProfileVisible: _isProfileVisible,
            onVisibilityChanged: (visible) {
              setState(() {
                _isProfileVisible = visible;
              });
            },
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      const HorizontalCards(isSubscriptionPage: false),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      PieChartWidget(data: getPieChartData()),
                      const SizedBox(height: 100),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
