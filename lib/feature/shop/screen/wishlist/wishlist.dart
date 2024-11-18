import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/icons/e_circular_icons.dart';
import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/common/widgets/loaders/animation_loader.dart';
import 'package:equips_v2/common/widgets/products%20cart/bookmark/bookmark_controller.dart';
import 'package:equips_v2/common/widgets/products%20cart/vertical_productCard.dart';
import 'package:equips_v2/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:equips_v2/feature/personalize/screen/profile/profile.dart';

import 'package:equips_v2/navigation_menu.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/helper/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BookmarkController.instance;

    return Scaffold(
      backgroundColor: const Color(0xFF25291C),
      appBar: TAppbar(
        title: Text(
          'Saved Items',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => FutureBuilder(
                    future: controller.bookmarkProducts(),
                    builder: (context, snapshot) {
                      final emptyWidget = EAnimatedLoaderWidget(
                        text: 'Wishlist is empty',
                        animation: 'assets/pic/loading.json',
                        showAction: true,
                        actionText: 'Let\'s add some',
                        onActionPressed: () =>
                            Get.offAll(const NavigationMenu()),
                      );

                      const loader = EVerticalProductShimmer(itemCount: 6);
                      final widget =
                          ECloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot,
                              loader: loader,
                              nothingFound: emptyWidget);

                      if (widget != null) {
                        return widget;
                      }

                      final products = snapshot.data!;

                      return EGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => VerticalProductCard(
                                product: products[index],
                              ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
