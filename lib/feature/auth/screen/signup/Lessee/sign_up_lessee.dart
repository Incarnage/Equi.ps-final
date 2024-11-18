import 'package:equips_v2/feature/auth/screen/signup/Lessee/widgets/signup_form.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class SignUpLessee extends StatelessWidget {
  const SignUpLessee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text("Sign Up", style: Theme.of(context).textTheme.headlineMedium),
            Text("You are a step towards easing rental matters!",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: TSizes.spaceSections),

            // Form
            const SignupForm(),
          ],
        ),
      )),
    );
  }
}
