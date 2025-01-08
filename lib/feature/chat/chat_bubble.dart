import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: isCurrentUser ? Colors.grey[350] : const Color(0xFF25291C)),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Text(
        message,
        style: TextStyle(
            color: isCurrentUser ? const Color(0xFF25291C) : Colors.white,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
