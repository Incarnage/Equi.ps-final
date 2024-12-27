import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/lessor/edit_product/edit_product_form.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessorEditProduct extends StatelessWidget {
  const LessorEditProduct({super.key, required this.product});
  final ProductModel product;
  void handleProductSubmission(ProductController controller) {
    // Submit product logic
    Get.snackbar("Success", "Product added successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            left: TSizes.defaultSpace, right: TSizes.defaultSpace),
        child: EditProductForm(product: product),
      ),
    );
  }
}
