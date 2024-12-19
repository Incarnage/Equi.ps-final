import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/appbar/tabbar.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/eSectionHeading.dart';

import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/common/widgets/brands/lessor_card.dart';
import 'package:equips_v2/common/widgets/shimmer/lessor_shimmer.dart';
import 'package:equips_v2/feature/shop/controller/category_controller.dart';
import 'package:equips_v2/feature/shop/controller/lessor_controller.dart';
import 'package:equips_v2/feature/shop/screen/lessor/all_lessor.dart';
import 'package:equips_v2/feature/shop/screen/lessor/lessor_products.dart';
import 'package:equips_v2/feature/shop/screen/store/widget/category_tab.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    final lessorController = Get.put(LessorController());
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppbar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading:
                      false, // to make back arrow invisible
                  pinned: true, // design will not move once body is moving
                  floating: true,
                  backgroundColor: const Color(0xFF25291C),
                  expandedHeight: 250,

                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // for it to not scroll
                      children: [
                        // Feature Brands
                        ESectionHeading(
                          onPressed: () => Get.to(() => const AllLessors()),
                          title: "Featured Lessors",
                          textColor: Colors.white,
                        ),
                        const SizedBox(height: TSizes.spaceItems / 1.5),

                        // Lessor Cards
                        Obx(() {
                          if (lessorController.isLoading.value) {
                            return const LessorShimmer();
                          }

                          // Get two random lessors from the entire list
                          final randomLessors =
                              lessorController.getRandomLessors();

                          if (randomLessors.isEmpty) {
                            return const Center(
                              child: Text('No Lessors Available',
                                  style: TextStyle(color: Colors.red)),
                            );
                          }

                          return EGridLayout(
                            itemCount:
                                randomLessors.length, // This will always be 2
                            mainAxisExtent: 80, // Element height
                            itemBuilder: (_, index) {
                              final lessor = randomLessors[index];
                              return ELessorCard(
                                onTap: () => Get.to(
                                    () => LessorProducts(lessor: lessor)),
                                showBorder: true,
                                lessor: lessor,
                              );
                            },
                          );
                        })
                      ],
                    ),
                  ),
                  bottom: ETabBar(
                      tabs: categories
                          .map((category) => Tab(
                                child: Text(category.name),
                              ))
                          .toList()),
                )
              ];
            },
            body: TabBarView(
                children: categories
                    .map((category) => ECatergoryTab(category: category))
                    .toList())),
      ),
    );
  }
}
