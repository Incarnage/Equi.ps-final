import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/feature/shop/models/category_model.dart';
import 'package:equips_v2/utilities/exceptions/authexceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on EPlatformException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  // Get Sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection("Categories")
          .where("ParentId", isEqualTo: categoryId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  // Upload Categories to the Cloud Firebase
}
