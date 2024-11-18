import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SigninController extends GetxController {
  //var
  final rememberMe = false.obs;
  final hidePass = true.obs;
  final lStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();

  //email and pass signin

  Future<void> emailAndPasswordSignin() async {
    try {
      //start loader
      EFullScreenLoader.openLoadingDialog(
          'Logging you in', 'assets/pic/loading.json');

      //check internet

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      //save data if on ang remember me

      if (rememberMe.value) {
        lStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        lStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //login user with email and pass
      final userCredentials = await AuthenticateRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      EFullScreenLoader.stopLoading();

      //redirect
      AuthenticateRepository.instance.screenRedirect();
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(
          title: "Wrong credentials. Check your email or password if correct");
    }
  }
}
