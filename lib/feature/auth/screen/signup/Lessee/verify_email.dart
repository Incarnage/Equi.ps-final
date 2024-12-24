import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/verify_email_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/helper/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticateRepository.instance.logout(),
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //image
              Image(
                image: const AssetImage('assets/logo/Logo.png'),
                width: EHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),

              //title

              Text(
                'Thank you for signing up!',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),
              Text(
                email ?? '',
                style: TextStyle(
                  color: Color(0xFF25291C),
                  fontSize: 18,
                  fontStyle: FontStyle.italic
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),
              Text(
                "Please check your email inbox for the verification link.",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceSections,
              ),

              //button

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
      side: const BorderSide(color: Color(0xFF25291C)),
      backgroundColor: const Color(0xFF25291C),
    ),
                    onPressed: () => () => controller.sendEmailVerification(),
                    child: const Text('Resend Verification Email')),
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}