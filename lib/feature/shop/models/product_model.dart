import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/feature/shop/models/lessor_model.dart';

class ProductModel {
  String categoryId;
  String? description;
  List<String> images;
  LessorModel? lessor;
  String id;
  double price;
  String productTitle;
  bool isAvailable;
  bool? isFeatured;
  String thumbnail;
  double pduration;
  List<String> delivertOption;

  ProductModel({
    required this.categoryId,
    required this.id,
    required this.price,
    required this.productTitle,
    required this.isAvailable,
    required this.images,
    this.lessor,
    this.description,
    this.isFeatured,
    required this.pduration,
    required this.delivertOption,
  }) : thumbnail = images.isNotEmpty ? images.first : '';

  // Create Empty function for clean code
  static ProductModel empty() => ProductModel(
        pduration: 0,
        id: '',
        categoryId: '',
        price: 0,
        productTitle: '',
        images: [],
        isAvailable: true,
        delivertOption: []
      );

  Map<String, dynamic> toJson() {
    return {
      'duration': pduration,
      'CategoryId': categoryId,
      'price': price,
      'Title': productTitle,
      'Images': images,
      'isAvailable': isAvailable,
      'Lessor': lessor?.toJson(),
      'Description': description,
      'IsFeatured': isFeatured,
      'DeliveryOption': delivertOption,
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
      pduration: double.parse((data['duration'] ?? 0.0).toString()),
      id: document.id,
      categoryId: data['CategoryId'] ?? '',
      price: double.parse((data['price'] ?? 0.0).toString()),
      productTitle: data['Title'] ?? '',
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      isAvailable: data['isAvailable'] ?? false,
      lessor: (data['Lessor'] is Map<String, dynamic>)
          ? LessorModel.fromJson(data['Lessor'])
          : null,
      description: data['Description'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      delivertOption: data['DeliveryOption'] != null
          ? List<String>.from(data['DeliveryOption'])
          : [], 
    );
  }
}
