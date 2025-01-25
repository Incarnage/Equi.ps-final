import 'dart:io';
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
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:google_places_flutter/model/place_details.dart';
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
  final gcashNumber = TextEditingController();
  final userType = ''.obs;
  final validID = ''.obs; // Store the valid ID image path
  final QRCode = ''.obs; // Store the QR Code image path
  final address = TextEditingController();
   final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;


  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  RxBool isSubmitting = false.obs;

Future<void> getLatLongFromAddress() async {
    try {
      if (address.text.isNotEmpty) {
        List<geocoding.Location> locations = await geocoding.locationFromAddress(address.text.trim());
        if (locations.isNotEmpty) {
          latitude.value = locations.first.latitude;
          longitude.value = locations.first.longitude;
        }
      }
    } catch (e) {
      ELoaders.errorSnackBar(
        title: "Location Error",
        message: "Could not get location from address: $e",
      );
    }
  }


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
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        // Only store the file path temporarily
        validID.value = image.path;

        // Notify user of the selection
        ELoaders.successSnackBar(
          title: "Image Selected",
          message: "Your valid ID image has been selected.",
        );
      }
    } catch (e) {
      ELoaders.errorSnackBar(
        title: "Oh, snap!",
        message: "Something went wrong while selecting your ID image: $e",
      );
    }
  }

  // Upload QR Code Image (for Lessor users)
  Future<void> uploadQRCode() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        // Only store the file path temporarily
        QRCode.value = image.path;

        // Notify user of the selection
        ELoaders.successSnackBar(
          title: "Image Selected",
          message: "Your QR code image has been selected.",
        );
      }
    } catch (e) {
      ELoaders.errorSnackBar(
        title: "Oh, snap!",
        message: "Something went wrong while selecting your QR Code image: $e",
      );
    }
  }

  // Sign Up Method
  void signUp() async {
  try {
    isSubmitting.value = true;

    // Check internet connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      EFullScreenLoader.stopLoading();
      isSubmitting.value = false; 
      return;
    }

    // Form Validation
    if (!signupFormKey.currentState!.validate()) {
      isSubmitting.value = false; 
      return;
    }

    // Privacy Policy Check
    if (!termspolicy.value) {
      ELoaders.warningSnackBar(
        title: 'Accept Terms and Conditions',
        message: "Accept the terms and conditions to create an account.",
      );
      isSubmitting.value = false; 
      return;
    }

    // Ensure a valid ID image is selected
    if (validID.value.isEmpty) {
      ELoaders.warningSnackBar(
        title: "Image Required",
        message: "Please upload a valid ID to continue.",
      );
      isSubmitting.value = false; 
      return;
    }
 await getLatLongFromAddress();
    // Upload Valid ID Image
    final validIDUrl = await uploadImage(
      'user_images/validID/',
      XFile(validID.value), // Converting the file path to XFile
    );

    // Upload QR Code Image (only if user is a 'Lessor')
    String qrCodeUrl = '';
    if (userType.value == 'Lessor' && QRCode.value.isNotEmpty) {
      qrCodeUrl = await uploadImage(
        'user_images/QRCode/',
        XFile(QRCode.value),
      );
    }

    // Register the user
    final UserCredential = await AuthenticateRepository.instance
        .registerWithEmailAndPassword(
            email.text.trim(), password.text.trim());

    // Save user data in Firestore
    final newUser = UserModel(
      gmail: '',
      facebook: '',
      instagram: '',
      address: address.text.trim(),
      validID: validIDUrl,
      gcash: qrCodeUrl, // If QRCode is not provided, it will be an empty string
      id: UserCredential.user!.uid,
    
      email: email.text.trim(),
      firstName: firstName.text.trim(),
      lastName: lastName.text.trim(),
      phoneNumber: phoneNumber.text.trim(),
      profilePicture: 'https://firebasestorage.googleapis.com/v0/b/equips-d40b3.appspot.com/o/pictures%2Fprofile-icon.png?alt=media&token=8b804b8d-a5cf-40a1-b4b9-9901416a5bdd', // Add the profile picture URL if available
      userType: userType.value,
      gcashNumber: gcashNumber.text.trim(),
      latitude: latitude.value,
        longitude: longitude.value, // If empty, it won't be stored
    );

    EFullScreenLoader.stopLoading();
    await userRepository.saveUserRecord(newUser);

    // Show success message
    ELoaders.successSnackBar(title: 'Congrats', message: 'Verify your email');

    // Delay the navigation until after the async operations are fully completed
    Future.delayed(Duration(seconds: 1), () {
      // Check if user is authenticated
      if (UserCredential.user != null) {
        // Navigate to verify email screen
        Get.to(() => VerifyEmailScreen(email: email.text.trim()));
      } else {
        ELoaders.errorSnackBar(
            title: "Error", message: "User authentication failed.");
      }
    });
  } catch (e) {
    // Show error message
    ELoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
  } finally {
    isSubmitting.value = false; 
  }
}

}
