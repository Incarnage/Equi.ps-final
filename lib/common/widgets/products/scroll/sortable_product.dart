import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/common/widgets/products%20cart/vertical_productCard.dart';
import 'package:equips_v2/feature/shop/controller/all_product_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SortableProduct extends StatelessWidget {
  const SortableProduct({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Container(
                padding: const EdgeInsets.only(right: 5, bottom: 5),
                child: const Text("Sort Products", textAlign: TextAlign.left)),
          ],
        ),
        const SizedBox(),
        //dropdown
        DropdownButtonFormField(
            style: const TextStyle(
                fontSize: TSizes.fontLarge, color: Color(0xFF25291C)),
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            dropdownColor: Colors.white,
            iconEnabledColor: const Color(0xFF25291C),
            value: controller.selectedSortOption.value,
            onChanged: (value) {
              controller.sortProducts(value!);
            },
            items: [
              'Name',
              'Higher Price',
              'Lower Price',
            ]
                .map((option) =>
                    DropdownMenuItem(value: option, child: Text(option)))
                .toList()),

        const SizedBox(
          height: TSizes.spaceSections,
        ),

        //product

        Obx(
          () => EGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) =>
                  VerticalProductCard(product: controller.products[index])),
        )
      ],
    );
  }
}
