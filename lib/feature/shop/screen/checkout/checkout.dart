import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/products/cart/coupon_code.dart';
import 'package:equips_v2/common/widgets/success_screen/success_screen.dart';
import 'package:equips_v2/feature/shop/screen/cart/widget/checkout_cart_items.dart';
import 'package:equips_v2/feature/shop/screen/checkout/widget/billing_address_section.dart';
import 'package:equips_v2/feature/shop/screen/checkout/widget/billing_amount_sections.dart';
import 'package:equips_v2/feature/shop/screen/checkout/widget/billing_payment_section.dart';
import 'package:equips_v2/navigation_menu.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
          showBackArrow: true,
          title:
              Text("Cart", style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //items in cart
              CheckoutCartItems(
                showAddRemoveButtons: false,
              ),
              SizedBox(
                height: TSizes.spaceSections,
              ),

              //coupon text
              CouponCode(),

              SizedBox(
                height: TSizes.spaceSections,
              ),

              //billing section

              ERoundedcontainer(
                padding: EdgeInsets.all(TSizes.medium),
                showBorder: true,
                backgroundColor: Colors.white,
                child: Column(
                  children: [
                    //price
                    BillingAmountSection(),
                    SizedBox(
                      height: TSizes.spaceItems,
                    ),

                    //divider
                    Divider(),
                    SizedBox(
                      height: TSizes.spaceItems,
                    ),

                    //payment
                    BillingPaymentSection(),
                    SizedBox(
                      height: TSizes.spaceItems,
                    ),

                    //address
                    BillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      //checkout
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => SuccessScreen(
                  title: 'Payment Success!',
                  subtitle: 'Your item will be shipped soon',
                  onPressed: () => Get.offAll(() => const NavigationMenu()),
                )),
            child: Text('Checkout \$123')),
      ),
    );
  }
}
