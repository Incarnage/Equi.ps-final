import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/auth/screen/signup/Lessee/widgets/signup_form.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class SignUpLessee extends StatelessWidget {
  const SignUpLessee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(showBackArrow: true, title: Text("Sign Up")),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("You are a step towards easing your rental matters!",
                style: Theme.of(context).textTheme.bodyLarge),

            Text("We require that you input your accurate information.",
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: TSizes.spaceSections * 1.4),

            // Form
            const SignupForm(),
          ],
        ),
      )),
    );
  }
}
