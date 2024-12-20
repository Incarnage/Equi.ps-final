import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/lessor/lessor_Navigation_menu.dart';
import 'package:equips_v2/utilities/exceptions/authexceptions.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.put(ProductRepository());

  final _db = FirebaseFirestore.instance;
  final userRepository = Get.put(UserRepository());

  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isAvailable', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again $e';
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isAvailable', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getAllLessorProducts() async {
    try {
      final user = await userRepository.fetchUserDetail();
      final snapshot = await _db
          .collection('Products')
          .where('Lessor.ID', isEqualTo: user.id)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> fetchProductsbyQuery(Query query) async {
    try {
      final querysnapshot = await query.get();
      final List<ProductModel> productList = querysnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getBookmarkProducts(List<String> productId) async {
    if (productId.isEmpty) {
      return [];
    }
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productId)
          .get();

      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again $e';
    }
  }

  Future<List<ProductModel>> getLessorProducts(
      RxList<ProductModel> productId) async {
    try {
      final user = await userRepository.fetchUserDetail();
      final snapshot = await _db
          .collection('Products')
          .where('Lessor.ID', isEqualTo: user.id)
          .get();

      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsforLessors(
      {required String lessorId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Lessor.ID', isEqualTo: lessorId)
              .get()
          : await _db
              .collection('Products')
              .where('Lessor.ID', isEqualTo: lessorId)
              .limit(limit)
              .get();
      final product = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return product;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsByCategory({
    required String categoryId, // The ID of the category
    int limit = 10,
  }) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> categorySnapshot =
          await _db.collection('Categories').doc(categoryId).get();

      // Check if the category exists
      if (!categorySnapshot.exists) {
        throw 'Category not found';
      }

      // Fetch the products that have the same CategoryId
      QuerySnapshot<Map<String, dynamic>> productSnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('CategoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('Products')
              .where('CategoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      // Map the documents to ProductModel including the document ID
      List<ProductModel> products = productSnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      await _db.collection('Products').add(productData);
    } catch (e) {
      throw 'Something went wrong. Could not add product: $e';
    }
  }

  Future<void> updateProduct(String productId, Map<String, dynamic> updatedData) async {
  try {
    await _db.collection('Products').doc(productId).update(updatedData);
  } catch (e) {
    throw 'Something went wrong. Could not update product: $e';
  }
}

  Future<void> removeProductRecord(String productId) async {
    try {
      EFullScreenLoader.openLoadingDialog(
          "We are processing your information...", "assets/pic/loading.json");
      await _db.collection("Products").doc(productId).delete();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Try Again";
    } finally {
      Get.off(() => const LessorNavigationMenu());
    }
  }

   Future<List<ProductModel>>  getRandomProducts({int limit = 4}) async {
    try {
      // Fetch all available products
      final snapshot = await _db
          .collection('Products')
          .where('isAvailable', isEqualTo: true)
          .get();

      // Convert Firestore documents to a list of ProductModel
      List<ProductModel> allProducts = snapshot.docs
          .map((e) => ProductModel.fromSnapshot(e))
          .toList();

      // Check if the number of available products is less than the requested limit
      if (allProducts.length <= limit) {
        return allProducts;  // Return all products if there are fewer than the limit
      }

      // Randomly select the products
      List<ProductModel> randomProducts = [];
      Random random = Random();
      
      // Ensure that we select unique products
      Set<int> selectedIndexes = {};
      while (randomProducts.length < limit) {
        int randomIndex = random.nextInt(allProducts.length);
        if (!selectedIndexes.contains(randomIndex)) {
          selectedIndexes.add(randomIndex);
          randomProducts.add(allProducts[randomIndex]);
        }
      }

      return randomProducts;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}



