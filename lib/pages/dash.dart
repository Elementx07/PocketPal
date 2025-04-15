import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/bottom_navigation_bar.dart';
import 'package:pocket_pal/widgets/horizontal_cards.dart';
import 'package:pocket_pal/widgets/profile_section.dart';
import 'package:pocket_pal/widgets/pi_chart.dart';
import 'package:pocket_pal/pages/game_mode.dart';
import 'package:pocket_pal/pages/expense_track_page.dart';
import 'package:pocket_pal/pages/subscription_page.dart';
import 'package:pocket_pal/util/streak_manager.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _selectedIndex = 0;
  bool _isProfileVisible = true;

  @override
  void initState() {
    super.initState();
    updateStreak(); // 🔥 This ensures the streak updates with real time every time dashboard is opened
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Builder(builder: (context) => _buildBody(context)),
      ExpenseTrackPage(),
      SubscriptionPage(),
      GameModeScreen()
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: screens[_selectedIndex],
      bottomNavigationBar: PocketPalBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 78, 6, 123),
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
                      HorizontalCards(),
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
