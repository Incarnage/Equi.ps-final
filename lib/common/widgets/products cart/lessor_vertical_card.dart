import 'package:equips_v2/common/images/e_rounded_image.dart';
import 'package:equips_v2/common/styles/shadows.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/text/brandTitle_with_verifiedIcon.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/edit_product.dart';

import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LessorVerticalCard extends StatelessWidget {
  const LessorVerticalCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // Container with side paddings, color, edges, radius, and shadows
    return GestureDetector(
      onTap: () async {
        // Navigate to the EditProductDetails screen asynchronously
        await Get.to(() => EditProductDetails(product: product));
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: Colors.white,
        ),
        child: Column(
          children: [
            //thumbnail
            ERoundedcontainer(
              width: 180,
              height: 135,
              padding: const EdgeInsets.all(TSizes.small),
              child: Stack(
                children: [
                  Center(
                    child: ERoundedImage(
                      isNetworkImage: true,
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceItems / 2),
            // Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.small),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EProductTitleText(
                      title: product.productTitle, smallSize: true),
                  const SizedBox(height: TSizes.spaceItems / 2),
                  brandTitleWithVerifiedIcon(
                    title: product.lessor != null ? product.lessor!.name : '',
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: TSizes.small),
                        child: Text(
                          product.price.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(decoration: TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add to cart
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(TSizes.cardRaidusMedium),
                        bottomRight: Radius.circular(TSizes.productImageRadius),
                      )),
                  child: const SizedBox(
                      width: TSizes.iconLarge * 1.0,
                      height: TSizes.iconLarge * 1.0,
                      child: Center(
                          child: Icon(Iconsax.edit, color: Colors.white))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
