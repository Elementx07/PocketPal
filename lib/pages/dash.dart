import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
    const DashBoardPage({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                            Color.fromARGB(255, 72, 40, 213),
                            Color.fromARGB(255, 72, 40, 213),
                        ],
                    ),
                ),
                child: Column(
                    children: [
                    // Top Section
                    Container(
                        
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                    Color.fromARGB(255, 157, 220, 189),
                                    Color.fromARGB(255, 19, 201, 186),
                                ],
                            ),
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
                                        
                                        IconButton(
                                            icon: const Icon(Icons.notifications, color: Colors.white),
                                            onPressed: () {},
                                        ),
                                    ],
                                ),
                                const SizedBox(height: 20),
                                CircleAvatar(
                                    radius: 40,
                                    backgroundImage: AssetImage('assets/user_image.png'), // Replace with your image asset
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                    "User Name",
                                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                            ],
                        ),
                    ),
                    const SizedBox(height: 20),                    
                    const SizedBox(height: 20),
                    // Bottom Section
                    SizedBox(
                      height: 400, // Adjust this value to make it smaller or larger
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                    ),
                                ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const Text(
                                        "Spending",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                        "₹1436 / ₹3000",
                                        style: TextStyle(fontSize: 16, color: Colors.blue),
                                    ),
                                    const SizedBox(height: 20),
                                    Expanded(
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                                _buildBar("Mon", 50, Colors.green),
                                                _buildBar("Tue", 100, Colors.red),
                                                _buildBar("Wed", 150, Colors.red),
                                                _buildBar("Thu", 80, Colors.green),
                                                _buildBar("Fri", 60, Colors.green),
                                                _buildBar("Sat", 120, Colors.red),
                                                _buildBar("Sun", 140, Colors.red),
                                            ],
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ),
                  ),
                ],
            ),
        )
        );
    }


    Widget _buildBar(String day, double height, Color color) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Container(
                    width: 10,
                    height: height,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5),
                    ),
                ),
                const SizedBox(height: 5),
                Text(day, style: const TextStyle(fontSize: 12)),
            ],
        );
    }
}