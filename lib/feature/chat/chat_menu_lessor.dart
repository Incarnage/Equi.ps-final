import 'package:equips_v2/feature/chat/chat.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_controller.dart';

class ChatNavigationLessor extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Rooms'),
      ),
       body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
  future: chatController.getChatroomsWithMessages('s'),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('No chat rooms found.'));
    }

    final chatRooms = snapshot.data!;

    // Create a unique set of senders mapped to their chatRoomID
    final Map<String, String> uniqueSenders = {};

    chatRooms.forEach((chatRoomID, messages) {
      for (var message in messages) {
        final senderName = message['senderName'] ?? 'Unknown Sender';
        // Add the sender to the map if not already present
        uniqueSenders[senderName] = chatRoomID;
      }
    });

    // Convert the map into a list of entries
    final uniqueSenderList = uniqueSenders.entries.toList();

    return  ListView.builder(
  itemCount: uniqueSenderList.length,
  itemBuilder: (context, index) {
    final senderName = uniqueSenderList[index].key; // Name of the sender
    final senderDetails = chatRooms[uniqueSenderList[index].value]!.first; // Get the first message from the chat room to retrieve sender details
    final senderEmail = senderDetails['senderName'] ?? '';
    final senderID = senderDetails['senderID'] ?? '';

    return ListTile(
      title: Text(senderName),
      onTap: () {
        // Navigate to the chat room with the sender's email and ID
        Get.to(() => ChatRoom(
          receiverEmail: senderEmail,
          receiverID: senderID,
        ));
      },
    );
  },
);
;
  },
)



    );
  }
}



