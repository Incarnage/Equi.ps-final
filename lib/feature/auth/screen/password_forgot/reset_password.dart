import 'package:equips_v2/feature/auth/controller/forgot_pass/forgot_password_controller.dart';
import 'package:equips_v2/feature/auth/screen/signin/sign_in.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/helper/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                image: const AssetImage("assets/logo/Logo.png"),
                width: EHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),

              //title
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                'Change your pass',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),
              Text(
                'Dali na',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),

              //button

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.offAll(() => const SignInPage()),
                    child: const Text('Done')),
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () => ForgotPasswordController.instance
                        .resendPasswordReset(email),
                    child: const Text('Resend')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
