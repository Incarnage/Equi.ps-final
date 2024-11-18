import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_repository.dart';
import 'package:equips_v2/lessor/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';

class LessorNotificationScreen extends StatelessWidget {
  const LessorNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OrderRepository());
    Get.lazyPut(() => OrderController());
    final orderController = OrderController.instance;

    // Fetch orders when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderController.fetchAllLessorOrders();
    });

    return Scaffold(
      appBar: TAppbar(
        title: Text(
          'Rental Request',
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
