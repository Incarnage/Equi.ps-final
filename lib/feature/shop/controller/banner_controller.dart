import 'package:equips_v2/data/repository/banner/banner_repository.dart';
import 'package:equips_v2/feature/shop/models/banner_model.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  // variables
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
    
  }

  // update page navigational dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  //get the banner
  Future<void> fetchBanners() async {
    try {
      // Show loader while laoding categories
      isLoading.value = true;

      // fetch banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      // assign banners
      this.banners.assignAll(banners);

      // Fetch categories from data source (Firestore, API, etc.)
    } catch (e) {
      ELoaders.errorSnackBar(title: "Oh, snap!", message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }
}
