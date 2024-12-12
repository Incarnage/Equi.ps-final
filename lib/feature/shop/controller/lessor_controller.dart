import 'package:equips_v2/data/repository/lessor_repository.dart';
import 'package:equips_v2/data/repository/product/product_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/shop/models/lessor_model.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:get/get.dart';

class LessorController extends GetxController {
  static LessorController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<UserModel> featuredLessors = <UserModel>[].obs;
  final RxList<UserModel> allLessors = <UserModel>[].obs;
  final lessorRepository = Get.put(LessorRepository());

  @override
  void onInit() {
    getAllLessors();
    super.onInit();
  }

  Future<void> getAllLessors() async {
    try {
      isLoading.value = true;

      final lessor = await lessorRepository.getAllLessors();

      allLessors.assignAll(lessor);

      featuredLessors.assignAll(allLessors.take(4));
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getLessorProducts(
      {required String lessorId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsforLessors(lessorId: lessorId, limit: limit);
      return products;
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  Future<List<LessorModel>> getLessorForCategory(String categoryId) async {
    try {
      final lessors = await lessorRepository.getLessorForCategory(categoryId);
      return lessors;
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  List<UserModel> getRandomLessors() {
    try {
      if (allLessors.isEmpty) return []; // Return empty if no lessors
      final randomLessors = List<UserModel>.from(allLessors);
      randomLessors.shuffle();  // Shuffle to get random order
      return randomLessors.take(2).toList(); // Return the first 2 random lessors
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

}
