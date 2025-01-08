import 'package:equips_v2/feature/chat/chat.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_controller.dart';

// ignore: use_key_in_widget_constructors
class ChatNavigationLessor extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF25291C),
      appBar: AppBar(
        title: Text(
          'Messages',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.white),
        ),
      ),
      body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
        future: chatController
            .getChatroomsWithMessages(UserController.instance.user.value.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chat rooms found.'));
          }

          final chatRooms = snapshot.data!;

          // Collect unique chat participants
          final Map<String, String> uniqueParticipants = {};

          chatRooms.forEach((chatRoomID, messages) {
            if (messages.isNotEmpty) {
              // Get the last message in the chat room (to represent the most recent participant)
              final lastMessage = messages.last;
              final currentUserID = UserController.instance.user.value.id;

              // Check whether the current user is the sender or receiver
              final isCurrentUserSender =
                  lastMessage['senderID'] == currentUserID;
              final otherParticipantID = isCurrentUserSender
                  ? lastMessage['receiverID']
                  : lastMessage['senderID'];
              final otherParticipantName = isCurrentUserSender
                  ? lastMessage['receiverName']
                  : lastMessage['senderName'];

              // Add the other participant to the map if not already added
              if (!uniqueParticipants.containsKey(otherParticipantID)) {
                uniqueParticipants[otherParticipantName] = otherParticipantID;
              }
            }
          });

          // Convert unique participants into a list for display
          final participantList = uniqueParticipants.entries.toList();

          return ListView.builder(
            itemCount: participantList.length,
            itemBuilder: (context, index) {
              final participantName =
                  participantList[index].key; // Name of the other participant
              final participantID =
                  participantList[index].value; // ID of the other participant

              return Container(
                margin: const EdgeInsets.all(TSizes.spaceItems),
                padding: const EdgeInsets.all(TSizes.spaceItems / 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)),
                child: ListTile(
                  title: Text(participantName),
                  onTap: () {
                    // Navigate to the chat room with the participant's details
                    Get.to(() => ChatRoom(
                          receiverEmail:
                              participantName, // Display name of the participant
                          receiverID: participantID, // ID of the participant
                        ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
