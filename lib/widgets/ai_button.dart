import 'package:flutter/material.dart';
import 'chat_popup.dart';

class AIButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;
  final double top;
  final double right;

  const AIButton({
    super.key,
    required this.onTap,
    required this.imagePath,
    this.top = 100.0,
    this.right = 16.0,
  });

  void _showChatPopup(BuildContext context) {
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) => Material(
        type: MaterialType.transparency,
        child: ChatPopup(
          onClose: () => Navigator.of(dialogContext, rootNavigator: true).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [
              Color(0xFF9C27B0),
              Color(0xFF2196F3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF9C27B0),
              blurRadius: 6,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color(0xFF2196F3),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(0, 49, 2, 65),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => _showChatPopup(context),
                child: ClipOval(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 56.0,
                    height: 56.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}