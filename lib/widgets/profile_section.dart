import 'package:flutter/material.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({
    super.key,
    required this.isProfileVisible,
    required this.onVisibilityChanged,
  });

  final bool isProfileVisible;
  final ValueChanged<bool> onVisibilityChanged;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    final double fullHeight = 250;
    final double minimizedHeight = 50;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 5 && !widget.isProfileVisible) {
          widget.onVisibilityChanged(true);
        } else if (details.delta.dy < -5 && widget.isProfileVisible) {
          widget.onVisibilityChanged(false);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: widget.isProfileVisible ? fullHeight : minimizedHeight,
        width: double.infinity,
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
            // Always-visible drag handle
            Container(
              height: 20,
              alignment: Alignment.center,
              child: Icon(
                widget.isProfileVisible ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
            // Slide-in content
            Expanded(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: widget.isProfileVisible ? 1 : 0,
                child: widget.isProfileVisible
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "POCKET PAL",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Arcade',
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.notifications, color: Colors.white),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "🔥",
                              style: TextStyle(
                                fontSize: 50,
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
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}