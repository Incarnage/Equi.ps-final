import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/common/widgets/products%20cart/vertical_productCard.dart';
import 'package:equips_v2/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:equips_v2/common/widgets/text/section_heading.dart';
import 'package:equips_v2/feature/shop/controller/category_controller.dart';
import 'package:equips_v2/feature/shop/models/category_model.dart';
import 'package:equips_v2/feature/shop/screen/all_products/all_products.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/helper/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ECatergoryTab extends StatelessWidget {
  const ECatergoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //products

              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    final response =
                        ECloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                            loader: const EVerticalProductShimmer());
                    if (response != null) {
                      return response;
                    }

                    final products = snapshot.data!;
                    return Column(
                      children: [
                        SectionHeading(
                          title: 'Featured',
                          onPressed: () => Get.to(AllProducts(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(
                                categoryId: category.id, limit: -1),
                          )),
                        ),
                        const SizedBox(
                          height: TSizes.spaceItems,
                        ),
                        EGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) => VerticalProductCard(
                                  product: products[index],
                                )),
                      ],
                    );
                  }),
            ],
          ),
        )
      ],
    );
  }
}
