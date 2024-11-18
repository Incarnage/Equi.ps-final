import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/feature/shop/models/lessor_model.dart';

class ProductModel {
  String categoryId;
  String? description;
  List<String>? images;
  LessorModel? lessor;
  String id;
  double price;
  String productTitle;
  bool isAvailable;
  bool? isFeatured;
  String thumbnail;

  ProductModel(
      {required this.categoryId,
      required this.id,
      required this.price,
      required this.productTitle,
      required this.thumbnail,
      required this.isAvailable,
      this.lessor,
      this.description,
      this.images,
      this.isFeatured});

  // Create Empty function for clean code
  static ProductModel empty() => ProductModel(
        id: '',
        categoryId: '',
        price: 0,
        productTitle: '',
        thumbnail: '',
        isAvailable: true,
      );

  toJson() {
    return {
      'CategoryId': categoryId,
      'price': price,
      'Title': productTitle,
      'Thumbnail': thumbnail,
      'isAvailable': isAvailable,
      //'Name': lessorName,
      'Lessor': lessor!.toJson(),
      //'ID': lessorId,
      'Description': description,
      'Images': images ?? [],
      'IsFeatured': isFeatured,
    };
  }

  // Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
        id: document.id,
        categoryId: data['CategoryId'] ?? '',
        price: double.parse((data['price'] ?? 0.0).toString()),
        productTitle: data['Title'] ?? '',
        thumbnail: data['Thumbnail'] ?? '',
        isAvailable: data['isAvailable'] ?? false,
        lessor: (data['Lessor'] is Map<String, dynamic>)
            ? LessorModel.fromJson(data['Lessor'])
            : null,
        description: data['Description'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        images:
            data['Images'] != null ? List<String>.from(data['Images']) : []);
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
        id: document.id,
        categoryId: data['CategoryId'] ?? '',
        price: double.parse((data['price'] ?? 0.0).toString()),
        productTitle: data['Title'] ?? '',
        thumbnail: data['Thumbnail'] ?? '',
        isAvailable: data['isAvailable'] ?? false,
        lessor: (data['Lessor'] is Map<String, dynamic>)
            ? LessorModel.fromJson(data['Lessor'])
            : null,
        description: data['Description'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        images:
            data['Images'] != null ? List<String>.from(data['Images']) : []);
  }
}
