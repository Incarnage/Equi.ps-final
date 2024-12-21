import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/data/repository/authenticate_repository.dart';
import 'package:equips_v2/utilities/exceptions/authexceptions.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //save user data to firestore

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

  //get user data based on user ID

  Future<UserModel> fetchUserDetail() async {
    try {
      final docSnapshot = await _db
          .collection("Users")
          .doc(AuthenticateRepository.instance.authUser?.uid)
          .get();

      if (docSnapshot.exists) {
        return UserModel.fromSnapshot(docSnapshot);
      } else {
        return UserModel.empty();
      }
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

  Future<String> getLesseeName(String lesseeId) async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(lesseeId)
        .get();

    if (docSnapshot.exists) {
      return docSnapshot[
          'FirstName']; // Assuming 'name' is the field that holds the lessee's name
    } else {
      throw Exception("Lessee not found");
    }
  }

  Future<Map<String, String>> getLessorSocMed(String lessorId) async {
  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(lessorId)
      .get();

  if (docSnapshot.exists) {
    return {
      'Facebook': docSnapshot['Facebook'] ?? 'Not available',
      'Instagram': docSnapshot['Instagram'] ?? 'Not available',
      'Gmail': docSnapshot['Gmail'] ?? 'Not available',
    };
  } else {
    throw Exception("Lessor not found");
  }
}


  

  //update firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
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

  //update field
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticateRepository.instance.authUser?.uid)
          .update(json);
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

  //delete user data

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
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

  // upload any image
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

  Future<List<UserModel>> getAllLessors() async {
    try {
      final snapshot = await _db
          .collection('Users')
          .where('UserType', isEqualTo: "Lessor")
          .get();
      return snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}
