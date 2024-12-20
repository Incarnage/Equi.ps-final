import 'package:equips_v2/data/repository/product/product_repository.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/edit_product.dart';
import 'package:equips_v2/lessor/edit_product/edit_product.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EBottomEditDeleteProduct extends StatelessWidget {
  final ProductModel product;
  

  const EBottomEditDeleteProduct({
    super.key,
    required this.product,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(TSizes.cardRaidusLarge),
              topRight: Radius.circular(TSizes.cardRaidusLarge))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Edit Button
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF25291C)),
                  backgroundColor: const Color(0xFF25291C)),
              onPressed: () {
                Get.to(() => LessorEditProduct(product: product,));
              },
              child: const Text('Edit'),
            ),
          ),

          const SizedBox(
            width: TSizes.defaultSpace,
          ),
          // Delete Button
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF25291C)),
                  backgroundColor: const Color(0xFF25291C)),
              onPressed: () => ProductRepository.instance.removeProductRecord(product.id),
              child: const Text('Delete'),
            ),
          ),
        ],
      ),
    );
  }
}
