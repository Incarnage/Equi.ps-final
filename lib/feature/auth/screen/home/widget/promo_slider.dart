import 'package:carousel_slider/carousel_slider.dart';
import 'package:equips_v2/common/images/e_rounded_image.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/circle.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/feature/shop/controller/banner_controller.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EPromoSlider extends StatelessWidget {
  const EPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
      () {
        // Loader
        if (controller.isLoading.value) {
          return const ShimmerEffect(width: double.infinity, height: 190);
        }

        // no data found
        if (controller.banners.isEmpty) {
          return const Center(child: Text("No Data Found!"));
        } else {
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1,
                    onPageChanged: (index, _) =>
                        controller.updatePageIndicator(index)),
                items: controller.banners
                    .map(
                      (banner) => ERoundedImage(
                        imageUrl: banner.imageUrl,
                        isNetworkImage: true,
                        onPressed: () => Get.toNamed(banner.targetScreen),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: TSizes.spaceItems,
              ),
              Center(
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < controller.banners.length; i++)
                        CircularContainer(
                            margin: const EdgeInsets.only(right: 10),
                            width: 20,
                            height: 4,
                            backgroundColor:
                                controller.carouselCurrentIndex.value == i
                                    ? Colors.pink
                                    : Colors.grey),
                    ],
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
