import 'package:equips_v2/feature/auth/controller/signUp/signup_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
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
          //name
          Row(
            children: [
              Expanded(
                child: TextFormField(
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

          // Username
          TextFormField(
            controller: controller.userName,
            validator: (value) => EValidate.validateEmptyText('Username', value),
            decoration: const InputDecoration(
              labelText: "Username",
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          //address
          TextFormField(
            controller: streetController,
            validator: (value) =>
                EValidate.validateEmptyText('Street', value),
            decoration: const InputDecoration(
              labelText: "Street",
              prefixIcon: Icon(Iconsax.home),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),
          Row(children: [
            Expanded(
              child: TextFormField(
              controller: cityController,
              validator: (value) => EValidate.validateEmptyText('City', value),
              decoration: const InputDecoration(
                labelText: "City",
                prefixIcon: Icon(Iconsax.location),
              ),
                            ),
            ),
               const SizedBox(width: TSizes.spaceInputFields),        
          Expanded(
            child: TextFormField(
              controller: provinceController,
              validator: (value) =>
                  EValidate.validateEmptyText('Province', value),
              decoration: const InputDecoration(
                labelText: "Province",
                prefixIcon: Icon(Iconsax.map),
              ),
            ),
          ),
          ],),
          const SizedBox(height: TSizes.spaceInputFields),

          // cp number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => EValidate.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: "Phone Number",
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // email
          TextFormField(
            controller: controller.email,
            validator: (value) => EValidate.validateEmail(value),
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // Password and Confirm Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => EValidate.validatePass(value),
              obscureText: controller.hidePass.value,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePass.value =
                      !controller.hidePass.value,
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
                  onPressed: () => controller.hidePass.value =
                      !controller.hidePass.value,
                  icon: Icon(controller.hidePass.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // Upload Valid ID
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
                  icon: const Icon(Iconsax.image),
                  label: const Text("Upload Image"),
                ),
                if (controller.validID.value.isNotEmpty)
                  Text(
                    "Selected File: ${controller.validID.value}",
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),

          // User Type Dropdown
           Obx(
            () => Column(
              children: [
                DropdownButtonFormField<String>(
                  value: controller.userType.value.isEmpty
                      ? null
                      : controller.userType.value,
                  items: ['Lessee', 'Lessor']
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
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
                if (controller.userType.value == 'Lessor')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Upload QR Code:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: TSizes.spaceItems),
                      TextButton.icon(
                        onPressed: () => controller.uploadQRCode(),
                        icon: const Icon(Iconsax.image),
                        label: const Text("Upload Image"),
                      ),
                      if (controller.QRCode.isNotEmpty)
                        Text(
                          "Selected File: ${controller.QRCode.value}",
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceInputFields),
          

          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                
                controller.address.text =
                    "${streetController.text}, ${cityController.text}, ${provinceController.text}";
                controller.signUp();
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF25291C)),
                backgroundColor: const Color(0xFF25291C),
              ),
              child: const Text('Create Account'),
            ),
          ),
        ],
      ),
    );
  }
}
