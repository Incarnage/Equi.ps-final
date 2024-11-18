import 'package:cached_network_image/cached_network_image.dart';
import 'package:equips_v2/common/images/e_rounded_image.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/custom_shapes/curved_edges/cureved_edges_widget.dart';
import 'package:equips_v2/common/widgets/products%20cart/bookmark/bookmark.dart';
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
    final image = controller.getAllProductImages(product);

    return CurvedEdge(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            //large image
            SizedBox(
                height: 400,
                child: Padding(
                  padding: EdgeInsets.all(TSizes.productImageRadius * 5.5),
                  child: Center(child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Colors.green,
                        ),
                      ),
                    );
                  })),
                )),

            //image slider
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
                  itemCount: image.length,
                  itemBuilder: (_, index) => Obx(
                    () {
                      final imageSelected =
                          controller.selectedProductImage.value == image[index];
                      return ERoundedImage(
                          width: 80,
                          isNetworkImage: true,
                          onPressed: () => controller
                              .selectedProductImage.value = image[index],
                          border: Border.all(
                              color: imageSelected
                                  ? const Color(0xFF25291C)
                                  : Colors.transparent),
                          padding: const EdgeInsets.all(TSizes.small),
                          imageUrl: image[index]);
                    },
                  ),
                ),
              ),
            ),

            //appbar
            TAppbar(
              showBackArrow: true,
              actions: [EBookmark(productId: product.id)],
            )
          ],
        ),
      ),
    );
  }
}
