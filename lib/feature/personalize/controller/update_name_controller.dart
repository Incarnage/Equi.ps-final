import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/profile/profile.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeName();
    super.onInit();
  }

  //get user record
  Future<void> initializeName() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
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
      if (!updateUserNameFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      //update first and last name
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      //update Rx user value

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //remove loader
      EFullScreenLoader.stopLoading();

      //sucess message
      ELoaders.successSnackBar(
          title: 'Congrats', message: 'Your name has been updated');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
