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
      final data = await UserRepository().getLessorSocMed(widget.product.lessor!.id);
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
            const Divider(),
            const SizedBox(height: TSizes.spaceItems),

            // Name of product
            EProductTitleText(
              title: widget.product.productTitle,
              smallSize: true,
            ),

            // Store Name and Verified Icon
            brandTitleWithVerifiedIcon(
              title: widget.product.lessor!.name,
              brandTextSize: TextSizes.medium,
            ),

            const SizedBox(height: TSizes.spaceItems),
            const Divider(),
            const SizedBox(height: TSizes.spaceItems),
            const SectionHeading(
                    title: 'Description',
                    showActionButton: false,
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
                  const SizedBox(
                    height: TSizes.spaceItems,
                  ),
            const Divider(),
            const SizedBox(height: TSizes.spaceItems),

            // Social Media Section
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage.isNotEmpty)
              Text('Error: $errorMessage')
            else if (socialMedia != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
              )
            else
              const Text('No social media information available'),

            const Divider(),
            const SizedBox(height: TSizes.spaceItems),

            // Reviews
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionHeading(
                  title: 'Reviews (100)',
                  onPressed: () {},
                  showActionButton: false,
                ),
                IconButton(
                  onPressed: () =>
                      Get.to(() => const ProductReviewScreen()),
                  icon: const Icon(
                    Iconsax.arrow_right_3,
                    size: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
