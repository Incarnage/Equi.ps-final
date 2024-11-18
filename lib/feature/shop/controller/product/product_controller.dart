import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/data/repository/product/product_repository.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';

import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/lessor/lessor_Navigation_menu.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;

  final productRepository = ProductRepository();
  final userRepository = UserRepository();
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> lessorProducts = <ProductModel>[].obs;

  late final GlobalKey<FormState> addProductFormKey;

  final productName =
      TextEditingController(); // Controller for first name input
  final description = TextEditingController();
  final price = TextEditingController();
  final category = ''.obs;

  Rx<XFile?> imageFile = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();

  ProductController() {
    addProductFormKey = GlobalKey<FormState>();
  }

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;

      final products = await productRepository.getFeaturedProducts();

      featuredProducts.assignAll(products);
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final products = await productRepository.getFeaturedProducts();
      return products;
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> fetchAllLessorProducts() async {
    try {
      final products = await productRepository.getAllLessorProducts();
      return products;
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> lessorProduct() async {
    return await ProductRepository.instance.getLessorProducts(lessorProducts);
  }

  String getProductPrice(ProductModel product) {
    return product.price.toString();
  }

  String getStock(bool isAvailable) {
    return isAvailable ? 'Available' : 'Rented';
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = pickedFile;
    } else {
      ELoaders.errorSnackBar(title: 'Error', message: 'No image selected');
    }
  }

  // Function to upload the selected image to Firebase Storage
  Future<String?> uploadImage(XFile? imageFile) async {
    if (imageFile == null) return null;

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images/${imageFile.name}');
      final uploadTask = await storageRef.putFile(File(imageFile.path));
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Upload Error', message: e.toString());
      return null;
    }
  }

  // Function to add a product
  Future<void> addProduct() async {
    if (addProductFormKey.currentState!.validate()) {
      final user = await userRepository.fetchUserDetail();
      isLoading.value = true;
      try {
        final imageUrl = await uploadImage(imageFile.value);

        if (imageUrl == null) {
          ELoaders.errorSnackBar(
              title: 'Error', message: 'Please select an Image to upload');
          return;
        }

        await productRepository.addProduct({
          'Lessor': {
            'ID': user.id,
            'Image': user.profilePicture,
            'Name': user.fullName,
          },
          'isAvailable': true,
          'Title': productName.text,
          'Description': description.text,
          'price': price.text,
          'CategoryId': category.value,
          'Thumbnail': imageUrl, // The uploaded image URL
          'createdAt': FieldValue.serverTimestamp(),
        });

        ELoaders.successSnackBar(
            title: 'Success', message: 'Product added successfully');
      } catch (e) {
        ELoaders.errorSnackBar(title: 'Error', message: e.toString());
      } finally {
        Get.offAll(() => const LessorNavigationMenu());
        isLoading.value = false;
      }
    }
  }
}
