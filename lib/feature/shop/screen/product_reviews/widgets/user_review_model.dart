import 'package:cloud_firestore/cloud_firestore.dart';

class UserReviewModel {
  final String senderID;
  final String senderName;
  final String productID;
  final double rating;
  final String message;
  final Timestamp timestamp;

  UserReviewModel({
  required this.senderID,
  required this.senderName,
  required this. productID,
  required this.rating,
  required this.message,
  required this.timestamp});

  Map<String, dynamic> toMap(){
    return {
      'senderID': senderID,
      'senderName': senderName,
      'productID': productID,
      'rating': rating,
      'message': message,
      'timestamp': timestamp,
    };
  }
}