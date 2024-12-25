import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_repository.dart';
import 'package:equips_v2/lessor/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrderRepository());
    Get.lazyPut(() => OrderController());
    final orderController = OrderController.instance;

    // Fetch orders when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderController.fetchAllLesseeOrders();
    });

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Rental History',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.black),
        ),
      ),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (orderController.orders.isEmpty) {
          return const Center(child: Text("No orders found."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return OrderCard(order: order);
          },
        );
      }),
    );
  }
}
