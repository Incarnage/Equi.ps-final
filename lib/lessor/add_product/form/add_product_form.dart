import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();
    controller.resetForm();
    return Form(
      key: controller.addProductFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TSizes.spaceInputFields),

          // Category
          Obx(() => DropdownButtonFormField<String>(
  dropdownColor: Colors.white,
  value: controller.category.value.isEmpty ? null : controller.category.value,
  items: [
    'Carts', 
    'Chairs', 
    'Costumes', 
    'Decorations', 
    'Kitchenwares', 
    'Lights',
    'Props', 
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
                style: const TextStyle(fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal)),
          ))
      .toList(),
  onChanged: (value) {
    if (value != null) {
      controller.category.value = value; 
    }
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
)
),

          const SizedBox(height: TSizes.spaceInputFields),

          // Product Name
          TextFormField(
            controller: controller.productName,
            style: const TextStyle(fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
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
            style: const TextStyle(fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
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
            style: const TextStyle(fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
            validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Price is required';
  }
  final price = double.tryParse(value);
  if (price == null || price <= 0) {
    return 'Price must be higher than 0';
  }
  return null;
},
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
            style: const TextStyle(fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
           validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Duration is required';
  }
  final duration = int.tryParse(value);
  if (duration == null || duration <= 0) {
    return 'Duration must be higher than 0';
  }
  return null;
},
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "Duration (in hours)",
              prefixIcon: Icon(Iconsax.clock),
            ),
          ),

          const SizedBox(height: TSizes.spaceSections),

          // Delivery Options (Checkboxes)
          Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Delivery Option (Select one or both)',
                      style:  TextStyle(fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
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
                          style:  TextStyle(fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
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
                        const Text('Deliver',
                            style:  TextStyle(fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ],
              )),

          const SizedBox(height: TSizes.spaceInputFields),
          const Divider(),

          const SizedBox(height: TSizes.spaceInputFields),

          // Image Upload
          TextButton(
            onPressed: () => controller.pickImage(),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Upload product image (max 5)",
                style: TextStyle(
                    color: Color(0xFF25291C), fontSize: TSizes.fontMedium),
              ),
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
              return const Align(
                alignment: Alignment.center,
                child: Text(
                  "No images selected.",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              );
            }
          }),

          const SizedBox(height: TSizes.spaceSections),

          // Submit Button
          SizedBox(
  width: double.infinity,
  child: Obx(() => ElevatedButton(
        onPressed: controller.isLoading.value
            ? null // Disable the button when isLoading is true
            : () {
                if (controller.addProductFormKey.currentState!.validate()) {
                  if (controller.deliveryOption.isEmpty) {
                    // Show error if no delivery option is selected
                    ELoaders.errorSnackBar(
                      title: 'Validation Error',
                      message: 'Please select at least one delivery option',
                    );
                  } else {
                    // Proceed with product addition
                    controller.addProduct();
                  }
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.isLoading.value
              ? Colors.grey // Change color when disabled
              : const Color(0xFF25291C),
          side: const BorderSide(color: Color(0xFF25291C)),
        ),
        child: controller.isLoading.value
            ? const CircularProgressIndicator(
                color: Colors.white, // Add a spinner while loading
              )
            : const Text('Add Product'),
      )),
)

        ],
      ),
    );
  }
}
