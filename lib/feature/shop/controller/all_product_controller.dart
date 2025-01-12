import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/data/repository/product/product_repository.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
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
    getUserLocation(); // Fetch user location on init
  }

  /// Get the user's current location
  Future<void> getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("Location services are disabled.");
        return;
      }

      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        print("Location permission denied.");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      userLatitude.value = position.latitude;
      userLongitude.value = position.longitude;

      print("User Location: ${userLatitude.value}, ${userLongitude.value}");

      // Re-sort products after fetching location
      sortProducts(selectedSortOption.value);
    } catch (e) {
      print("Error getting user location: $e");
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
