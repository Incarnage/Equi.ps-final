import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/feature/auth/controller/signin/signin_controller.dart';
import 'package:equips_v2/feature/auth/screen/home/home.dart';
import 'package:equips_v2/feature/chat/chat.dart';
import 'package:equips_v2/feature/chat/chat_menu.dart';
import 'package:equips_v2/feature/personalize/screen/settings/settings.dart';

import 'package:equips_v2/feature/shop/screen/store/store.dart';
import 'package:equips_v2/feature/shop/screen/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

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
              NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
              NavigationDestination(icon: Icon(Iconsax.message), label: 'Chat'),
              NavigationDestination(
                  icon: Icon(Iconsax.bookmark), label: 'Saved'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            ],
          ),
        ),
        body: Obx(
          () => controller.screens[controller.selectedIndex.value],
        ));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  
  

  late final screens = [
    const HomeScreen(),
    const Store(),
     ChatNavigation(), // Pass userId here
    const Wishlist(),
    const SettingScreen(),
  ];

 
}

