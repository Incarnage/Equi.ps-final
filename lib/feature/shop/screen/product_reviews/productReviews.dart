import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/products/ratings/rating_indicator.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/screen/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:equips_v2/feature/shop/screen/product_reviews/widgets/user_review_card.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class ProductReviewScreen extends StatefulWidget {
  final ProductModel product;

  const ProductReviewScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductReviewScreenState createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  late Future<List<Map<String, dynamic>>> reviewsFuture;
  late List<Map<String, dynamic>> reviews;

  @override
  void initState() {
    super.initState();
    reviewsFuture = fetchProductReviews(widget.product.id);
  }

  Future<List<Map<String, dynamic>>> fetchProductReviews(String productId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('reviews')
          .where('productID', isEqualTo: productId)
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      debugPrint("Error fetching reviews: $e");
      return [];
    }
  }

  // Calculate rating distribution (how many reviews for each rating)
  Map<int, int> calculateRatingDistribution(List<Map<String, dynamic>> reviews) {
    Map<int, int> distribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var review in reviews) {
      int rating = (review['rating'] ?? 0).toInt();
      if (rating >= 1 && rating <= 5) {
        distribution[rating] = distribution[rating]! + 1;
      }
    }
    return distribution;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(
        title: Text("Review and Ratings"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ratings and reviews of the rented properties from the shop are shown here.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: TSizes.defaultSpace),

              // Placeholder for overall ratings
              FutureBuilder<List<Map<String, dynamic>>>( 
                future: reviewsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text(
                      "No reviews available for this product.",
                      style: TextStyle(fontSize: 16),
                    );
                  }

                  reviews = snapshot.data!;
                  Map<int, int> ratingDistribution = calculateRatingDistribution(reviews);
                  double averageRating = reviews.fold(0.0, (sum, review) => sum + (review['rating']?.toDouble() ?? 0)) / reviews.length;

                  return Column(
                    children: [
                      OverallProductRatings(
                        averageRating: averageRating,
                        ratingDistribution: ratingDistribution,
                      ),
                      // Fetch and display user reviews
                      Column(
                        children: reviews.map((review) {
                          return UserReviewCard(
                            userName: review['senderName'] ?? 'Anonymous',
                            rating: review['rating']?.toDouble() ?? 0.0,
                            reviewDate: review['timestamp'],
                            userComment: review['message'] ?? '',
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
