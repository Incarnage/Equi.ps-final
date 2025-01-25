import 'package:equips_v2/common/images/e_rounded_image.dart';
import 'package:equips_v2/common/styles/shadows.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/products%20cart/bookmark/bookmark.dart';
import 'package:equips_v2/common/widgets/text/brandTitle_with_verifiedIcon.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/screen/product_details/product_details.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

     final formattedPrice = NumberFormat.currency(
      locale: 'en_PH', 
      symbol: '₱', 
      decimalDigits: 0,
    ).format(product.price);
    // Container with side paddings, color, edges, radius, and shadows
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetails(
            product: product,
          )),
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
                  Positioned(
                      top: 0, right: 0, child: EBookmark(productId: product.id))
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
                    title: product.productTitle,
                    smallSize: true,
                    textAlign: TextAlign.center,
                  ),
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
            Text(
              formattedPrice, // Use the formatted price
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(decoration: TextDecoration.none),
            )
          ],
        ),
      ),
    );
  }
}
