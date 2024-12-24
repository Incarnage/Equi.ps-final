import 'package:equips_v2/lessor/widgets/notification_details.dart';
import 'package:flutter/material.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final Rx<OrderModel> order;

  OrderCard({required OrderModel order, super.key}) : order = order.obs;

  String formatDate(DateTime date) {
    return DateFormat('MMMM dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderDetails(order: order.value));
      },
      child: Obx((){
        return Card(
        color: const Color(0xFF25291C),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: TSizes.small),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Row(
            children: [
              // Product Image Placeholder
              const SizedBox(width: TSizes.spaceItems),

              // Order Info
              Expanded(
                child: FutureBuilder<ProductModel?>(
                  future: OrderRepository.instance
                      .getProductNamebyId(order.value.productId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading...');
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return const Text('Product not found');
                    }

                    final product = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productTitle, // Display the product name
                          style: const TextStyle(
                              color: Colors.white, fontSize: TSizes.fontLarge),
                        ),
                        const SizedBox(height: TSizes.spaceItems / 2),
                        Text(
                          "FROM: ${formatDate(order.value.fromDate)}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: TSizes.fontSmall,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "TO: ${formatDate(order.value.toDate)}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: TSizes.fontSmall,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Status Icon
              Obx(() {
                return Icon(
                  order.value.status == "Pending"
                      ? Icons.pending
                      : Icons.check_circle,
                  color: order.value.status == "Pending"
                      ? const Color(0xFFFFD233)
                      : Colors.green,
                );
              }),
            ],
          ),
        ),
      );
      })
    );
  }
}
