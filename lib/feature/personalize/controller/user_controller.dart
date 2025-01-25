import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/signup_controller.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/auth/screen/signin/sign_in.dart';
import 'package:equips_v2/feature/personalize/screen/Social-Media/socmed_controller.dart';
import 'package:equips_v2/feature/personalize/screen/profile/widgets/re_auth.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/network/network_manager.dart';
import 'package:equips_v2/utilities/popups/full_screen_loader.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //getchc user record

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetail();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // first, update Rx user and then check if user data is already stored. if not, store new data
      await fetchUserRecord();

      // if no record stored
      if (user.value.id.isEmpty) {
        // convert name to first and last name
        if (userCredentials != null) {
          //convert name to first and last
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          //map the data
          final user = UserModel(
            gmail: SocmedController.instance.gmail.value.toString(),
            facebook: SocmedController.instance.facebook.value.toString(),
            instagram: SocmedController.instance.instagram.value.toString(),
            address: SignupController.instance.address.text,
            validID: userCredentials.user!.photoURL ?? '',
            gcash: userCredentials.user!.photoURL ?? '',
            id: userCredentials.user!.uid,
            username: username,
            email: userCredentials.user!.email ?? '',
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
            userType: SignupController.instance.userType.value ?? '',
            gcashNumber: SignupController.instance.gcashNumber.text ?? '',
            latitude: SignupController.instance.latitude.value,
            longitude: SignupController.instance.longitude.value,
          );
        }
        await userRepository.saveUserRecord(user as UserModel);
      }
    } catch (e) {
      ELoaders.warningSnackBar(
          title: "Data not saved",
          message:
              "Something went wrong while saving your information. You can re-save yur data in your Profile.");
    }
  }

  //delete account waning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.medium),
        title: "Delete Account",
        middleText: "Are you sure you want to delete your account?",
        confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.large),
            child: Text('Delete'),
          ),
        ),
        cancel: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25291C),
              side: const BorderSide(color: const Color(0xFF25291C))),
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  void deleteUserAccount() async {
    try {
      EFullScreenLoader.openLoadingDialog(
          'Processing', 'assets/pic/loading.json');

      final auth = AuthenticateRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'password') {
          EFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailandPassUser() async {
    try {
      EFullScreenLoader.openLoadingDialog(
          'Processing', 'assets/pic/loading.json');

      //check for internet

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        EFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        EFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticateRepository.instance.reAuthenticateWithEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
        await AuthenticateRepository.instance.authUser!.unlink('password');
      EFullScreenLoader.stopLoading();
      Get.offAll(() => const SignInPage());
    } catch (e) {
      EFullScreenLoader.stopLoading();
      ELoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // upload profile picture
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);

      if (image != null) {
        imageUploading.value = true;
        // upload image
        final imageURL =
            await userRepository.uploadImage('Users/Photo/Profile/', image);

        // update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageURL};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageURL;
        user.refresh();

        ELoaders.successSnackBar(
            title: "Congratulations!",
            message: "Your Profile Picture has been updated.");
      }
    } catch (e) {
      ELoaders.errorSnackBar(
          title: "Oh, snap!", message: "Something went wrong!: $e");
    } finally {
      imageUploading.value = false;
    }
  }

  uploadProofofPayment() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);

      if (image != null) {
        imageUploading.value = true;
        // upload image
        final imageURL =
            await userRepository.uploadImage('Users/Payment/', image);

        // update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageURL};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageURL;
        user.refresh();

        ELoaders.successSnackBar(
            title: "Congratulations!",
            message: "Your Profile Picture has been updated.");
      }
    } catch (e) {
      ELoaders.errorSnackBar(
          title: "Oh, snap!", message: "Something went wrong!: $e");
    } finally {
      imageUploading.value = false;
    }
  }
}
