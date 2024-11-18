import 'package:equips_v2/lessor/widgets/notification_details.dart';
import 'package:flutter/material.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({required this.order, super.key});

  String formatDate(DateTime date) {
    return DateFormat('MMMM/dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(OrderDetails(order: order));
      },
      child: Card(
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
                      .getProductNamebyId(order.productId),
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
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: TSizes.spaceItems / 2),
                        Text(
                          "From: ${formatDate(order.fromDate)}",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          "To: ${formatDate(order.toDate)}",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Status Icon
              Icon(
                order.status == "Pending" ? Icons.pending : Icons.check_circle,
                color: order.status == "Pending" ? Colors.orange : Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
