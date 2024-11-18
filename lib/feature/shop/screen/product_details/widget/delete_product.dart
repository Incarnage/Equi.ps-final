import 'package:equips_v2/data/repository/product/product_repository.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';

import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class EBottomDeleteProduct extends StatelessWidget {
  final ProductModel product;

  const EBottomDeleteProduct({super.key, required this.product});

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
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25291C)),
              onPressed: () =>
                  ProductRepository.instance.removeProductRecord(product.id),
              child: const Text('Delete'))),
    );
  }
}
