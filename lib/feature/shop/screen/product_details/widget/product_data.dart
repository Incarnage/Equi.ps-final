import 'package:equips_v2/common/widgets/products%20cart/product_price.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductData extends StatelessWidget {
  const ProductData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      locale: 'en_PH', 
      symbol: '₱', 
      decimalDigits: 0,
    ).format(product.price);
    final controller = ProductController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //price
        Row(
          children: [
            //title
            const SizedBox(
              width: 50,
              child: EProductTitleText(
                  title: 'Rental Cost', textColor: Colors.black),
            ),
            const SizedBox(width: TSizes.spaceItems),
            ProductPriceText(
              isLarge: true,
              price: formattedPrice,
            ),
            Text(' / ${product.pduration} hours', style: Theme.of(context).textTheme.headlineMedium,)

          ],
        ),

        //stock
        Row(
          children: [
            const SizedBox(
              width: 50,
              
              child: EProductTitleText(title: 'Status', textColor: Colors.black)),
            const SizedBox(width: TSizes.spaceItems),
            Text(
              controller.getStock(product.isAvailable),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
