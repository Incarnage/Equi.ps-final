import 'package:equips_v2/common/widgets/products%20cart/product_price.dart';
import 'package:equips_v2/common/widgets/products/cart/add_remove_button.dart';
import 'package:equips_v2/common/widgets/products/cart/cart_item.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class CheckoutCartItems extends StatelessWidget {
  const CheckoutCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceSections),
        itemCount: 2,
        itemBuilder: (_, index) => Column(
              children: [
                //cart item
                const CartItems(),
                if (showAddRemoveButtons)
                  const SizedBox(
                    height: TSizes.spaceItems,
                  ),

                //add delete button
                if (showAddRemoveButtons)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          //space
                          SizedBox(
                            width: 70,
                          ),
                          //buttons
                          AddRemoveCartItem(),
                        ],
                      ),
                      ProductPriceText(price: '246')
                    ],
                  )
              ],
            ));
  }
}
