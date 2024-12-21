import 'package:equips_v2/common/widgets/text/brandTitle_with_verifiedIcon.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/common/widgets/text/section_heading.dart';

import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/bottom_add_cart.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/image_slider.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/product_data.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/unavailable.dart';
import 'package:equips_v2/feature/shop/screen/product_reviews/productReviews.dart';
import 'package:equips_v2/utilities/constants/enums.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: product.isAvailable == true
          ? EBottomeAddToCart(
              product: product,
            )
          : const Unavailable(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //image slider
            ImageSlider(
              product: product,
            ),

            const Divider(),
            const SizedBox(height: TSizes.spaceItems),

            // name of product
            EProductTitleText(title: product.productTitle, smallSize: true),
            // Store Name
            brandTitleWithVerifiedIcon(
              title: product.lessor!.name,
              brandTextSize: TextSizes.medium,
            ),

            const SizedBox(height: TSizes.spaceItems),

            const Divider(),
            const SizedBox(
              height: TSizes.spaceItems,
            ),
            //product details
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  // rental cost and status
                  ProductData(
                    product: product,
                  ),

                  const SizedBox(
                    height: TSizes.spaceItems,
                  ),

                  //desc
                  const SectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),

                  ReadMoreText(product.description ?? '',
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Less',
                      moreStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      )),

                  const SizedBox(
                    height: TSizes.spaceItems,
                  ),

                  // Facebook
                  Row(
                    children: [
                      //title
                      const EProductTitleText(title: 'Facebook'),
                      const SizedBox(width: TSizes.spaceItems),
                      Text(
                        product.lessor!.facebook,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: TSizes.spaceItems,
                  ),

                  // Instagram
                  Row(
                    children: [
                      //title
                      const EProductTitleText(title: 'Instagram'),
                      const SizedBox(width: TSizes.spaceItems),
                      Text(
                        product.lessor!.facebook,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: TSizes.spaceItems,
                  ),

                  // Facebook
                  Row(
                    children: [
                      //title
                      const EProductTitleText(title: 'Gmail'),
                      const SizedBox(width: TSizes.spaceItems),
                      Text(
                        product.lessor!.facebook,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: TSizes.spaceItems,
                  ),

                  //rating
                  // const RatingAndShare(),

                  //reviews
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionHeading(
                        title: 'Reviews (100)',
                        onPressed: () {},
                        showActionButton: false,
                      ),
                      IconButton(
                          onPressed: () =>
                              Get.to(() => const ProductReviewScreen()),
                          icon: const Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceItems,
                  ),

                  //checkout
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
