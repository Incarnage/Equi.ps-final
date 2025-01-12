import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/data/repository/product/product_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:get/get.dart';

import 'dart:math';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxDouble userLatitude = 0.0.obs;
  final RxDouble userLongitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserLocation(); 
  }


  Future<void> fetchUserLocation() async {
    try {
      String userId = UserController.instance.user.value.id; 
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();

      if (userDoc.exists) {
        UserModel user = UserModel.fromSnapshot(userDoc as DocumentSnapshot<Map<String, dynamic>>);
        userLatitude.value = user.latitude;
        userLongitude.value = user.longitude;

        print("User Location from Firestore: ${userLatitude.value}, ${userLongitude.value}");

        
        sortProducts(selectedSortOption.value);
      } else {
        print("User not found in Firestore.");
      }
    } catch (e) {
      print("Error fetching user location: $e");
    }
  }
  Future<List<ProductModel>> fetchProductsbyQuery(Query? query) async {
    try {
      if (query == null) return [];
      return await repository.fetchProductsbyQuery(query);
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  /// Sort products by selected option
  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    if (products.isEmpty) return; // Prevent sorting empty list

    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.productTitle.toLowerCase().compareTo(b.productTitle.toLowerCase()));
        break;

      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;

      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;

      case 'Distance (Nearest)':
       if (userLatitude.value != 0.0 && userLongitude.value != 0.0) {
          products.sort((a, b) {
            double distanceA = calculateDistance(userLatitude.value, userLongitude.value, a.latitude, a.longitude);
            double distanceB = calculateDistance(userLatitude.value, userLongitude.value, b.latitude, b.longitude);
            return distanceA.compareTo(distanceB);
          });
        } else {
          print("User location not available. Cannot sort by distance.");
        }
        break;

       case 'Distance (Farthest)':
      if (userLatitude.value != 0.0 && userLongitude.value != 0.0) {
        products.sort((a, b) {
          double distanceA = calculateDistance(userLatitude.value, userLongitude.value, a.latitude, a.longitude);
          double distanceB = calculateDistance(userLatitude.value, userLongitude.value, b.latitude, b.longitude);
          return distanceB.compareTo(distanceA); // Farthest first
        });
      } else {
        print("User location not available. Cannot sort by distance.");
      }
      break;


      default:
        products.sort((a, b) => a.productTitle.toLowerCase().compareTo(b.productTitle.toLowerCase()));
    }
  }

  /// Calculate the distance using the Haversine formula
 double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Radius of the Earth in km
    final dLat = (lat2 - lat1) * pi / 180;
    final dLon = (lon2 - lon1) * pi / 180;
    
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) * cos(lat2 * pi / 180) *
        sin(dLon / 2) * sin(dLon / 2);
    
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in km
  }


  /// Assign products and sort them
  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Name');
  }
}
