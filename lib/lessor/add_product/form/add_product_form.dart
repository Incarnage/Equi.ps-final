import 'dart:io';

import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/shop/controller/product/product_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          'Add Products',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            key: controller.addProductFormKey,
            child: Column(
              children: [
                const SizedBox(height: TSizes.spaceInputFields),
                // Product Name
                TextFormField(
                  controller: controller.productName,
                  validator: (value) =>
                      EValidate.validateEmptyText('Product Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ("Product Name"),
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
                    labelText: ("Description"),
                    prefixIcon: Icon(Iconsax.document),
                  ),
                ),

                const SizedBox(height: TSizes.spaceInputFields),

                // Price
                TextFormField(
                  validator: (value) =>
                      EValidate.validateEmptyText('Price', value),
                  controller: controller.price,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: ("Price"),
                    prefixIcon: Icon(Iconsax.dollar_square),
                  ),
                ),

                const SizedBox(height: TSizes.spaceInputFields),

                // Duration
                TextFormField(
                  validator: (value) =>
                      EValidate.validateEmptyText('Duration', value),
                  controller: controller.price,
                  decoration: const InputDecoration(
                    labelText: ("Duration"),
                    prefixIcon: Icon(Iconsax.clock),
                  ),
                ),

                const SizedBox(height: TSizes.spaceInputFields),

                // Password
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
                          return 'Please category';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Select product category",
                        prefixIcon: Icon(Iconsax.user_tag),
                      ),
                    )),
                const SizedBox(height: TSizes.spaceInputFields),

                TextButton(
                    onPressed: () => controller.pickImage(),
                    child: const Text(
                      "Upload product image",
                      style: TextStyle(color: Color(0xFF25291C)),
                    )),
                Obx(() {
                  if (controller.imageFile.value != null) {
                    return Image.file(
                      File(controller.imageFile.value!.path),
                      height: 100,
                    );
                  } else {
                    return const Text("No image selected.",
                        style: TextStyle(fontStyle: FontStyle.italic));
                    // Theme.of(context).textTheme.labelMedium.);
                  }
                }),

                // Terms and Conditions Check Box

                const SizedBox(
                  height: TSizes.spaceItems,
                ),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addProduct(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25291C),
                        side: const BorderSide(color: Color(0xFF25291C))),
                    child: const Text('Add Product'),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
