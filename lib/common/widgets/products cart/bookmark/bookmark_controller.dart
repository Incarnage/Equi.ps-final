import 'dart:convert';
import 'package:equips_v2/data/repository/product/product_repository.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/local_storage/storage_util.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkController extends GetxController {
  static BookmarkController get instance => Get.find();

  final bookmarks = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initBookmark();
  }

  void initBookmark() {
    final json = ELocalStorage.instance().readData('bookmarks');
    if (json != null) {
      final storedBookmark = jsonDecode(json) as Map<String, dynamic>;
      bookmarks.assignAll(
          storedBookmark.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isBookmarked(String productId) {
    return bookmarks[productId] ?? false;
  }

  void toggleBookmark(String productId) {
    if (!bookmarks.containsKey(productId)) {
      bookmarks[productId] = true;
      saveBookmarktoStorage();
      ELoaders.customToast(
          message: "Product has been added to your Saved Items!");
    } else {
      ELocalStorage.instance().removeData(productId);
      bookmarks.remove(productId);
      saveBookmarktoStorage();
      bookmarks.refresh();
      ELoaders.customToast(
          message: "Product has been removed from your Saved Items!");
    }
  }

  void saveBookmarktoStorage() {
    final encodedBookmark = json.encode(bookmarks);
    ELocalStorage.instance().writeData('bookmarks', encodedBookmark);
  }

  Future<List<ProductModel>> bookmarkProducts() async {
    return await ProductRepository.instance
        .getBookmarkProducts(bookmarks.keys.toList());
  }
}
