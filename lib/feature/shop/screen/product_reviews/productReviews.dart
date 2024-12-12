import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/products/ratings/rating_indicator.dart';
import 'package:equips_v2/feature/shop/screen/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:equips_v2/feature/shop/screen/product_reviews/widgets/user_review_card.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: const TAppbar(
          title: Text("Review and Ratings"), showBackArrow: false),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Ratings and review of the rented properties from the shop are shown here."),
              const SizedBox(height: TSizes.defaultSpace),

              // Oevrall PRoduct Settings
              const OverallProductRatings(),
              const ERatingBarIndicator(rating: 3.5),
              Text("12,611",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall), // show number of reviews for that item
              const SizedBox(height: TSizes.spaceSections),

              // User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
