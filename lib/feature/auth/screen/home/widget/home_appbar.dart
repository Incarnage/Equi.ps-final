import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHomeAppBar extends StatelessWidget {
  const EHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ease the Rental!",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: Colors.white)),
          Obx(() {
            if (controller.profileLoading.value) {
              return const ShimmerEffect(width: 80, height: 15);
            } else {
              return Text(controller.user.value.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: Colors.white));
            }
          }),
        ],
      ),
    );
  }
}
