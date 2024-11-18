import 'package:cloud_firestore/cloud_firestore.dart';

class LessorCategoryModel {
  final String lessorID;
  final String categoryID;

  LessorCategoryModel({required this.lessorID, required this.categoryID});

  Map<String, dynamic> toJson() {
    return {'lessorId': lessorID, 'categoryId': categoryID};
  }

  factory LessorCategoryModel.fromSnapsot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return LessorCategoryModel(
        lessorID: data['lessorId'] as String,
        categoryID: data['categoryId'] as String);
  }
}
