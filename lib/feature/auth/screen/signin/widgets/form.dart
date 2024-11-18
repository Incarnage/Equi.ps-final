import 'package:equips_v2/feature/auth/controller/signin/signin_controller.dart';
import 'package:equips_v2/feature/auth/screen/password_forgot/forgot_password.dart';
import 'package:equips_v2/feature/auth/screen/signup/Lessee/sign_up_lessee.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignIn_Form extends StatelessWidget {
  const SignIn_Form({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SigninController());

    return Form(
      key: controller.signinFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.email,
              validator: (value) => EValidate.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: ('E-mail'),
              ),
            ),

            // Add small space
            const SizedBox(height: TSizes.spaceInputFields),

            // Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    EValidate.validateEmptyText('pass', value),
                obscureText: controller.hidePass.value,
                decoration: InputDecoration(
                    labelText: ("Password"),
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePass.value =
                          !controller.hidePass.value,
                      icon: Icon(controller.hidePass.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye),
                    )),
              ),
            ),

            // Add small space
            const SizedBox(height: TSizes.spaceInputFields / 2),

            // Remember Me and Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember Me
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value)),
                    const Text('Remember Me'),
                  ],
                ),

                // Forget Password
                TextButton(
                    onPressed: () => Get.to(() => const ForgotPassword()),
                    child: Text("Forgot Password",
                        style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
            const SizedBox(height: TSizes.spaceSections),

            // Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.emailAndPasswordSignin(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25291C),
                        side: const BorderSide(
                          color: Color(0xFF25291C),
                        )),
                    child: const Text("Sign In"))),

            const SizedBox(height: TSizes.spaceItems),

            // Create Account Button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignUpLessee()),
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                      color: Color(0xFF25291C),
                    )),
                    child: const Text("Create an Account"))),
            const SizedBox(height: TSizes.spaceSections)
          ],
        ),
      ),
    );
  }
}
