import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
              key: controller.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: EValidate.validateEmail,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.direct_right,
                        ),
                        labelText: 'Email'),
                  ),

                  const SizedBox(
                    height: TSizes.spaceInputFields,
                  ),

                  Obx(
                    () => TextFormField(
                      controller: controller.verifyPassword,
                      validator: (value) =>
                          EValidate.validateEmptyText('pass', value),
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                          labelText: ("Password"),
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                                !controller.hidePassword.value,
                            icon: Icon(controller.hidePassword.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceSections,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () =>
                            controller.reAuthenticateEmailandPassUser(),
                        child: const Text('Verify')),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
