import 'package:equips_v2/feature/auth/screen/home/lessor_home.dart';
import 'package:equips_v2/feature/chat/chat.dart';
import 'package:equips_v2/feature/chat/chat_menu.dart';
import 'package:equips_v2/feature/chat/chat_menu_lessor.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/settings/settings.dart';
import 'package:equips_v2/lessor/add_product/form/add_product_form.dart';
import 'package:equips_v2/lessor/add_product/lessor_add_product.dart';
import 'package:equips_v2/lessor/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LessorNavigationMenu extends StatelessWidget {
  const LessorNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: Colors.grey,
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Products'),
            NavigationDestination(icon: Icon(Iconsax.message), label: 'Chat'),
            NavigationDestination(
                icon: Icon(Iconsax.notification), label: 'Notifications'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}


class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const LessorHomeScreen(),
    const LessorAddProduct(),
     ChatNavigationLessor(),  
    const LessorNotificationScreen(),
    const SettingScreen(),
  ];
}
