import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/address/widgets/address_controller.dart';

import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Address',
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
                key: controller.updateUserAddressFormKey,
                child: Column(
                  children: [
                    const SizedBox(height: TSizes.spaceInputFields),

                    // Username

                    //address
                    TextFormField(
                      style: const TextStyle(
                          fontSize: TSizes.fontMedium,
                          fontWeight: FontWeight.normal),
                      controller: controller.streetController,
                      validator: (value) =>
                          EValidate.validateEmptyText('Street', value),
                      decoration: const InputDecoration(
                        labelText: "Street",
                        prefixIcon: Icon(Iconsax.home),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceInputFields),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: TSizes.fontMedium,
                                fontWeight: FontWeight.normal),
                            controller: controller.barangayController,
                            validator: (value) =>
                                EValidate.validateEmptyText('Barangay', value),
                            decoration: const InputDecoration(
                              labelText: "Barangay",
                              prefixIcon: Icon(Iconsax.location),
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceInputFields),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: TSizes.fontMedium,
                                fontWeight: FontWeight.normal),
                            controller: controller.cityController,
                            validator: (value) =>
                                EValidate.validateEmptyText('City', value),
                            decoration: const InputDecoration(
                              labelText: "City",
                              prefixIcon: Icon(Iconsax.map),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceSections),

                    // cp number

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.address.text =
                              "${controller.streetController.text}, ${controller.cityController.text}, ${controller.cityController.text}";
                          controller.updateUserAddress();
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF25291C)),
                          backgroundColor: const Color(0xFF25291C),
                        ),
                        child: const Text('Update Address'),
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
