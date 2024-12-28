import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/profile/profile.dart';
import 'package:equips_v2/lessor/lessor_Navigation_menu.dart';
import 'package:equips_v2/navigation_menu.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocmedController extends GetxController {
  static SocmedController get instance => Get.find();

  final facebook = TextEditingController();
  final instagram = TextEditingController();
  final gmail = TextEditingController();
  final socialsController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeName();
    super.onInit();
  }

  //get user record
  Future<void> initializeName() async {
   
    facebook.text = socialsController.user.value.facebook;
    instagram.text = socialsController.user.value.instagram;
    gmail.text = socialsController.user.value.gmail;
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
        'Facebook': facebook.text.trim(),
        'Instagram': instagram.text.trim(),
        'Gmail': gmail.text.trim()
      };
      await userRepository.updateSingleField(name);

      //update Rx user value

      user.value.facebook = facebook.text.trim();
      user.value.instagram = instagram.text.trim();
      user.value.gmail = gmail.text.trim();

      //remove loader
      EFullScreenLoader.stopLoading();

      //sucess message
      ELoaders.successSnackBar(
          title: 'SAVED!', message: 'Your details have been stored.');

      Get.offAll(() => const LessorNavigationMenu());
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
