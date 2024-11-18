import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/feature/shop/models/banner_model.dart';
import 'package:equips_v2/utilities/exceptions/authexceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  //var
  final _db = FirebaseFirestore.instance;

  // Get all order of the current user
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection("Banners")
          .where("Active", isEqualTo: true)
          .get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching the Banners';
    }
  }
}
