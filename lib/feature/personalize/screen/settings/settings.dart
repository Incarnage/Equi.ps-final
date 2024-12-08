import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/eSectionHeading.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/header_container.dart';
import 'package:equips_v2/common/widgets/layouts/list_tile/settingsMenu_tile.dart';
import 'package:equips_v2/common/widgets/layouts/list_tile/userProfile_tile.dart';
import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/feature/personalize/screen/address/widgets/address.dart';
import 'package:equips_v2/feature/personalize/screen/profile/profile.dart';
import 'package:equips_v2/feature/shop/screen/cart/cart.dart';
import 'package:equips_v2/feature/shop/screen/order/order.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Future<void> goToWebPage(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            HeaderContainer(
                child: Column(
              children: [
                //appbar
                TAppbar(
                  title: Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: Colors.white),
                  ),
                ),

                //user profile card
                EUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen())),
                const SizedBox(
                  height: TSizes.spaceSections,
                ),
              ],
            )),

            // Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Account Settings
                  ESectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                    onPressed: () {},
                  ),
                  const SizedBox(height: TSizes.spaceItems),

                  // Address
                  ESettingMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My Addresses",
                    subtitle: "Home and Office Addresses",
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),

                  // Shopping Cart
                  ESettingMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subtitle:
                        "Add or remove properties and proceed with checkout",
                    onTap: () => Get.to(() => const CartScreen()),
                  ),

                  // My Orders
                  ESettingMenuTile(
                      icon: Iconsax.bag_tick,
                      title: "My Orders",
                      subtitle:
                          "View In-Progress and Completed Rental Requests",
                      onTap: () => Get.to(() => const OrderScreen())),

                  // Bank
                  const ESettingMenuTile(
                    icon: Iconsax.bank,
                    title: "GCash Details",
                    subtitle: "Update your Account Details",
                  ),

                  // Discount
                  /*const ESettingMenuTile(
                    icon: Iconsax.discount_shape,
                    title: "My Coupons",
                    subtitle: "List of all discounted coupons",
                  ),*/

                  // Notification
                  const ESettingMenuTile(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subtitle: "Check updates for your rental requests!",
                  ),

                  // Security
                  const ESettingMenuTile(
                    icon: Iconsax.security,
                    title: "Account Privacy",
                    subtitle: "Manage Data usage and connected accounts",
                  ),

                  ESettingMenuTile(
                      icon: Iconsax.ticket,
                      title: "Report a problem",
                      subtitle: "Generate a ticket",
                      onTap: () async {
                        await goToWebPage("https://flutter.dev");
                      }),

                  // Logout Button
                  const SizedBox(height: TSizes.spaceSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25291C),
                            side: const BorderSide(color: Color(0xFF25291C))),
                        onPressed: () =>
                            AuthenticateRepository.instance.logout(),
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  const SizedBox(height: TSizes.spaceSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
