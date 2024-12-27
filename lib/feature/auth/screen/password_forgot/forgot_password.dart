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
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please enter the e-mail address that you\'ve used to retrieve your account.',
              style: TextStyle(
                  fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
            ),

            const SizedBox(
              height: TSizes.spaceSections,
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25291C),
                      side: const BorderSide(color: Color(0xFF25291C))),
                  onPressed: () => controller.sendPasswordReset(),
                  child: const Text('Submit')),
            )
          ],
        ),
      ),
    );
  }
}
