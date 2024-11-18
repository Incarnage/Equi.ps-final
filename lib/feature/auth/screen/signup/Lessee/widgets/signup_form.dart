import 'package:equips_v2/feature/auth/controller/signUp/signup_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                // First Name
                Expanded(
                    child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      EValidate.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ("First Name"),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                )),
                const SizedBox(width: TSizes.spaceInputFields),

                // LAst name
                Expanded(
                    child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      EValidate.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ("Last Name"),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                )),
              ],
            ),

            const SizedBox(height: TSizes.spaceInputFields),

            // Username
            TextFormField(
              controller: controller.userName,
              validator: (value) =>
                  EValidate.validateEmptyText('Username', value),
              decoration: const InputDecoration(
                labelText: ("Username"),
                prefixIcon: Icon(Iconsax.user_edit),
              ),
            ),

            const SizedBox(height: TSizes.spaceInputFields),

            // Email
            TextFormField(
              controller: controller.email,
              validator: (value) => EValidate.validateEmail(value),
              decoration: const InputDecoration(
                labelText: ("Email"),
                prefixIcon: Icon(Iconsax.direct),
              ),
            ),

            const SizedBox(height: TSizes.spaceInputFields),

            // Phone Number
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => EValidate.validatePhoneNumber(value),
              decoration: const InputDecoration(
                labelText: ("Phone Number"),
                prefixIcon: Icon(Iconsax.call),
              ),
            ),

            const SizedBox(height: TSizes.spaceInputFields),

            // Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => EValidate.validatePass(value),
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
            const SizedBox(height: TSizes.spaceInputFields),
            Obx(
              () => TextFormField(
                validator: (value) {
                  if (value != controller.password.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                obscureText: controller.hidePass.value,
                decoration: InputDecoration(
                    labelText: ("Confirm Password"),
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
            const SizedBox(height: TSizes.spaceInputFields),
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.userType.value.isEmpty
                      ? null
                      : controller.userType.value,
                  items: ['Lessee', 'Lessor']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.userType.value = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a user type';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Select User Type",
                    prefixIcon: Icon(Iconsax.user_tag),
                  ),
                )),

            const SizedBox(height: TSizes.spaceInputFields),

            // Terms and Conditions Check Box
            Row(
              children: [
                SizedBox(
                    width: 24,
                    child: Obx(() => Checkbox(
                        value: controller.termspolicy.value,
                        onChanged: (value) => controller.termspolicy.value =
                            !controller.termspolicy.value))),
                const SizedBox(width: TSizes.spaceItems),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'I Agree To ',
                      style: Theme.of(context).textTheme.bodyMedium),
                  TextSpan(
                      text: 'Privacy Policy ',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: Colors.black,
                          decoration: TextDecoration.underline)),
                  TextSpan(
                      text: '&', style: Theme.of(context).textTheme.bodyMedium),
                  TextSpan(
                      text: ' Terms of Use',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: Colors.black,
                          decoration: TextDecoration.underline)),
                ]))
              ],
            ),
            const SizedBox(
              height: TSizes.spaceItems,
            ),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signUp(),
                  child: const Text('Create Account'),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF25291C)),
                    backgroundColor: const Color(0xFF25291C),
                  )),
            )
          ],
        ));
  }
}
