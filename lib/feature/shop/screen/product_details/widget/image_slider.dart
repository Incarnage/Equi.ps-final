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
    final ImagesController controller = Get.put(ImagesController());
    final user = Get.find<UserController>().user;

    return FutureBuilder<List<String>>(
      future: controller.getAllProductImages(product),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final images = snapshot.data ?? [];
        if (images.isEmpty) {
          return const Center(child: Text('No images available'));
        }

        return CurvedEdge(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                // Main image display
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
                                  placeholder: (_, __) => const CircularProgressIndicator(),
                                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                                )
                              : const Icon(Icons.error),
                        );
                      }),
                    ),
                  ),
                ),

                // Thumbnail slider
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
                      separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceItems),
                      itemCount: images.length,
                      itemBuilder: (_, index) {
                        return Obx(() {
                          final imageSelected =
                              controller.selectedProductImage.value == images[index];
                          return ERoundedImage(
                            width: 80,
                            isNetworkImage: true,
                            onPressed: () => controller.selectedProductImage.value = images[index],
                            border: Border.all(
                              color: imageSelected ? const Color(0xFF25291C) : Colors.transparent,
                            ),
                            padding: const EdgeInsets.all(TSizes.small),
                            imageUrl: images[index],
                          );
                        });
                      },
                    ),
                  ),
                ),

                // App bar
                TAppbar(
                  showBackArrow: true,
                  actions: [
                    if (user.value.userType == 'Lessee')
                      EBookmark(productId: product.id),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isValidUrl(String url) {
    return Uri.tryParse(url)?.hasScheme == true;
  }
}
