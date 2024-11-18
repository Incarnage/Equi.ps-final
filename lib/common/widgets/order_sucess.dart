import 'package:equips_v2/common/images/e_circular_image.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/eSectionHeading.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/profile/widgets/profileMenu.dart';
import 'package:equips_v2/feature/personalize/screen/profile/widgets/changename.dart';
import 'package:equips_v2/navigation_menu.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OrderSucess extends StatelessWidget {
  const OrderSucess({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
                child: SizedBox(
              width: double.infinity,
            )),
            Image.asset('assets/pic/OS.png'),
            const SizedBox(height: TSizes.spaceItems / 2),
            Text(
              'Thank you, ${controller.user.value.firstName}!',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceItems / 2),
            const Text(
              'Kindly wait within 24 hours for the confirmation from your lessor.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceItems),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.off(() => const NavigationMenu()),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25291C),
                    side: const BorderSide(color: Color(0xFF25291C))),
                child: const Text('Back to Home'),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
