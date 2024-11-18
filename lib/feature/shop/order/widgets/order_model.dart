import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? id;
  String lesseeId;
  String lessorId; // ID of the lessor who is renting out the product
  String productId; // ID of the rented product
  String paymentImageUrl; // URL or path of the payment proof image
  DateTime fromDate; // Rental start date
  DateTime toDate;
  String status; // Rental end date

  OrderModel(
      {this.id,
      required this.lesseeId,
      required this.lessorId,
      required this.productId,
      required this.paymentImageUrl,
      required this.fromDate,
      required this.toDate,
      required this.status});

  static OrderModel empty() => OrderModel(
      id: "",
      lesseeId: "",
      lessorId: "",
      productId: "",
      paymentImageUrl: "",
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
      status: "");
  // Method to convert OrderModel to a Map (for saving to Firestore or a similar database)
  Map<String, dynamic> toJson() {
    return {
      'lesseeId': lesseeId,
      'lessorId': lessorId,
      'productId': productId,
      'payment': paymentImageUrl,
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'status': status
    };
  }

  // Factory method to create an OrderModel from a Firestore snapshot
  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return OrderModel.empty();
    final data = document.data()!;

    return OrderModel(
        id: document.id,
        lesseeId: data['lesseeId'] ?? '',
        lessorId: data['lessorId'] ?? '',
        productId: data['productId'] ?? '',
        paymentImageUrl: data['payment'] ?? '',
        fromDate: DateTime.parse(data['fromDate'] ?? ''),
        toDate: DateTime.parse(data['toDate']),
        status: data['status'] ?? '');
  }
}
