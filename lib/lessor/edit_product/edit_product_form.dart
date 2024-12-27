import 'dart:io';

import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';

// In EditProductForm
class EditProductForm extends StatelessWidget {
  const EditProductForm({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    // Pre-fill the form fields with product data
    controller.productName.text = product.productTitle;
    controller.description.text = product.description!;
    controller.price.text = product.price.toString();
    controller.pduration.text = product.pduration.toString();
    controller.category.value = product.categoryId;
    controller.deliveryOption.value = product.delivertOption ?? [];

    return Form(
      key: controller.editProductFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                          child: Text(type,
                              style:
                                  const TextStyle(fontSize: TSizes.fontMedium)),
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
                  labelText: "Please select a category",
                  prefixIcon: Icon(Iconsax.user_tag),
                ),
              )),

          const SizedBox(height: TSizes.spaceInputFields),
          // Product Name
          TextFormField(
            controller: controller.productName,
            style: const TextStyle(fontSize: TSizes.fontMedium),
            validator: (value) =>
                EValidate.validateEmptyText('Product Name', value),
            decoration: const InputDecoration(
              labelText: "Product name",
              prefixIcon: Icon(Iconsax.box),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),
          // Description
          TextFormField(
            controller: controller.description,
            style: const TextStyle(fontSize: TSizes.fontMedium),
            validator: (value) =>
                EValidate.validateEmptyText('Description', value),
            decoration: const InputDecoration(
              labelText: "Description",
              prefixIcon: Icon(Iconsax.document),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),
          // Price
          TextFormField(
            controller: controller.price,
            style: const TextStyle(fontSize: TSizes.fontMedium),
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
            style: const TextStyle(fontSize: TSizes.fontMedium),
            validator: (value) =>
                EValidate.validateEmptyText('Duration', value),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "Duration (in hours)",
              prefixIcon: Icon(Iconsax.clock),
            ),
          ),

          const SizedBox(height: TSizes.spaceInputFields),

          // Delivery Options (Checkboxes)
          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Delivery Option',
                      style: TextStyle(fontSize: TSizes.fontMedium),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        Checkbox(
                          value: controller.deliveryOption.contains('Pick Up'),
                          onChanged: (isSelected) {
                            if (isSelected!) {
                              controller.deliveryOption.add('Pick Up');
                            } else {
                              controller.deliveryOption.remove('Pick Up');
                            }
                          },
                        ),
                        const Text(
                          'Pick Up',
                          style: TextStyle(fontSize: TSizes.fontMedium),
                        ),
                        Checkbox(
                          value: controller.deliveryOption.contains('Deliver'),
                          onChanged: (isSelected) {
                            if (isSelected!) {
                              controller.deliveryOption.add('Deliver');
                            } else {
                              controller.deliveryOption.remove('Deliver');
                            }
                          },
                        ),
                        const Text(
                          'Deliver',
                          style: TextStyle(fontSize: TSizes.fontMedium),
                        ),
                      ],
                    ),
                  ),
                  // Validator for checkboxes
                  Obx(() {
                    return controller.deliveryOption.isEmpty
                        ? const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Please select at least one delivery option',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                            ),
                          )
                        : Container(); // Hide error when options are selected
                  }),
                ],
              )),
          const SizedBox(height: TSizes.spaceInputFields),

          const Divider(),

          const SizedBox(height: TSizes.spaceInputFields),

          // Image Upload
          TextButton(
            onPressed: () => controller.pickImage(),
            child: const Align(
              child: Text("Upload product image",
                  style: TextStyle(
                      color: Color(0xFF25291C), fontSize: TSizes.fontMedium)),
            ),
          ),
          Obx(() {
            if (controller.imageFile.value != null) {
              return Image.file(File(controller.imageFile.value!.path),
                  height: 100);
            } else if (product.thumbnail != null) {
              return Image.network(product.thumbnail,
                  height: 100); // Show existing image
            } else {
              return const Align(
                child: Text("No image selected.",
                    style: TextStyle(fontStyle: FontStyle.italic)),
              );
            }
          }),
          const SizedBox(height: TSizes.spaceItems),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Validate the form and check if delivery options are selected
                if (controller.editProductFormKey.currentState!.validate()) {
                  if (controller.deliveryOption.isEmpty) {
                    // Show error if no delivery option is selected
                    ELoaders.errorSnackBar(
                      title: 'Validation Error',
                      message: 'Please select at least one delivery option',
                    );
                  } else {
                    // Proceed with updating the product
                    controller.updateProduct(product);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25291C),
                  side: const BorderSide(color: Color(0xFF25291C))),
              child: controller.isLoading.value
                  ? const Text('Loading') // Show loading spinner
                  : const Text('Update Product'),
            ),
          ),
        ],
      ),
    );
  }
}
