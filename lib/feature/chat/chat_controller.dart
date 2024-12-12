import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/feature/chat/chat_model.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';

class Chatcontroller {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverID, message) async{

    final String currentUserId = UserController.instance.user.value.id;
    final String currentUserName = UserController.instance.user.value.fullName;
    final Timestamp timestamp = Timestamp.now();

  ChatModel newMessage = ChatModel(senderID: currentUserId, senderName: currentUserName, receiverID: receiverID, message: message, timestamp: timestamp);

  List<String> ids = [currentUserId, receiverID];
  ids.sort();
  String chatRoomID = ids.join('_');

  await _firestore.collection('chat_rooms').doc(chatRoomID).collection("messages").add(newMessage.toMap());

  }

  Stream<QuerySnapshot> getMessage(String userID, otherID){

  List<String> ids = [userID, otherID];
  ids.sort();
  String chatRoomID =     ids.join('_'); 

  return _firestore.collection('chat_rooms').doc(chatRoomID).collection('messages').orderBy('timestamp',descending: false).snapshots();
  }
}