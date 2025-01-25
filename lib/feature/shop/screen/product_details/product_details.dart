import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/text/brandTitle_with_verifiedIcon.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/common/widgets/text/section_heading.dart';
import 'package:equips_v2/data/repository/user/user_repository.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/screen/product_reviews/productReviews.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/bottom_add_cart.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/image_slider.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/product_data.dart';
import 'package:equips_v2/feature/shop/screen/product_details/widget/unavailable.dart';
import 'package:equips_v2/utilities/constants/enums.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Future<void> goToWebPage(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }


  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      locale: 'en_PH', 
      symbol: '₱', 
      decimalDigits: 0,
    ).format(widget.product.price);

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
            Row(
              children: [
                const SizedBox(
                  width: TSizes.defaultSpace,
                ),
                Expanded(
                  child: ERoundedcontainer(
                    padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                    backgroundColor: const Color(0xFF25291C),
                    child: Column(
                      children: [
                        // Name of product
                        SingleChildScrollView(
                           scrollDirection:
                          Axis.horizontal, 
                          child: Text(
                            widget.product.productTitle,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
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
                  width: TSizes.defaultSpace,
                ),
              ],
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
                  const SizedBox(
                      width: 50, child: EProductTitleText(title: 'Location')),
                  const SizedBox(width: TSizes.spaceItems),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scrolling
                      child: Text(
                        socialMedia?["address"] ?? 'No address available',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceItems),
            // Deliver options
            if (widget.product.delivertOption.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Row(
                  children: [
                    const SizedBox(
                        width: 50,
                        child: EProductTitleText(title: 'Delivery Option: ')),
                    const SizedBox(width: TSizes.spaceItems),
                    Text(
                      widget.product.delivertOption.join(' / '),
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

            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: ReadMoreText(widget.product.description ?? '',
                  style: const TextStyle(fontWeight: FontWeight.normal),
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show more',
                  trimExpandedText: ' Less',
                  moreStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  )),
            ),

            const SizedBox(height: TSizes.spaceSections),
            Container(
              width: 335,
              height: 3,
              color: const Color.fromARGB(255, 238, 237, 237),
            ),
            const SizedBox(height: TSizes.spaceItems),

            if (isLoading)
              const CircularProgressIndicator()
            else if (socialMedia != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSocialMediaRow('Facebook', socialMedia?['Facebook']),
                    const SizedBox(height: TSizes.spaceItems),
                    _buildSocialMediaRow(
                        'Instagram', socialMedia?['Instagram']),
                    const SizedBox(height: TSizes.spaceItems),
                    _buildSocialMediaRow('Gmail', socialMedia?['Gmail']),
                    const SizedBox(height: TSizes.spaceItems),
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

  Widget _buildSocialMediaRow(String platform, String? value) {
    final displayText = (value ?? '').isEmpty
      ? 'No $platform available'
      : (platform == 'Facebook' || platform == 'Instagram') 
          ? 'Visit $platform' 
          : value!;

    
    return Row(
      children: [
        EProductTitleText(title: platform),
        const SizedBox(width: TSizes.spaceItems),
        InkWell(
          onTap: () {
            if ((platform == 'Facebook' || platform == 'Instagram')&&value != null && value.isNotEmpty) {
              
                goToWebPage(value);
            }
            else{
              if (value != null) {
                Clipboard.setData(ClipboardData(text: value));
              }
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: const Text('Gmail copied to clipboard!'),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
            }
          },
          child: Text(
            overflow: TextOverflow.ellipsis,
            displayText,
            style: TextStyle(
              fontSize: 20,
              color: (platform == 'Facebook' || platform == 'Instagram') &&value != null && value.isNotEmpty
                  ? Colors.blue 
                  :Color(0xFF25291C),
              decoration: (platform == 'Facebook' || platform == 'Instagram')&&value != null && value.isNotEmpty
                  ? TextDecoration.underline 
                  : TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

 



}
