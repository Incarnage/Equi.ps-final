import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/text/brandTitle_with_verifiedIcon.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/common/widgets/text/section_heading.dart';
import 'package:equips_v2/feature/shop/controller/product/images_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/delete_product.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/image_slider.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/product_data.dart';
import 'package:equips_v2/utilities/constants/enums.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class EditProductDetails extends StatelessWidget {
  const EditProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());

    return Scaffold(
      bottomNavigationBar: EBottomEditDeleteProduct(
        product: product,
      ),
      body: FutureBuilder<List<String>>(
        future: ImagesController.instance.getAllProductImages(product),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Now we have all the images loaded and can build the UI
          return SingleChildScrollView(
            child: Column(
              children: [
                // photos
                ImageSlider(product: product),

                // title
                Row(
                  children: [
                    const SizedBox(
                      width: TSizes.defaultSpace,
                    ),
                    Expanded(
                      child: ERoundedcontainer(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        backgroundColor: const Color(0xFF25291C),
                        child: Column(
                          children: [
                            // Name of product
                            Text(
                              product.productTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),

                            // Store Name and Verified Icon
                            brandTitleWithVerifiedIcon(
                              title: product.lessor!.name,
                              brandTextSize: TextSizes.medium,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: TSizes.defaultSpace,
                    ),
                  ],
                ),

                const SizedBox(height: TSizes.spaceItems),
                Padding(
                  padding: const EdgeInsets.only(
                    right: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace,
                  ),
                  child: Column(
                    children: [
                      // product data: rental cost
                      ProductData(product: product),

                      if (product.delivertOption.isNotEmpty)
                        Row(
                          children: [
                            const SizedBox(
                                width: 50,
                                child: EProductTitleText(
                                    title: 'Delivery Option: ')),
                            const SizedBox(width: TSizes.spaceItems),
                            Text(
                              product.delivertOption.join(' / '),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),

                      const SizedBox(height: TSizes.spaceItems),
                      // Description
                      const SectionHeading(
                          title: 'Description', showActionButton: false),
                      const SizedBox(height: TSizes.spaceItems),
                      ReadMoreText(
                        product.description ?? '',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: ' Show more',
                        trimExpandedText: ' Less',
                        moreStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
