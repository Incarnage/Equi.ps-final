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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables for form data
  final hidePass = true.obs;
  final termspolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  final userType = ''.obs;
  final validID = ''.obs; // Store the valid ID image path
  final QRCode = ''.obs; // Store the QR Code image path
  final address = TextEditingController();
  final imagePicker = ImagePicker();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Upload Image to Firebase Storage
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

  // Upload Valid ID Image
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

        // Upload Image to Firebase Storage (Pass XFile instead of String)
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

        // Upload Image to Firebase Storage (Pass XFile instead of String)
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

  // Sign Up Method
  void signUp() async {
    try {
      // Start loading dialog
      EFullScreenLoader.openLoadingDialog(
          "We are processing your information...", "assets/pic/loading.json");

      // Check internet connectivity
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
            message: "Accept the terms and conditions in order to create an account");
        return;
      }

      if (validID.value.isEmpty) {
        ELoaders.warningSnackBar(
          title: "Image Required",
          message: "Please upload a valid ID to continue.",
        );
        return;
      }

      // Upload Images to Firebase Storage
      String validIDUrl = await uploadImage(
        'user_images/validID/', 
        XFile(validID.value) // Converting the String (path) to XFile
      );

      String qrCodeUrl = userType.value == 'Lessor' && QRCode.value.isNotEmpty
          ? await uploadImage(
              'user_images/QRCode/', 
              XFile(QRCode.value) // Converting the String (path) to XFile
            )
          : '';

      // Register the user
      final UserCredential = await AuthenticateRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save user data in Firestore
      final newUser = UserModel(
        address: address.text.trim(),
        validID: validIDUrl,
        gcash: qrCodeUrl,
        id: UserCredential.user!.uid,
        username: userName.text.trim(),
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '', // Add the profile picture URL if available
        userType: userType.value,
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show success message
      ELoaders.successSnackBar(title: 'Congrats', message: 'Verify your email');

      // Navigate to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Show error message
      ELoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      // Stop loading dialog
      EFullScreenLoader.stopLoading();
    }
  }
}
