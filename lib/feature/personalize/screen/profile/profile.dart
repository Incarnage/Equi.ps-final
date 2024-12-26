import 'package:equips_v2/common/images/e_circular_image.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/eSectionHeading.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/profile/widgets/profileMenu.dart';
import 'package:equips_v2/feature/personalize/screen/profile/widgets/changename.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppbar(
          showBackArrow: true,
          title: Text(
            "Profile",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: Colors.black),
          )),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
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
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text(
                          "Change Profile Picture",
                          style: TextStyle(color: Color(0xFF25291C)),
                        ))
                  ],
                ),
              ),

              // Details
              const SizedBox(height: TSizes.spaceItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceItems),

              // Heading Profile Info
              const ESectionHeading(
                title: "Profile Information",
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceItems),

              profileMenu(
                  title: "Name",
                  value: controller.user.value.fullName,
                  icon: Iconsax.arrow_right_1,
                  onPressed: () => Get.to(() => const Changename())),
              profileMenu(
                  title: "Username",
                  value: controller.user.value.username,
                  onPressed: () {}),

              const SizedBox(height: TSizes.spaceItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceItems),

              // Heading Personal Info
              ESectionHeading(
                  title: "Personal Information",
                  showActionButton: false,
                  onPressed: () {}),
              const SizedBox(height: TSizes.spaceItems),

              profileMenu(
                  title: "User ID",
                  value: controller.user.value.id,
                  onPressed: () {}),
              profileMenu(
                  title: "Email",
                  value: controller.user.value.email,
                  onPressed: () {}),
              profileMenu(
                  title: "Phone Number",
                  value: controller.user.value.phoneNumber,
                  onPressed: () {}),

              const Divider(),
              const SizedBox(height: TSizes.spaceItems),

              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text("Delete Account",
                        style: TextStyle(color: Colors.red))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
