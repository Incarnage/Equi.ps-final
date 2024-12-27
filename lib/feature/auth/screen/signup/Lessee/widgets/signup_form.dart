import 'dart:io';
import 'package:equips_v2/feature/auth/controller/signUp/signup_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final streetController = TextEditingController();
    final cityController = TextEditingController();
    final provinceController = TextEditingController();

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // First and Last Name Fields
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: const TextStyle(
                      fontSize: TSizes.fontMedium,
                      fontWeight: FontWeight.normal),
                  controller: controller.firstName,
                  validator: (value) =>
                      EValidate.validateEmptyText('First name', value),
                  decoration: const InputDecoration(
                    labelText: "First Name",
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceInputFields),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(
                      fontSize: TSizes.fontMedium,
                      fontWeight: FontWeight.normal),
                  controller: controller.lastName,
                  validator: (value) =>
                      EValidate.validateEmptyText('Last name', value),
                  decoration: const InputDecoration(
                    labelText: "Last Name",
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // Username Field
          TextFormField(
            style: const TextStyle(
                fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
            controller: controller.userName,
            validator: (value) =>
                EValidate.validateEmptyText('Username', value),
            decoration: const InputDecoration(
              labelText: "Username",
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // Address Fields
          TextFormField(
            style: const TextStyle(
                fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
            controller: streetController,
            validator: (value) => EValidate.validateEmptyText('Street', value),
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
                  controller: cityController,
                  validator: (value) =>
                      EValidate.validateEmptyText('City', value),
                  decoration: const InputDecoration(
                    labelText: "City",
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
                  controller: provinceController,
                  validator: (value) =>
                      EValidate.validateEmptyText('Province', value),
                  decoration: const InputDecoration(
                    labelText: "Province",
                    prefixIcon: Icon(Iconsax.map),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // Phone Number Field
          TextFormField(
            style: const TextStyle(
                fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
            controller: controller.phoneNumber,
            validator: (value) => EValidate.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: "Phone Number",
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // Email Field
          TextFormField(
            style: const TextStyle(
                fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
            controller: controller.email,
            validator: (value) => EValidate.validateEmail(value),
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // Password and Confirm Password Fields
          Obx(
            () => TextFormField(
              style: const TextStyle(
                  fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
              controller: controller.password,
              validator: (value) => EValidate.validatePass(value),
              obscureText: controller.hidePass.value,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () =>
                      controller.hidePass.value = !controller.hidePass.value,
                  icon: Icon(controller.hidePass.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),
          Obx(
            () => TextFormField(
              style: const TextStyle(
                  fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
              validator: (value) {
                if (value != controller.password.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              obscureText: controller.hidePass.value,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () =>
                      controller.hidePass.value = !controller.hidePass.value,
                  icon: Icon(controller.hidePass.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // Upload Valid ID Section
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Upload Valid ID:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: TSizes.spaceItems),
                TextButton.icon(
                  onPressed: () => controller.uploadValidID(),
                  icon: const Icon(
                    Iconsax.image,
                    color: Color(0xFF484d3b),
                  ),
                  label: const Text(
                    "Upload Image",
                    style: TextStyle(color: Color(0xFF484d3b)),
                  ),
                ),
                if (controller.validID.value.isNotEmpty)
                  Column(
                    children: [
                      // Display preview of the uploaded image
                      Image.file(
                        File(controller.validID.value),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // User Type Dropdown and QR Code Upload Section (Visible only for 'Lessor')
          Obx(
            () => Column(
              children: [
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: controller.userType.value.isEmpty
                      ? null
                      : controller.userType.value,
                  items: ['Lessee', 'Lessor']
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(
                            type,
                            style: const TextStyle(
                                fontSize: TSizes.fontMedium,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => controller.userType.value = value!,
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
                ),
                const SizedBox(height: TSizes.spaceInputFields),
                if (controller.userType.value == 'Lessor') ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Upload one or both of the following:",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceInputFields),

                  // QR Code Upload Button for 'Lessor'
                  Obx(
                    () => Column(
                      children: [
                        const Text(
                          "Upload QR Code:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: TSizes.spaceItems),
                        TextButton.icon(
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
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Or",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceInputFields),

                  // GCash Number Field for 'Lessor' (Optional)
                  TextFormField(
                    style: const TextStyle(
                        fontSize: TSizes.fontMedium,
                        fontWeight: FontWeight.normal),
                    controller: controller.gcashNumber,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return EValidate.validatePhoneNumber(value);
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Gcash Number",
                      prefixIcon: Icon(Iconsax.call),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.isSubmitting.value
                  ? null // Disable button if submitting
                  : () {
                      // Validate the form before proceeding
                      if (controller.signupFormKey.currentState!.validate()) {
                        // Concatenate address
                        controller.address.text =
                            "${streetController.text}, ${cityController.text}, ${provinceController.text}";

                        // Proceed with the sign-up if the form is valid
                        controller.signUp();
                      } else {
                        // Optional: Display a warning message if form is invalid
                        ELoaders.warningSnackBar(
                          title: "Incomplete Form",
                          message:
                              "Please complete all required fields to create an account.",
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF25291C)),
                backgroundColor: const Color(0xFF25291C),
              ),
              child: controller.isSubmitting.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white),
                    ) // Show loading spinner when submitting
                  : const Text(
                      'Create Account'), // Show text when not submitting
            ),
          )
        ],
      ),
    );
  }
}
