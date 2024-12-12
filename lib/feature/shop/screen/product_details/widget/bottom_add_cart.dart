import 'package:equips_v2/feature/shop/models/product_model.dart';

import 'package:equips_v2/feature/shop/order/widgets/pay_screen.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EBottomeAddToCart extends StatelessWidget {
  final ProductModel product;

  const EBottomeAddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(TSizes.cardRaidusLarge),
              topRight: Radius.circular(TSizes.cardRaidusLarge))),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF25291C)),
                  backgroundColor: const Color(0xFF25291C)),
              onPressed: () => Get.to(() => PayScreen(
                    product: product,
                  )),
              child: const Text('Checkout'))),
    );
  }
}
