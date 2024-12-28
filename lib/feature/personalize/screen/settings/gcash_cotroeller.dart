import 'dart:io';

import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/personalize/screen/profile/profile.dart';
import 'package:equips_v2/feature/personalize/screen/settings/settings.dart';
import 'package:equips_v2/lessor/lessor_Navigation_menu.dart';
import 'package:equips_v2/navigation_menu.dart';
import 'package:equips_v2/utilities/exceptions/authexceptions.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GcashCotroeller extends GetxController {
  static GcashCotroeller get instance => Get.find();

  final gcashNumber = TextEditingController();
  final currentQRCode = ''.obs;
   final QRCode = ''.obs;
    final imageUploading = false.obs;

   

 
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  GlobalKey<FormState> updategcashcredFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeGcash();
    super.onInit();
  }

  
 Future<void> initializeGcash() async {
  try {
   
   var currentUser = await userRepository.fetchUserDetail();

      gcashNumber.text = currentUser.gcashNumber;
      currentQRCode.value = currentUser.gcash;
    
  } catch (e) {
  
    ELoaders.errorSnackBar(
        title: "Error", message: "Failed to initialize address: $e");
  }
}
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



 Future<void> updateUserGcash() async {
  try {
    var currentUser = await userRepository.fetchUserDetail();
  
    EFullScreenLoader.openLoadingDialog(
        'Currently updating your information', 'assets/pic/loading.json');

    // Check internet
    final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
      EFullScreenLoader.stopLoading();
      return;
    }

   
    if (!updategcashcredFormKey.currentState!.validate()) {
      EFullScreenLoader.stopLoading();
      return;
    }

  String qrCodeUrl = '';
  qrCodeUrl = await uploadImage(
        'user_images/QRCode/',
        XFile(QRCode.value),
      );

  
    Map<String, dynamic> gcashInfo = {
      'Gcash': qrCodeUrl,
      'GcashNumber': gcashNumber.text.trim(),
    };
    await userRepository.updateSingleField(gcashInfo);

 
    user.value.gcashNumber = gcashNumber.text.trim();

   
    EFullScreenLoader.stopLoading();

    // Success message
    ELoaders.successSnackBar(
        title: 'SAVED!', message: 'Your details have been stored.');

      Get.off(() => const LessorNavigationMenu());
    

  } catch (e) {
    EFullScreenLoader.stopLoading();
    ELoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
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
}
