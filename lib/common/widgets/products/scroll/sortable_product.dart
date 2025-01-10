import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:equips_v2/feature/shop/controller/all_product_controller.dart';
import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/common/widgets/products%20cart/vertical_productCard.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';

class SortableProduct extends StatefulWidget {
  const SortableProduct({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  _SortableProductState createState() => _SortableProductState();
}

class _SortableProductState extends State<SortableProduct> {
  final controller = Get.put(AllProductController());

  @override
  void initState() {
    super.initState();
    controller.getUserLocation(); // Get user's location when the screen is initialized
  }

 
 

  @override
  Widget build(BuildContext context) {
    controller.assignProducts(widget.products);

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              padding: const EdgeInsets.only(right: 10, bottom: 5),
              child: const Text("Sort Products", textAlign: TextAlign.left),
            ),
          ],
        ),
        const SizedBox(),
        // Dropdown for sorting options
        SizedBox(
          width: 350,
          child: DropdownButtonFormField(
            style: const TextStyle(
              fontSize: TSizes.fontLarge,
              color: Color(0xFF25291C),
            ),
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
              'Distance (Nearest)', 
            ]
                .map((option) =>
                    DropdownMenuItem(value: option, child: Text(option)))
                .toList(),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceSections,
        ),
        // Products grid
        Obx(
          () => EGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                VerticalProductCard(product: controller.products[index]),
          ),
        ),
      ],
    );
  }
}
