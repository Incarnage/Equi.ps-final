import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/shop/screen/order/widget/order_list.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF25291C),
      //appbar
      appBar: TAppbar(
        showBackArrow: false,
        title: Text(
          'My Order',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        //order
        child: OrderListItems(),
      ),
    );
  }
}
