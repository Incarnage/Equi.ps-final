import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/auth/screen/signup/Lessee/verify_email.dart';
import 'package:equips_v2/lessor/lessor_Navigation_menu.dart';
import 'package:equips_v2/navigation_menu.dart';
import 'package:equips_v2/utilities/exceptions/authexceptions.dart';
import 'package:equips_v2/feature/auth/screen/signin/sign_in.dart';
import 'package:equips_v2/utilities/local_storage/storage_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticateRepository extends GetxController {
  static AuthenticateRepository get instance => Get.find();

  //variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  //gets the current user data
  User? get authUser => _auth.currentUser;

  //called from main.dart on app launch

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        await ELocalStorage.init(user.uid);
        DocumentSnapshot userSnapshot =
            await _db.collection('Users').doc(user.uid).get();
        String userType = userSnapshot['UserType'];

        if (userType == 'Lessee') {
          Get.offAll(() =>
              const NavigationMenu()); // Redirect to Lessee-specific dashboard or screen
        } else {
          Get.offAll(() =>
              const LessorNavigationMenu()); // Redirect to Lessor-specific dashboard or screen
        }
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      deviceStorage.writeIfNull('isfirsttime', true);
      deviceStorage.read('isfirsttime') != true
          ? Get.offAll(() => const SignInPage())
          : Get.offAll(() => const SignInPage());
    }
    //local storage
  }
//email auth for signin

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Try again';
    }
  }

//email auth for signup

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Try again';
    }
  }

  //email verification
  Future<void> sendEmailVerification() async {
    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Try again';
    }
  }

  //forgot password

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Try again';
    }
  }

  //reauthenticate

  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      //create cred
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      //reauth
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Try again';
    }
  }

  //logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const SignInPage());
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Try again';
    }
  }

  //delete

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Try again';
    }
  }
}
