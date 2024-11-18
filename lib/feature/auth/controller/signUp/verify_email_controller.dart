import 'dart:async';

import 'package:equips_v2/common/widgets/success_screen/success_screen.dart';
import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // send email pag nag appear ang verify screen tapos timer for redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerforRedirect();
    super.onInit();
  }

  //send email
  sendEmailVerification() async {
    try {
      await AuthenticateRepository.instance.sendEmailVerification();
      ELoaders.successSnackBar(title: 'Email sent');
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh no', message: e.toString());
    }
  }

  //timer

  setTimerforRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
              title: 'Account Created',
              subtitle: 'Thanks',
              onPressed: () => AuthenticateRepository.instance.screenRedirect(),
            ));
      }
    });
  }

  //check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
            title: 'Account Created',
            subtitle: 'Thanks',
            onPressed: () => AuthenticateRepository.instance.screenRedirect(),
          ));
    }
  }
}
