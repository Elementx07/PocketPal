import 'package:flutter/material.dart';
import 'chat_widget.dart';

class ChatPopup extends StatefulWidget {
  final VoidCallback onClose;

  const ChatPopup({
    super.key,
    required this.onClose,
  });

  @override
  State<ChatPopup> createState() => _ChatPopupState();
}

class _ChatPopupState extends State<ChatPopup> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 58, 58),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color.fromARGB(211, 157, 89, 179),
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 191, 107, 219),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        constraints: const BoxConstraints(
          maxWidth: 350,
          maxHeight: 500,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      _isLoading 
                          ? 'assets/thinking_state.png' 
                          : 'assets/normal_state.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Pa lly',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Arcade',
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: widget.onClose,
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ChatWidget(
                onLoadingChanged: (isLoading) {
                  setState(() => _isLoading = isLoading);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}