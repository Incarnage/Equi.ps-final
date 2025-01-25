import 'dart:io';

import 'package:equips_v2/common/images/e_circular_image.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/address/widgets/address_controller.dart';
import 'package:equips_v2/feature/personalize/screen/settings/gcash_cotroeller.dart';
import 'package:equips_v2/feature/shop/controller/product/images_controller.dart';

import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class GcashSettings extends StatelessWidget {
  const GcashSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GcashCotroeller());

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'GCash Credentials',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: controller.updategcashcredFormKey,
                child: Column(
                  children: [
                    const SizedBox(height: TSizes.spaceInputFields),

                    //address
                    TextFormField(
                      style: const TextStyle(
                          fontSize: TSizes.fontMedium,
                          fontWeight: FontWeight.normal),
                      controller: controller.gcashNumber,
                      validator: (value) =>
                          EValidate.validatePhoneNumber(value),
                      decoration: const InputDecoration(
                        labelText: "GCash Number",
                        prefixIcon: Icon(Iconsax.home),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceInputFields),
                    const Text('Current GCash QR Code:'),

                    Obx(() {
                      final networkImage = controller.currentQRCode.value;
                      final image = (networkImage.isNotEmpty)
                          ? networkImage
                          : 'assets/pic/profile-icon.png';

                      return controller.imageUploading.value
                          ? const ShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : GestureDetector(
                              child: ECircularImage(
                                radius: 1,
                                image: image,
                                width: 300,
                                height: 300,
                                isNetworkImage: networkImage.isNotEmpty,
                              ),
                            );
                    }),
                    const SizedBox(height: TSizes.spaceItems),

                    Obx(
                      () => Column(
                        children: [
                          const Text(
                            "Updated GCash QR Code:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: TSizes.spaceItems),
                          TextButton.icon(
                            style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
              color: Color(0xFF484d3b),
              width: 1,
            ),
          ),
        ),
                            onPressed: () => controller.uploadQRCode(),
                            icon: const Icon(Iconsax.image,
                                color: Color(0xFF484d3b)),
                            label: const Text("Upload Image",
                                style: TextStyle(color: Color(0xFF484d3b))),
                          ),
                          if (controller.QRCode.value.isNotEmpty)
                            Column(
                              children: [
                                // Display preview of the uploaded QR Code
                                Image.file(
                                  File(controller.QRCode.value),
                                  width: 300,
                                  height: 300,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceInputFields),

                    // cp number

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updateUserGcash();
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF25291C)),
                          backgroundColor: const Color(0xFF25291C),
                        ),
                        child: const Text('Update'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
