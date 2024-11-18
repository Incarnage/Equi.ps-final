import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/shop/models/lessor_model.dart';
import 'package:equips_v2/utilities/exceptions/authexceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LessorRepository extends GetxController {
  static LessorRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllLessors() async {
    try {
      final snapshot = await _db
          .collection('Users')
          .where('UserType', isEqualTo: 'Lessor')
          .get();
      final result =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<List<LessorModel>> getLessorForCategory(String categoryId) async {
    try {
      QuerySnapshot lessorCategoryquery = await _db
          .collection('LessorCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      List<String> lessorId = lessorCategoryquery.docs
          .map((doc) => doc['lessorId'] as String)
          .toList();

      final lessorQuery = await _db
          .collection('Lessor')
          .where(FieldPath.documentId, whereIn: lessorId)
          .limit(2)
          .get();

      List<LessorModel> lessors =
          lessorQuery.docs.map((doc) => LessorModel.fromSnapshot(doc)).toList();

      return lessors;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}
