import 'package:cached_network_image/cached_network_image.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  // var
  RxString selectedProductImage = ''.obs;

  // Get all images
  Future<List<String>> getAllProductImages(ProductModel product) async {
    // Add unique image
    Set<String> images = {};
    // Load image thumbnail
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // Use post frame callback to update after the current build cycle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set the selectedProductImage after the current build cycle
      selectedProductImage.value = product.thumbnail;
    });

    // Simulate a delay to mimic fetching data
    await Future.delayed(const Duration(seconds: 1));

    return images.toList();
  }

  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: TSizes.defaultSpace * 2,
                    horizontal: TSizes.defaultSpace),
                child: CachedNetworkImage(imageUrl: image),
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF25291C))),
                      onPressed: () => Get.back(),
                      child: const Text('Close')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
