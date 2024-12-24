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
  RxList<XFile> imageFiles = <XFile>[].obs;

  late final GlobalKey<FormState> addProductFormKey;
  late final GlobalKey<FormState> editProductFormKey;

  final productName =
      TextEditingController(); // Controller for first name input
  final description = TextEditingController();
  final price = TextEditingController();
  final pduration = TextEditingController();
  final category = ''.obs;

  Rx<XFile?> imageFile = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();

  ProductController() {
    addProductFormKey = GlobalKey<FormState>();
    editProductFormKey = GlobalKey<FormState>();
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
    final pickedFiles = await _picker.pickMultiImage();
    if(pickedFiles != null && pickedFiles.length + imageFiles.length > 5){
      ELoaders.errorSnackBar(title: "Limit Exceeded", message: "You can only upload a maximum of 5 images");
    }
    else if (pickedFiles != null) {
      imageFiles.addAll(pickedFiles);
    }
  }

  // Function to upload the selected image to Firebase Storage
  Future<List<String>> uploadImages(List<XFile> imageFiles) async {
    List<String> downloadUrls = [];
    try {
      for (var file in imageFiles) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('product_images/${file.name}');
        final uploadTask = await storageRef.putFile(File(file.path));
        final downloadUrl = await uploadTask.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Upload Error', message: e.toString());
    }
    return downloadUrls;
  }

  // Function to add a product
  Future<void> addProduct() async {
    if (addProductFormKey.currentState!.validate()) {
      isLoading.value = true;
      final user = await userRepository.fetchUserDetail();
      // Set loading state to true

      try {
        
        if (imageFiles.isEmpty) {
          ELoaders.errorSnackBar(
              title: 'Error', message: 'Please select an image to upload');
          return;
        }
        final imageURLs= await uploadImages(imageFiles);

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
          'Images': imageURLs,
          'createdAt': FieldValue.serverTimestamp(),
          'duration': pduration.text,
        });

        ELoaders.successSnackBar(
            title: 'Success', message: 'Product added successfully');
      } catch (e) {
        ELoaders.errorSnackBar(title: 'Error', message: e.toString());
      } finally {
        Get.offAll(() => const LessorNavigationMenu());
        isLoading.value = false;
        resetForm(); // Set loading state to false when done
      }
    }
  }

// In ProductController
  Future<void> updateProduct(ProductModel product) async {
    if (editProductFormKey.currentState!.validate()) {
      isLoading.value = true;
      final user = await userRepository.fetchUserDetail();

      try {
        List<String> imageUrl = product.images;
        if (imageUrl == null && imageFile.value != null) {
          ELoaders.errorSnackBar(
              title: 'Error', message: 'Please select an image to upload');
          return;
        }

        // Prepare the updated product data
        final updatedProductData = {
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
          'Images': imageFile.value != null
              ? imageUrl
              : product.images, // Use new image if uploaded
          'createdAt': FieldValue.serverTimestamp(),
          'duration': pduration.text,
        };

        // Call the repository method to update the product
        await productRepository.updateProduct(product.id, updatedProductData);

        ELoaders.successSnackBar(
            title: 'Success', message: 'Product updated successfully');
      } catch (e) {
        ELoaders.errorSnackBar(title: 'Error', message: e.toString());
      } finally {
        Get.offAll(() => const LessorNavigationMenu());
        isLoading.value = false;
      }
    }
  }

  Future<List<ProductModel>> fetchRandomProducts({int limit = 4}) async {
    try {
      // Fetch random products using the repository method
      final products = await productRepository.getRandomProducts(limit: limit);
      return products;
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  void resetForm() {
    productName.clear();
    description.clear();
    price.clear();
    pduration.clear();
    category.value = '';
    imageFile.value = null;
    addProductFormKey.currentState?.reset();
  }
}
