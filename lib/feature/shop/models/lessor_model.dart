import 'package:cloud_firestore/cloud_firestore.dart';

class LessorModel {
  String image;
  String id;
  String name;
  bool? isFeatured;
  String address;
  String facebook;
  String instagram;
  String gmail;

  LessorModel(
      {required this.id,
      required this.name,
      this.isFeatured,
      required this.image,
      required this.address,
      required this.facebook,
      required this.instagram,
      required this.gmail});

  // Empty Helper Function
  static LessorModel empty() => LessorModel(
      id: '',
      name: '',
      image: '',
      address: '',
      facebook: '',
      instagram: '',
      gmail: '');

  // Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'ID': id,
      'Name': name,
      'IsFeatured': isFeatured,
      'Image': image,
      'Location': address,
      'Facebook': facebook,
      'Instagram': instagram,
      'Gmail': gmail
    };
  }

  // Map Json oriented document snapshot from Firebase to UserModel
  factory LessorModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return LessorModel.empty();
    return LessorModel(
        id: data['ID'] ?? '',
        name: data['Name'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        image: data['Image'] ?? '',
        address: data['Location'] ?? '',
        facebook: data['Facebook'] ?? '',
        instagram: data['Instagram'] ?? '',
        gmail: data['Gmail'] ?? '');
  }

  factory LessorModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return LessorModel(
          id: document.id,
          name: data['Name'] ?? '',
          isFeatured: data['IsFeatured'] ?? false,
          image: data['Image'] ?? '',
          address: data['Location'] ?? '',
          facebook: data['Facebook'] ?? '',
          instagram: data['Instagram'] ?? '',
          gmail: data['Gmail'] ?? '');
    } else {
      return LessorModel.empty();
    }
  }
}
