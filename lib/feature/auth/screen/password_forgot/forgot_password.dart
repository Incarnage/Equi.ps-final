import 'package:equips_v2/feature/auth/controller/forgot_pass/forgot_password_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //heading
            Text(
              'Forgot Password',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spaceItems,
            ),

            Text(
              'Please enter the e-mail address that you\'ve used to your account',
              style: Theme.of(context).textTheme.labelMedium,
            ),

            const SizedBox(
              height: TSizes.spaceSections * 2,
            ),
            //Text field
            Form(
              key: controller.forgotPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: EValidate.validateEmail,
                decoration: const InputDecoration(
                    labelText: "Email", prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceSections,
            ),

            //submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.sendPasswordReset(),
                  child: const Text('Submit')),
            )
          ],
        ),
      ),
    );
  }
}
