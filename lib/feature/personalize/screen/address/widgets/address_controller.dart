import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/profile/profile.dart';
import 'package:equips_v2/feature/personalize/screen/settings/settings.dart';
import 'package:equips_v2/lessor/lessor_Navigation_menu.dart';
import 'package:equips_v2/navigation_menu.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final address = TextEditingController();
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  GlobalKey<FormState> updateUserAddressFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Initialize address asynchronously, delay state changes
    Future.microtask(() => initializeAddress());
  }

  Future<void> initializeAddress() async {
    try {
      // Fetch current user data
      UserModel currentUser = await userRepository.fetchUserDetail();
      user.value = currentUser;

      // Set current address (avoid triggering rebuild during build phase)
      address.text = currentUser.address ?? '';
    } catch (e) {
      ELoaders.errorSnackBar(title: "Error", message: "Failed to initialize address: $e");
    }
  }

  Future<void> updateUserAddress() async {
    try {
      var currentUser = await userRepository.fetchUserDetail();

      // Show loading indicator while performing the update
      EFullScreenLoader.openLoadingDialog('Currently updating your information', 'assets/pic/loading.json');

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      // Validate form before proceeding
      if (!updateUserAddressFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      // Prepare updated address data
      Map<String, dynamic> addressInfo = {
        'address': address.text.trim(),
        'Latitude': latitude.value,
        'Longitude': longitude.value,
      };

      // Update the user address
      await userRepository.updateSingleField(addressInfo);

      // Update local user model
      user.value.address = address.text.trim();
      user.value.latitude = latitude.value;
      user.value.longitude = longitude.value;

      // Stop loading indicator
      EFullScreenLoader.stopLoading();

      // Show success message
      ELoaders.successSnackBar(title: 'SAVED!', message: 'Your details have been stored.');

      // Navigate to the appropriate menu based on user type
      _navigateBasedOnUserType(currentUser);
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  void _navigateBasedOnUserType(UserModel currentUser) {
    // Redirect to different navigation menu based on user type
    if (currentUser.userType == 'Lessor') {
      Get.offAll(() => const LessorNavigationMenu());
    } else {
      Get.offAll(() => const NavigationMenu());
    }
  }
}
