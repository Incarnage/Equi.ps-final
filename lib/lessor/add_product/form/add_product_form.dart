import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Form(
      key: controller.addProductFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.spaceInputFields),

          // Product Name
          TextFormField(
            controller: controller.productName,
            validator: (value) =>
                EValidate.validateEmptyText('Product Name', value),
            decoration: const InputDecoration(
              labelText: "Product Name",
              prefixIcon: Icon(Iconsax.box),
            ),
          ),

          const SizedBox(height: TSizes.spaceInputFields),

          // Description
          TextFormField(
            controller: controller.description,
            validator: (value) =>
                EValidate.validateEmptyText('Description', value),
            decoration: const InputDecoration(
              labelText: "Description",
              prefixIcon: Icon(Iconsax.document),
              contentPadding: EdgeInsets.only(left: 50),
            ),
          ),

          const SizedBox(height: TSizes.spaceInputFields),

          // Price
          TextFormField(
            controller: controller.price,
            validator: (value) => EValidate.validateEmptyText('Price', value),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "Price",
              prefixIcon: Icon(Iconsax.dollar_square),
            ),
          ),

          const SizedBox(height: TSizes.spaceInputFields),

          // Duration
          TextFormField(
            controller: controller.pduration,
            validator: (value) =>
                EValidate.validateEmptyText('Duration', value),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "Duration (in hours)",
              prefixIcon: Icon(Iconsax.clock),
            ),
          ),

          const SizedBox(height: TSizes.spaceInputFields),

          // Category
          Obx(() => DropdownButtonFormField<String>(
                value: controller.category.value.isEmpty
                    ? null
                    : controller.category.value,
                items: [
                  'Carts',
                  'Chairs',
                  'Decorations',
                  'Kitchenwares',
                  'Lights',
                  'Sound System',
                  'Stage',
                  'Tables',
                  'Tents',
                  'Venue',
                  'Others'
                ]
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.category.value = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Product category",
                  prefixIcon: Icon(Iconsax.user_tag),
                ),
              )),

          const SizedBox(height: TSizes.spaceInputFields),

          // Image Upload
          TextButton(
            onPressed: () => controller.pickImage(),
            child: const Text(
              "Upload product image (max 5)",
              style: TextStyle(color: Color(0xFF25291C)),
            ),
          ),
          Obx(() {
  if (controller.imageFiles.isNotEmpty) {
    return Wrap(
      spacing: 10,
      children: controller.imageFiles
          .map((file) => Image.file(
                File(file.path),
                height: 100,
                width: 100,
              ))
          .toList(),
    );
  } else {
    return const Text(
      "No images selected.",
      style: TextStyle(fontStyle: FontStyle.italic),
    );
  }
}),

          const SizedBox(height: TSizes.spaceItems),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (controller.addProductFormKey.currentState!.validate()) {
                  controller.addProduct();

                  // Reset the form
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25291C),
                  side: const BorderSide(color: Color(0xFF25291C))),
              child: controller.isLoading.value
                  ? const Text('Loading') // Show loading spinner
                  : const Text('Add Product'),
            ),
          ),
        ],
      ),
    );
  }
}
