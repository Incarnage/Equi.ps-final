import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/auth/screen/signup/Lessee/verify_email.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables

  final hidePass = true.obs;
  final termspolicy = true.obs;
  final email = TextEditingController(); // Controller for email input
  final lastName = TextEditingController(); // Controller for last name input
  final userName = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final firstName = TextEditingController(); // Controller for first name input
  final phoneNumber = TextEditingController(); // Controller for phoneNumber i
  final userType = ''.obs; // To hold the selected dropdown value

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Sign Up
  void signUp() async {
    try {
      // Start Loading
      EFullScreenLoader.openLoadingDialog(
          "We are processing your information...", "assets/pic/loading.json");
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        return;
      }

      // Privacy Policy Check
      if (!termspolicy.value) {
        ELoaders.warningSnackBar(
            title: 'Accept Terms and Conditions',
            message:
                "Accept the terms and conditions in order to create and account");
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase

      final UserCredential = await AuthenticateRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        gcash: '',
        id: UserCredential.user!.uid,
        username: userName.text.trim(),
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        userType: userType.value,
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      // Show Success Message

      ELoaders.successSnackBar(title: 'Congrats', message: 'Verify');

      // Move to verify Email Screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      // Show some generic error to the user
      ELoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      // Remove Loader
      EFullScreenLoader.stopLoading();
    }
  }
}
