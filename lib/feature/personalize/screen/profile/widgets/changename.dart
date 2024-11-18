import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/personalize/controller/update_name_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Changename extends StatelessWidget {
  const Changename({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please use your real name for easy verification. Your name will be shown on several pages.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: TSizes.spaceSections,
            ),
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) =>
                          EValidate.validateEmptyText('First name', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: 'First Name',
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(
                      height: TSizes.spaceItems,
                    ),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          EValidate.validateEmptyText('Last name', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: 'Last Name',
                          prefixIcon: Icon(Iconsax.user)),
                    )
                  ],
                )),
            const SizedBox(
              height: TSizes.spaceSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25291C),
                      side: const BorderSide(color: Color(0xFF25291C))),
                  onPressed: () => controller.updateUserName(),
                  child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
