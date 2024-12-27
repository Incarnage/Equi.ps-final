import 'package:equips_v2/common/widgets/custom_shapes/container/header_container.dart';
import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/common/widgets/loaders/animation_loader.dart';
import 'package:equips_v2/common/widgets/products%20cart/lessor_vertical_card.dart';
import 'package:equips_v2/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/home_appbar.dart';
import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/lessor/add_product/lessor_add_product.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/helper/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessorHomeScreen extends StatelessWidget {
  const LessorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
        ProductController()); // Ensure controller is already initialized
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderContainer(
              child: Column(
                children: [
                  // AppBar
                  EHomeAppBar(),

                  // Space after categories
                  SizedBox(
                    height: TSizes.spaceSections,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const Text(
                    "Manage your Inventory",
                    style: TextStyle(fontSize: TSizes.fontLarge),
                  ),
                  const SizedBox(
                    height: TSizes.spaceSections,
                  ),
                  FutureBuilder<List<ProductModel>>(
                    future: controller.lessorProduct(),
                    builder: (context, snapshot) {
                      // Loader and empty state widgets
                      final emptyWidget = EAnimatedLoaderWidget(
                        text: 'Your inventory is empty',
                        animation: 'assets/pic/equips-json.json',
                        showAction: true,
                        actionText: 'Let\'s add some',
                        onActionPressed: () => Get.to(() => LessorAddProduct()),
                      );

                      const loader = EVerticalProductShimmer(itemCount: 6);

                      // Check connection state and handle errors
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return loader; // Show loader during fetch
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return emptyWidget; // Show empty widget if no products
                      }

                      // Safely access products and build the grid
                      final products = snapshot.data!;
                      return EGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) {
                          final product = products[index];
                          return LessorVerticalCard(
                            key: ValueKey(product.id),
                            product: product,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
