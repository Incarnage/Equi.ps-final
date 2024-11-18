import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/feature/auth/screen/password_forgot/reset_password.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  //var
  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  //send reset pass
  sendPasswordReset() async {
    try {
      //start loading
      EFullScreenLoader.openLoadingDialog(
          'Processing Request', 'assets/pic/loading.json');

      //check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      //form validation

      if (!forgotPasswordFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }
      //send email
      await AuthenticateRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      //remove loader
      EFullScreenLoader.stopLoading();

      //success screen

      ELoaders.successSnackBar(
          title: 'Email Sent',
          message: 'An email was send to reset your password'.tr);
      //redirect
      Get.to(() => ResetPassword(
            email: email.text.trim(),
          ));
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: "Oh No!", message: e.toString());
    }
  }

  resendPasswordReset(String email) async {
    try {
      //start loading
      EFullScreenLoader.openLoadingDialog(
          'Processing Request', 'assets/pic/loading.json');

      //check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      //send email
      await AuthenticateRepository.instance.sendPasswordResetEmail(email);

      //remove loader
      EFullScreenLoader.stopLoading();

      //success screen

      ELoaders.successSnackBar(
          title: 'Email Sent',
          message: 'An email was send to reset your password'.tr);
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.errorSnackBar(title: "Hala", message: e.toString());
    }
  }
}
