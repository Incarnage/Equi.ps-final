import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/text/brandTitle_with_verifiedIcon.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/common/widgets/text/section_heading.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';

import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/bottom_add_cart.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/image_slider.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/product_data.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/unavailable.dart';
import 'package:equips_v2/feature/shop/screen/product_reviews/productReviews.dart';

import 'package:equips_v2/utilities/constants/enums.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import 'package:flutter/material.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Map<String, String>? socialMedia;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchLessorSocialMedia();
  }

  Future<void> fetchLessorSocialMedia() async {
    try {
      final data =
          await UserRepository().getLessorSocMed(widget.product.lessor!.id);
      setState(() {
        socialMedia = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.product.isAvailable == true
          ? EBottomeAddToCart(
              product: widget.product,
            )
          : const Unavailable(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image slider
            ImageSlider(
              product: widget.product,
            ),

            // title
            ERoundedcontainer(
              backgroundColor: const Color(0xFF25291C),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 120, right: 110, top: 15, bottom: 15),
                child: Column(
                  children: [
                    // Name of product
                    Text(
                      widget.product.productTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),

                    // Store Name and Verified Icon
                    brandTitleWithVerifiedIcon(
                      title: widget.product.lessor!.name,
                      brandTextSize: TextSizes.medium,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: TSizes.spaceSections,
            ),
            // Product Data
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: ProductData(product: widget.product),
            ),

            // Location
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Row(
                children: [
                  // location
                  const EProductTitleText(title: 'Location'),
                  const SizedBox(width: TSizes.spaceItems),
                  Text(
                    socialMedia?["address"] ?? 'No address available',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceItems),

            // Descr
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: SectionHeading(
                title: 'Description',
                showActionButton: false,
              ),
            ),

            ReadMoreText(widget.product.description ?? '',
                style: const TextStyle(fontWeight: FontWeight.normal),
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Less',
                moreStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                )),

            const SizedBox(height: TSizes.spaceItems),
            Container(
              width: 335,
              height: 3,
              color: const Color.fromARGB(255, 238, 237, 237),
            ),
            const SizedBox(height: TSizes.spaceItems),

            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage.isNotEmpty)
              Text('Error: $errorMessage')
            else if (socialMedia != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: TSizes.spaceItems),
                    Row(
                      children: [
                        const EProductTitleText(title: 'Facebook'),
                        const SizedBox(width: TSizes.spaceItems),
                        Text(
                          socialMedia!['Facebook']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceItems),
                    Row(
                      children: [
                        const EProductTitleText(title: 'Instagram'),
                        const SizedBox(width: TSizes.spaceItems),
                        Text(
                          socialMedia!['Instagram']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceItems),
                    Row(
                      children: [
                        const EProductTitleText(title: 'Gmail'),
                        const SizedBox(width: TSizes.spaceItems),
                        Text(
                          socialMedia!['Gmail']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceItems,
                    ),
                  ],
                ),
              )
            else
              const Text('No social media information available'),

            const SizedBox(height: TSizes.spaceItems),
            Container(
              width: 333,
              height: 3,
              color: const Color.fromARGB(255, 238, 237, 237),
            ),
            const SizedBox(height: TSizes.spaceItems),

            // Reviews
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionHeading(
                    title: 'See Reviews',
                    onPressed: () {},
                    showActionButton: false,
                  ),
                  IconButton(
                    onPressed: () => Get.to(
                        () => ProductReviewScreen(product: widget.product)),
                    icon: const Icon(
                      Iconsax.arrow_right_3,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceItems),
          ],
        ),
      ),
    );
  }
}
