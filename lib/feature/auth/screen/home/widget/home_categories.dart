import 'package:equips_v2/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:equips_v2/common/widgets/shimmer/category_shimmer.dart';
import 'package:equips_v2/feature/shop/controller/category_controller.dart';
import 'package:equips_v2/feature/shop/screen/all_products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final controller = CategoryController.instance;

    return Obx(() {
      if (categoryController.isLoading.value) return const CategoryShimmer();
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
            child: Text("No Data Found!",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Colors.white)));
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return VerticalImageText(
                image: category.image,
                title: category.name,
                onTap: () => Get.to(AllProducts(
                  title: category.name,
                  futureMethod: controller.getCategoryProducts(
                      categoryId: category.id, limit: -1),
                )),
              );
            }),
      );
    });
  }
}
