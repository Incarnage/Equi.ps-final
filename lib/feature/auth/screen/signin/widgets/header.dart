import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(
          height: 150,
          image: AssetImage('assets/logo/Logo.png'),
        ),
        // Title
        Text('Welcome to Equi.ps!',
            style: Theme.of(context).textTheme.headlineMedium),

        const SizedBox(height: TSizes.small),

        // Subtitle
        Text('One-stop App for Event Properties and Spaces',
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
