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

  final streetController = TextEditingController();
  final barangayController = TextEditingController();
  final cityController = TextEditingController();
  final address = TextEditingController();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  GlobalKey<FormState> updateUserAddressFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeAddress();
    super.onInit();
  }

  Future<void> initializeAddress() async {
    try {
      var currentUser = await userRepository.fetchUserDetail();

      String? concatenatedAddress = currentUser.address;

      List<String> addressParts =
          concatenatedAddress.split(',').map((e) => e.trim()).toList();

      streetController.text = addressParts.isNotEmpty ? addressParts[0] : '';
      barangayController.text = addressParts.length > 1 ? addressParts[1] : '';
      cityController.text = addressParts.length > 2 ? addressParts[2] : '';
    } catch (e) {
      ELoaders.errorSnackBar(
          title: "Error", message: "Failed to initialize address: $e");
    }
  }

  Future<void> updateUserAddress() async {
    try {
      var currentUser = await userRepository.fetchUserDetail();

      EFullScreenLoader.openLoadingDialog(
          'Currently updating your information', 'assets/pic/loading.json');

      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      if (!updateUserAddressFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> addressInfo = {
        'address': address.text.trim(),
      };
      await userRepository.updateSingleField(addressInfo);

      user.value.address = address.text.trim();

      EFullScreenLoader.stopLoading();

      // Success message
      ELoaders.successSnackBar(
          title: 'SAVED!', message: 'Your details have been stored.');
      print("Redirecting User Type: ${currentUser.userType}");
      // Navigate based on user type
      if (currentUser.userType == 'Lessor') {
        print(currentUser.userType);
        // Redirect to Lessor Navigation Menu if user is a lessor
        Get.off(() => const LessorNavigationMenu());
      } else {
        // Redirect to the main navigation menu for other user types
        Get.off(() => const NavigationMenu());
      }
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
