import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: isCurrentUser ? Color(0xFF25291C) : Colors.grey
       ),
       padding: EdgeInsets.all(10),
       margin: EdgeInsets.all(10) ,
       child: Text(message, style: TextStyle(color: isCurrentUser? Colors.white: Color(0xFF25291C)) ,),
    );
  }
}