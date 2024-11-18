import 'package:equips_v2/common/widgets/custom_shapes/container/eSectionHeading.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/header_container.dart';

import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/common/widgets/products%20cart/vertical_productCard.dart';
import 'package:equips_v2/common/widgets/shimmer/vertical_product_shimmer.dart';

import 'package:equips_v2/common/widgets/text/section_heading.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/home_appbar.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/home_categories.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/promo_slider.dart';
import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';
import 'package:equips_v2/feature/shop/screen/all_products/all_products.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  SizedBox(
                    height: TSizes.spaceInputFields / 2,
                  ),

                  Divider(),
                  SizedBox(
                    height: TSizes.spaceItems,
                  ),

                  //home categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        //heading
                        SectionHeading(
                          title: "What to Rent?",
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceItems,
                        ),
                        //categories
                        HomeCategories()
                      ],
                    ),
                  ),
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
                    const EPromoSlider(),
                    const SizedBox(height: TSizes.spaceSections),

                    // Heading
                    ESectionHeading(
                        title: "Most Searched",
                        onPressed: () => Get.to(() => AllProducts(
                              title: 'Most Searched',
                              futureMethod:
                                  controller.fetchAllFeaturedProducts(),
                            ))),
                    const SizedBox(height: TSizes.spaceSections),

                    Obx(() {
                      if (controller.isLoading.value) {
                        return const EVerticalProductShimmer();
                      }

                      if (controller.featuredProducts.isEmpty) {
                        return const Center(
                          child: Text('No Data Found!'),
                        );
                      }
                      return EGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => VerticalProductCard(
                              product: controller.featuredProducts[index]));
                    }),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
