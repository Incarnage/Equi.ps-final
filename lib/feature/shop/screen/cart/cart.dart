import 'package:equips_v2/common/widgets/appbar/appbar.dart';

import 'package:equips_v2/feature/shop/screen/cart/widget/checkout_cart_items.dart';
import 'package:equips_v2/feature/shop/screen/checkout/checkout.dart';

import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  final bool showAddRemoveButtons = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
          showBackArrow: true,
          title:
              Text("Cart", style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),

          //items
          child: CheckoutCartItems()),

      //checkout
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25291C),
              side: const BorderSide(
                width: 3.0,
                color: Color(0xFF25291C),
              ),
            ),
            child: const Text('Checkout')),
      ),
    );
  }
}
