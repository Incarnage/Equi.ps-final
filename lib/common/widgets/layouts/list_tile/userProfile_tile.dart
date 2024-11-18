import 'package:equips_v2/common/images/e_circular_image.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EUserProfileTile extends StatelessWidget {
  const EUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty
            ? networkImage
            : 'assets/pic/profile-icon.png';

        return controller.imageUploading.value
            ? const ShimmerEffect(
                width: 80,
                height: 80,
                radius: 80,
              )
            : ECircularImage(
                image: image,
                width: 60,
                height: 60,
                isNetworkImage: networkImage.isNotEmpty);
      }),
      title: Text(controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Colors.white)),
      subtitle: Text(controller.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: Colors.white)),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit),
          color: Colors.white),
    );
  }
}
