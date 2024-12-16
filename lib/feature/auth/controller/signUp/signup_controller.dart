import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/auth/screen/signup/Lessee/verify_email.dart';
import 'package:equips_v2/utilities/exceptions/authexceptions.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  final userType = ''.obs; // Controller dropdown value
  final QRCode = ''.obs; //Controller for QR Code
  final validID = ''.obs; //Controller for ID of the user
  final address = TextEditingController();
  final imagePicker = ImagePicker();

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

      if ( validID.value.isEmpty) {
        ELoaders.warningSnackBar(
          title: "Image Required",
          message: "Please upload a Valid ID to continue.",
        );
        return;
      }

      if (userType.value == "Lessor" && QRCode.value.isEmpty) {
        ELoaders.warningSnackBar(
          title: "Image Required",
          message: "Please upload an image to continue.",
        );
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase

      final UserCredential = await AuthenticateRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        address: address.text.trim(),
        validID: validID.value,
        gcash: QRCode.value,
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

     

      // Move to verify Email Screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      // Show some generic error to the user
      ELoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } 
  }



Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Try Again";
    }
  }

   Future<void> uploadValidID() async {
    try {
      final image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        validID.value = image.path;

        // Upload Image to Firebase Storage
        final imageURL = await uploadImage('user_images/validID/', image);

        // Optionally, update Firestore with the image URL (if needed)
        Map<String, dynamic> json = {'validID': imageURL};
        await FirebaseFirestore.instance.collection('users').doc('your_user_doc_id').update(json);

        ELoaders.successSnackBar(
            title: "Image Uploaded",
            message: "Your Valid ID has been uploaded successfully.");
      }
    } catch (e) {
      ELoaders.errorSnackBar(
          title: "Oh, snap!", message: "Something went wrong while uploading your ID image: $e");
    }
  }

  // Upload QR Code Image (for Lessor users)
  Future<void> uploadQRCode() async {
    try {
      final image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        QRCode.value = image.path;

        // Upload Image to Firebase Storage
        final imageURL = await uploadImage('user_images/QRCode/', image);

        // Optionally, update Firestore with the image URL (if needed)
        Map<String, dynamic> json = {'QRCode': imageURL};
        await FirebaseFirestore.instance.collection('users').doc('your_user_doc_id').update(json);

        ELoaders.successSnackBar(
            title: "Image Uploaded",
            message: "Your QR Code has been uploaded successfully.");
      }
    } catch (e) {
      ELoaders.errorSnackBar(
          title: "Oh, snap!", message: "Something went wrong while uploading your QR Code image: $e");
    }
  }
}
