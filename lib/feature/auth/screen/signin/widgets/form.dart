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
              style: const TextStyle(
                  fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
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
                style: const TextStyle(
                    fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
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
                    const Text('Remember Me',
                        style: TextStyle(fontSize: TSizes.fontSmall)),
                  ],
                ),

                // Forget Password
                TextButton(
                    onPressed: () => Get.to(() => const ForgotPassword()),
                    child: const Text("Forgot Password?",
                        style: TextStyle(
                            fontSize: TSizes.fontSmall, color: Color.fromARGB(151, 37, 41, 28))))
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
           TextButton(
                    onPressed: () => Get.to(() => const SignUpLessee()),
                    
                    child: const Text("Create an Account", style:  TextStyle(
                            fontSize: TSizes.fontMedium, color: Color.fromARGB(202, 37, 41, 28),decoration: TextDecoration.underline),)),
            const SizedBox(height: TSizes.spaceSections)
          ],
        ),
      ),
    );
  }
}
