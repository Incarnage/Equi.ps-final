import 'package:cached_network_image/cached_network_image.dart';
import 'package:equips_v2/common/images/e_rounded_image.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/custom_shapes/curved_edges/cureved_edges_widget.dart';
import 'package:equips_v2/common/widgets/products%20cart/bookmark/bookmark.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/shop/controller/product/images_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;
  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final user = Get.find<UserController>().user;

    return FutureBuilder<List<String>>(
      future: controller.getAllProductImages(product),
      builder: (context, snapshot) {
        // Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Handle error state
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final images = snapshot.data ?? [];

        // Filter out invalid URLs
        final validImages = images.where((image) => _isValidUrl(image)).toList();

        // If no images available, use an empty string
       

        return CurvedEdge(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                // Large image
                SizedBox(
                  height: 400,
                  child: Padding(
                    padding: EdgeInsets.all(TSizes.productImageRadius * 5.5),
                    child: Center(
                      child: Obx(() {
                        final selectedImage = controller.selectedProductImage.value;
                        return GestureDetector(
                          onTap: () => controller.showEnlargedImage(selectedImage),
                          child: selectedImage.isNotEmpty && _isValidUrl(selectedImage)
                              ? CachedNetworkImage(
                                  imageUrl: selectedImage,
                                  progressIndicatorBuilder: (_, __, downloadProgress) =>
                                      CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    color: Colors.green,
                                  ),
                                )
                              : const Icon(Icons.error), // Fallback in case of invalid URL
                        );
                      }),
                    ),
                  ),
                ),

                // Image slider
                Positioned(
                  right: 0,
                  bottom: 30,
                  left: TSizes.defaultSpace,
                  child: SizedBox(
                    height: 80,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(
                        width: TSizes.spaceItems,
                      ),
                      itemCount: validImages.length,
                      itemBuilder: (_, index) => Obx(() {
                        final imageSelected =
                            controller.selectedProductImage.value == validImages[index];
                        return ERoundedImage(
                          width: 80,
                          isNetworkImage: true,
                          onPressed: () => controller.selectedProductImage.value = validImages[index],
                          border: Border.all(
                            color: imageSelected ? const Color(0xFF25291C) : Colors.transparent,
                          ),
                          padding: const EdgeInsets.all(TSizes.small),
                          imageUrl: validImages[index],
                        );
                      }),
                    ),
                  ),
                ),

                // App bar
                TAppbar(
                  showBackArrow: true,
                  
                  actions: [
                    if(user.value.userType=='Lessee')
                    EBookmark(productId: product.id)],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Utility function to validate image URLs
  bool _isValidUrl(String url) {
    return Uri.tryParse(url)?.hasScheme == true;
  }
}
