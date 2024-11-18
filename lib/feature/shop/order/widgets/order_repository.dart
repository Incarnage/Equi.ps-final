import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_model.dart';
import 'package:equips_v2/utilities/exceptions/authexceptions.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.put(OrderRepository());

  final _db = FirebaseFirestore.instance;

  final userRepository = Get.put(UserRepository());

  //save user data to firestore

  Future<void> saveOrderRecord(OrderModel order) async {
    try {
      await _db.collection("Orders").doc(order.id).set(order.toJson());
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Try Again";
    }
  }

  Future<List<OrderModel>> getLessorsOrders() async {
    try {
      final user = await userRepository.fetchUserDetail();
      final snapshot = await _db
          .collection('Orders')
          .where('lessorId', isEqualTo: user.id)
          .get();
      return snapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<ProductModel?> getProductNamebyId(String productId) async {
    try {
      final product = await _db.collection('Products').doc(productId).get();
      if (product.exists) {
        return ProductModel.fromSnapshot(product);
      } else {
        return null;
      }
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<bool> updateOrderStatus(String orderId, String status) async {
    try {
      final orderRef =
          FirebaseFirestore.instance.collection('Orders').doc(orderId);
      await orderRef.update({'status': status});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateProductStatus(String productId) async {
    try {
      final productRef =
          FirebaseFirestore.instance.collection('Products').doc(productId);

      final productsnap = await productRef.get();

      if (productsnap.exists && productsnap.data()?['isAvailable'] == true) {
        await productRef.update({'isAvailable': false});
      } else {
        await productRef.update({'isAvailable': true});
      }
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
