import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String senderID;
  final String senderName;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  ChatModel({
  required this.senderID,
  required this.senderName,
  required this.receiverID,
  required this.message,
  required this.timestamp});

  Map<String, dynamic> toMap(){
    return {
      'senderID': senderID,
      'senderName': senderName,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}