import 'package:equips_v2/data/repository/categories/category_repository.dart';
import 'package:equips_v2/data/repository/product/product_repository.dart';
import 'package:equips_v2/feature/shop/models/category_model.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // Load Category Data
  Future<void> fetchCategories() async {
    try {
      // Show loader while laoding categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, etc.)
      final categories = await _categoryRepository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured)
          .take(8)
          .toList());
    } catch (e) {
      ELoaders.errorSnackBar(title: "Oh, snap!", message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }

  // Load selected category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      ELoaders.errorSnackBar(title: "Oh, snap!", message: e.toString());
      return [];
    }
  }

  // Get category or sub category products
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsByCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      ELoaders.errorSnackBar(title: "Oh, snap!", message: e.toString());
      return [];
    }
  }
}
