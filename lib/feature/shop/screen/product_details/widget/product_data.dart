import 'package:equips_v2/common/widgets/products%20cart/product_price.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class ProductData extends StatelessWidget {
  const ProductData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //price
        Row(
          children: [
            //title
            const EProductTitleText(title: 'Rental Cost'),
            const SizedBox(width: TSizes.spaceItems),
            ProductPriceText(
              isLarge: true,
              price: controller.getProductPrice(product),
            ),
          ],
        ),

        //stock
        Row(
          children: [
            const EProductTitleText(title: 'Status'),
            const SizedBox(width: TSizes.spaceItems),
            Text(
              controller.getStock(product.isAvailable),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        const SizedBox(
          height: TSizes.spaceItems,
        ),

        // Location
        Row(
          children: [
            //title
            const EProductTitleText(title: 'Location'),
            const SizedBox(width: TSizes.spaceItems),
            Text(
              product.lessor!.address,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),

        const SizedBox(
          height: TSizes.spaceItems,
        ),
      ],
    );
  }
}
