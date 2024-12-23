import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/profile/profile.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final streetController = TextEditingController();
    final cityController = TextEditingController();
    final provinceController = TextEditingController();
    final address = TextEditingController();

  final addressController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  GlobalKey<FormState> updateUserAddressFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeAddress();
    super.onInit();
  }

  //get user record
 Future<void> initializeAddress() async {
  try {
    // Get the current user object
    UserModel currentUser = addressController.user.value;

    // Check if the address field exists and is not null
    String? concatenatedAddress = currentUser.address;

    if (concatenatedAddress != null) {
      // Split the address into components
      List<String> addressParts = concatenatedAddress.split(',').map((e) => e.trim()).toList();

      // Assign parts to text controllers
      streetController.text = addressParts.isNotEmpty ? addressParts[0] : '';
      cityController.text = addressParts.length > 1 ? addressParts[1] : '';
      provinceController.text = addressParts.length > 2 ? addressParts[2] : '';
    }
  } catch (e) {
    // Handle errors gracefully
    ELoaders.errorSnackBar(
        title: "Error", message: "Failed to initialize address: $e");
  }
}


  Future<void> updateUserAddress() async {
    try {
      //start loading

      EFullScreenLoader.openLoadingDialog(
          'Currently updating your information', 'assets/pic/loading.json');
//check internet
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      //form validator
      if (!updateUserAddressFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      //update first and last name
      Map<String, dynamic> addressInfo = {
        'address': address.text.trim(),
      };
      await userRepository.updateSingleField(addressInfo);

      //update Rx user value

      user.value.address = address.text.trim();


      //remove loader
      EFullScreenLoader.stopLoading();

      //sucess message
      ELoaders.successSnackBar(
          title: 'SAVED!', message: 'Your details have been stored.');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
