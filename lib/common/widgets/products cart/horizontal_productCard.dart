import 'package:equips_v2/common/images/e_rounded_image.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/products%20cart/bookmark/bookmark.dart';
import 'package:equips_v2/common/widgets/text/brandTitle_with_verifiedIcon.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HorizontalProductcard extends StatelessWidget {
  const HorizontalProductcard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Thumbnail
          ERoundedcontainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.small),
            backgroundColor: Colors.white,
            child: Stack(
              children: [
                // Thumbnail Image
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ERoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true),
                ),
                Positioned(top: 0, right: 0, child: EBookmark(productId: ''))
              ],
            ),
          ),

          // Details
          SizedBox(
            width: 172,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: TSizes.small, left: TSizes.small),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      EProductTitleText(
                          title: product.productTitle, smallSize: true),
                      const SizedBox(height: TSizes.spaceItems / 2),
                      brandTitleWithVerifiedIcon(title: product.lessor!.name)
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Flexible(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: TSizes.small),
                              child: Text(
                                product.price.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(
                                        decoration: TextDecoration.lineThrough),
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
                              bottomRight:
                                  Radius.circular(TSizes.productImageRadius),
                            )),
                        child: const SizedBox(
                            width: TSizes.iconLarge * 1.0,
                            height: TSizes.iconLarge * 1.0,
                            child: Center(
                                child: Icon(Iconsax.add, color: Colors.white))),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
