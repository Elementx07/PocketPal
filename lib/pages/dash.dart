import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _selectedIndex = 0;

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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 111, 8, 175),
      ),
      child: Column(
        children: [
          _buildProfileSection(),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      _buildHorizontalCards(context),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      _buildChart(context),
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

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 49, 2, 65),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 8, 60, 58),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "POCKET PAL",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arcade'
                ),
              ),
              IconButton(
                
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
            const Text(
            "🔥",
            style: TextStyle(fontSize: 70,
            shadows: [
                Shadow(
                  blurRadius: 50.0,
                  color: Color.fromARGB(255, 255, 187, 0),
                  offset: Offset(0, 5),
                ),
              ],
            ),
            ),
          
          const SizedBox(height: 10),
          const Text(
            "Streak: 9000",
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              fontWeight: FontWeight.bold,
              
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCards(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.8;

    final List<CardData> cardDataList = [
      CardData('Savings', 1200.0, Colors.green),
      CardData('Expenses', 800.0, Colors.red),
      CardData('Income', 2000.0, Colors.blue),
    ];

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cardDataList.length,
        itemBuilder: (context, index) {
          return Container(
            width: cardWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              color: cardDataList[index].color.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardDataList[index].title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${cardDataList[index].value.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChart(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1, 90, 'Food', const Color.fromARGB(255, 219, 130, 41)),
      ChartData(2, 50, 'Transport', const Color.fromARGB(255, 28, 180, 218)),
      ChartData(3, 70, 'Entertainment', const Color.fromARGB(255, 51, 243, 93)),
      ChartData(4, 30, 'Utilities', const Color.fromARGB(255, 243, 51, 51)),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(70, 81, 81, 92),
          shape: BoxShape.rectangle,
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

        //this is the chart
        child: Column(
          children: [
            SfCircularChart(
              series: <RadialBarSeries<ChartData, int>>[
                RadialBarSeries<ChartData, int>(
                  useSeriesColor: true,
                  trackOpacity: 0.3,
                  cornerStyle: CornerStyle.bothCurve,
                  dataSource: chartData,
                  pointRadiusMapper: (ChartData data, _) => '0.7',
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.xValue,
                  yValueMapper: (ChartData data, _) => data.yValue,
                )
              ],
            ),
            
            _buildLegend(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1, 90, 'Food', const Color.fromARGB(255, 219, 130, 41)),
      ChartData(2, 50, 'Transport', const Color.fromARGB(255, 28, 180, 218)),
      ChartData(3, 70, 'Entertainment', const Color.fromARGB(255, 51, 243, 93)),
      ChartData(4, 30, 'Utilities', const Color.fromARGB(255, 243, 51, 51)),
    ];

    return GridView.count(
        padding: const EdgeInsets.all(1),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 3,
        physics: const NeverScrollableScrollPhysics(),
        children: chartData.map((data) => _buildLegendItem(data)).toList(),
      );
  }

  Widget _buildLegendItem(ChartData data) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: data.color, size: 16),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            data.text,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
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
          icon: Icon(Icons.person),
          label: 'Profile',
          backgroundColor: Color.fromARGB(255, 49, 2, 65),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Color.fromARGB(255, 49, 2, 65),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}

class ChartData {
  final int xValue;
  final double yValue;
  final String text;
  final Color color;

  ChartData(this.xValue, this.yValue, this.text, this.color);
}

class CardData {
  final String title;
  final double value;
  final Color color;

  CardData(this.title, this.value, this.color);
}