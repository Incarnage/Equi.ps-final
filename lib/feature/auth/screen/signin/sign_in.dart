import 'package:equips_v2/common/styles/spacingStyles.dart';
import 'package:equips_v2/feature/auth/screen/signin/widgets/form.dart';
import 'package:equips_v2/feature/auth/screen/signin/widgets/header.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Logo, Title, Subtitle
              Header(),

              // Form in the Sign In Page
              SignIn_Form(),
            ],
          ),
        ),
      ),
    );
  }
}
