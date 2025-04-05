import 'package:flutter/material.dart';
import 'package:pocket_pal/widgets/bottom_navigation_bar.dart';
import 'package:pocket_pal/widgets/horizontal_cards.dart';
import 'package:pocket_pal/widgets/profile_section.dart';
import 'package:pocket_pal/widgets/radial_chart.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _selectedIndex = 0;
  bool _isProfileVisible = true;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Settings Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
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
          GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.delta.dy > 5 && !_isProfileVisible) {
                // Swipe down
                setState(() {
                  _isProfileVisible = true;
                });
              } else if (details.delta.dy < -5 && _isProfileVisible) {
                // Swipe up
                setState(() {
                  _isProfileVisible = false;
                });
              }
            },
            child: ClipRect(
              child: SizeTransition(
                sizeFactor: AlwaysStoppedAnimation(_isProfileVisible ? 1.0 : 0.0),
                child: ProfileSection(
                  isProfileVisible: _isProfileVisible,
                  onVisibilityChanged: (visible) {
                    setState(() {
                      _isProfileVisible = visible;
                    });
                  },
                ),
              ),
            ),
          ),
          if (!_isProfileVisible)
            GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 5) {
                  setState(() {
                    _isProfileVisible = true;
                  });
                }
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 49, 2, 65),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(51),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_drop_down, color: Colors.white),
              ),
            ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      HorizontalCards(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      RadialChart(),
                      SizedBox(
                        height: 100,
                      ),
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