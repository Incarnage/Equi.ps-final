import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userType;
  final String id;
  final String username;
  final String email;
  String address;
  String gcash;
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;
  String validID;
  String gmail;
  String facebook;
  String instagram;
  String gcashNumber;
  double latitude;
  double longitude;

  UserModel(
      {required this.address,
      required this.validID,
      required this.gcash,
      required this.userType,
      required this.id,
      required this.username,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.profilePicture,
      required this.gmail,
      required this.facebook,
      required this.instagram,
      required this.gcashNumber,
      required this.latitude,
      required this.longitude});

  String get fullName => '$firstName $lastName';

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  // Static function to create an empty user model.
  static UserModel empty() => UserModel(
      address: "",
      validID: "",
      gcash: "",
      id: "",
      firstName: "",
      lastName: "",
      username: "",
      email: "",
      phoneNumber: "",
      profilePicture: "",
      userType: "",
      gmail: "",
      instagram: "",
      facebook: "",
      gcashNumber: "",
      latitude: 0.0,
      longitude: 0.0);

  // Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'address': {
        'formatted': address,
        'latitude': latitude,
        'longitude': longitude,
      },
      'validID': validID,
      'Gcash': gcash,
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'UserType': userType,
      'Gmail': gmail,
      'Facebook': facebook,
      'Instagram': instagram,
      'GcashNumber': gcashNumber
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
       address: data['address']?['formatted'] ?? "",
        latitude: data['address']?['latitude'] ?? 0.0,
        longitude: data['address']?['longitude'] ?? 0.0,
        
        validID: data['validID'] ?? "",
        id: document.id,
        firstName: data['FirstName'] ?? "",
        lastName: data['LastName'] ?? "",
        username: data['Username'] ?? "",
        email: data['Email'] ?? "",
        phoneNumber: data['PhoneNumber'] ?? "",
        profilePicture: data['ProfilePicture'] ?? "",
        userType: data['UserType'] ?? "",
        gcash: data['Gcash'] ?? "",
        gmail: data['Gmail'] ?? "",
        instagram: data['Instagram'] ?? "",
        facebook: data['Facebook'] ?? "",
        gcashNumber: data['GcashNumber'] ?? "");
  }
}
