import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';
import 'package:equips_v2/lessor/add_product/form/add_product_form.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessorAddProduct extends StatelessWidget {
  const LessorAddProduct({super.key});

  void handleProductSubmission(ProductController controller) {
    // Submit product logic
    controller.addProduct();
    Get.snackbar("Success", "Product added successfully!");
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          "Add Product",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
            left: TSizes.defaultSpace, right: TSizes.defaultSpace),
        child: AddProductForm(),
      ),
    );
  }
}
