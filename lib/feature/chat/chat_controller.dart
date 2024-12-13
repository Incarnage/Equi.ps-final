import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/feature/chat/chat_model.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sends a message, ensuring chatRoomID is consistent regardless of sender/receiver order
  Future<void> sendMessage(String receiverID, String receiverName, String message) async {
    final String currentUserId = UserController.instance.user.value.id;
    final String currentUserName = UserController.instance.user.value.fullName;
    final Timestamp timestamp = Timestamp.now();

    ChatModel newMessage = ChatModel(
      receiverName: receiverName,
      senderID: currentUserId,
      senderName: currentUserName,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // Ensure chatRoomID is generated consistently by sorting the IDs
    List<String> ids = [currentUserId, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // Retrieves a stream of messages from the correct chat room
  Stream<QuerySnapshot> getMessage(String userID, String otherID) {
    // Ensure chatRoomID is consistent regardless of sender/receiver order
    List<String> ids = [userID, otherID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // Fetches chat rooms containing messages involving the current user
  Future<Map<String, List<Map<String, dynamic>>>> getChatroomsWithMessages(String currentUserId) async {
    Map<String, List<Map<String, dynamic>>> chatRoomsWithMessages = {};

    try {
      // Use collectionGroup to fetch all messages across chat rooms
      final querySnapshot = await _firestore.collectionGroup('messages').get();

      for (var doc in querySnapshot.docs) {
        String chatRoomID = doc.reference.parent.parent!.id;
        Map<String, dynamic> messageData = doc.data();

        // Extract the IDs involved in this chat room
        List<String> ids = chatRoomID.split('_');

        // Check if the current user is part of this chat room
        if (ids.contains(currentUserId)) {
          // Add the message to the appropriate chat room
          chatRoomsWithMessages.putIfAbsent(chatRoomID, () => []);
          chatRoomsWithMessages[chatRoomID]!.add(messageData);
        }
      }

      return chatRoomsWithMessages;
    } catch (e) {
      print('Error fetching chat rooms with messages: $e');
      return {};
    }
  }
}
