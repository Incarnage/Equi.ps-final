import 'dart:io';
import 'package:equips_v2/feature/auth/controller/signUp/signup_controller.dart';
import 'package:equips_v2/feature/location.dart';
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
          // Address Field with Google Maps Picker
 TextFormField(
            style: const TextStyle(
                fontSize: TSizes.fontMedium, fontWeight: FontWeight.normal),
            controller: controller.address,
            validator: (value) => EValidate.validateEmptyText('Address', value),
            readOnly: true, // Prevent manual typing
            decoration: InputDecoration(
              labelText: "Address",
              prefixIcon: const Icon(Iconsax.location),
              suffixIcon: IconButton(
                icon: const Icon(Iconsax.map),
                onPressed: () async {
                  String? selectedLocation = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationPicker(
                        onLocationSelected: (location) {
                          controller.address.text = location;
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
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
                          "Upload Gcash QR Code:",
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
 Row(
            children: [
              Obx(() => Checkbox(
                    value: controller.termspolicy.value,
                    onChanged: (value) {
                      controller.termspolicy.value = value!;
                    },
                  )),
              const Text("I have read and accept the", style: TextStyle(fontSize: 12),),
              TextButton(
                onPressed: () => _showTermsDialog(context),
                child: const Text(
                  "Terms and Conditions",
                  style: TextStyle(
                      color: Color(0xFF25291C), decoration: TextDecoration.underline, fontSize: 12),
                ),
              ),
            ],
          ),

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
  // Function to show Terms and Conditions dialog
void _showTermsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Terms and Conditions"),
        content: const SingleChildScrollView(
          child: Text(
            '''
1. Acceptance of Terms
By using Equi.ps, you agree to be bound by these Terms and Conditions. If you do not agree, you may not use the Application.

2. Nature of the Application
The Application serves as a platform connecting lessors (item owners) with lessees (renters). The Application does not own, manage, or control any items listed and is not responsible for the conduct of users.

3. User Responsibilities
- Lessors: Ensure that the items listed are accurate, functional, and meet the agreed-upon terms with the lessee.
- Lessees: Inspect items before accepting them and comply with the rental agreement set by the lessor.

4. Liability Disclaimer
- The Application is not responsible for any damages, injuries, disputes, or losses resulting from interactions or transactions between lessors and lessees.
- The Application does not guarantee the quality, safety, legality, or suitability of items rented through the platform.

5. Disputes
All disputes arising between lessors and lessees must be resolved between the parties involved. The Application does not mediate disputes and is not liable for any outcomes.

6. User Conduct
Users agree to:
- Provide accurate and truthful information in their profiles and listings.
- Abide by all applicable laws and regulations in their transactions.
- Refrain from fraudulent or abusive behavior on the platform.

7. Fees and Payments
- The Application may charge service fees for using the platform. These fees are non-refundable unless stated otherwise.
- Payment processing is facilitated through third-party providers. The Application is not responsible for payment disputes.

8. Termination of Use
The Application reserves the right to suspend or terminate any user account for violating these terms or engaging in unlawful activities.

9. Indemnity
Users agree to indemnify and hold harmless the Application, its developers, and affiliates from any claims, losses, damages, or liabilities arising from their use of the platform.

10. Changes to Terms
The Application reserves the right to modify these Terms and Conditions at any time. Continued use of the platform signifies acceptance of the updated terms.

11. Governing Law
These Terms and Conditions shall be governed by the laws of the Philippines. Any disputes will be resolved in the courts of the Philippines.

12. Contact Information
For questions or concerns regarding these Terms and Conditions, please contact mtoledana12@gmail.com.

By using the Application, you acknowledge that the platform is only a facilitator and agree to assume all responsibility for transactions conducted through it.
            ''',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close",style: TextStyle(color: Color(0xFF25291C)),),
          ),
        ],
      );
    },
  );
}

}
