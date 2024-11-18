import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  final String productID;
  final String categoryID;

  ProductCategoryModel({required this.productID, required this.categoryID});

  Map<String, dynamic> toJson() {
    return {'productId': productID, 'categoryId': categoryID};
  }

  factory ProductCategoryModel.fromSnapsot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductCategoryModel(
        productID: data['productId'] as String,
        categoryID: data['categoryId'] as String);
  }
}
