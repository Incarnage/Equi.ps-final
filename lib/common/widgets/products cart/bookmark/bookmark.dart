import 'package:equips_v2/common/widgets/icons/e_circular_icons.dart';
import 'package:equips_v2/common/widgets/products%20cart/bookmark/bookmark_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EBookmark extends StatelessWidget {
  const EBookmark({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookmarkController());
    return Obx(
      () => ECircularIcons(
        backgroundColor: Colors.white,
        icon: controller.isBookmarked(productId)
            ? Iconsax.bookmark1
            : Iconsax.bookmark,
        onPressed: () => controller.toggleBookmark(productId),
      ),
    );
  }
}
