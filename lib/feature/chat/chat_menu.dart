import 'package:equips_v2/feature/chat/chat.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_controller.dart';

class ChatNavigation extends StatelessWidget {
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
            return const Center(
                child: Text(
              'No chat rooms found.',
              style: TextStyle(color: Colors.white),
            ));
          }

          final chatRooms = snapshot.data!;

          // Create a unique set of senders for the current user
          final Map<String, Map<String, dynamic>> uniqueSenders = {};

          chatRooms.forEach((chatRoomID, messages) {
            for (var message in messages) {
              final senderID = message['senderID'];
              final receiverID = message['receiverID'];
              final senderName = message['senderName'] ?? 'Unknown Sender';
              final receiverName =
                  message['receiverName'] ?? 'Unknown Receiver';

              // Determine the "other person" in the chat room
              String otherID;
              String otherName;

              if (senderID == UserController.instance.user.value.id) {
                otherID = receiverID;
                otherName = receiverName;
              } else {
                otherID = senderID;
                otherName = senderName;
              }

              // Add to uniqueSenders if the otherID is not already present
              if (!uniqueSenders.containsKey(otherID)) {
                uniqueSenders[otherID] = {
                  'name': otherName,
                  'chatRoomID': chatRoomID,
                };
              }
            }
          });

          // Convert uniqueSenders into a list for the ListView
          final uniqueSenderList = uniqueSenders.entries.toList();

          return ListView.builder(
            itemCount: uniqueSenderList.length,
            itemBuilder: (context, index) {
              final sender = uniqueSenderList[index];
              final senderID = sender.key;
              final senderName = sender.value['name'];
              final chatRoomID = sender.value['chatRoomID'];

              return Container(
                margin: const EdgeInsets.all(TSizes.spaceItems),
                padding: const EdgeInsets.all(TSizes.spaceItems / 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)),
                child: ListTile(
                  title: Text(senderName),
                  onTap: () {
                    if (senderName.isNotEmpty && senderID.isNotEmpty) {
                      try {
                        Get.to(() => ChatRoom(
                              receiverEmail: senderName,
                              receiverID: senderID,
                            ));
                      } catch (e) {
                        print('Navigation error: $e');
                      }
                    } else {
                      print(
                          'Invalid sender data: senderName=$senderName, senderID=$senderID');
                    }
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
