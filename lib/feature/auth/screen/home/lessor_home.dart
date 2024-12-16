import 'package:equips_v2/common/widgets/custom_shapes/container/header_container.dart';

import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/common/widgets/loaders/animation_loader.dart';
import 'package:equips_v2/common/widgets/products%20cart/lessor_vertical_card.dart';
import 'package:equips_v2/common/widgets/shimmer/vertical_product_shimmer.dart';

import 'package:equips_v2/feature/auth/screen/home/widget/home_appbar.dart';
import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';
import 'package:equips_v2/lessor/add_product/lessor_add_product.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/helper/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessorHomeScreen extends StatelessWidget {
  const LessorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderContainer(
              child: Column(
                children: [
                  //appbar
                  EHomeAppBar(),

                  //home categories

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
                    FutureBuilder(
                        future: controller.lessorProduct(),
                        builder: (context, snapshot) {
                          final emptyWidget = EAnimatedLoaderWidget(
                            text: 'Wishlist is empty',
                            animation: 'assets/pic/equips-json.json',
                            showAction: true,
                            actionText: 'Let\'s add some',
                            onActionPressed: () =>
                                Get.to(() => const LessorAddProduct()),
                          );

                          const loader = EVerticalProductShimmer(itemCount: 6);
                          final widget =
                              ECloudHelperFunctions.checkMultiRecordState(
                                  snapshot: snapshot,
                                  loader: loader,
                                  nothingFound: emptyWidget);

                          if (widget != null) {
                            return widget;
                          }

                          final products = snapshot.data!;

                          return EGridLayout(
                              itemCount: products.length,
                              itemBuilder: (_, index) => LessorVerticalCard(
                                    product: products[index],
                                  ));
                        }),

                    // EGridLayout(
                    //       itemCount: controller.lessorProducts.length,
                    //       itemBuilder: (_, index) => VerticalProductCard(
                    //           product: controller.lessorProducts[index]));
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
