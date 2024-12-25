import 'package:equips_v2/feature/shop/screen/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';

class OverallProductRatings extends StatelessWidget {
  final double averageRating;
  final Map<int, int> ratingDistribution;

  const OverallProductRatings({
    super.key,
    required this.averageRating,
    required this.ratingDistribution,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate total reviews to use for percentage calculation
    int totalReviews = ratingDistribution.values.fold(0, (sum, count) => sum + count);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            averageRating.toStringAsFixed(1),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              ERatingProcessIndicator(
                text: '5',
                value: totalReviews == 0 ? 0 : ratingDistribution[5]! / totalReviews,
              ),
              ERatingProcessIndicator(
                text: '4',
                value: totalReviews == 0 ? 0 : ratingDistribution[4]! / totalReviews,
              ),
              ERatingProcessIndicator(
                text: '3',
                value: totalReviews == 0 ? 0 : ratingDistribution[3]! / totalReviews,
              ),
              ERatingProcessIndicator(
                text: '2',
                value: totalReviews == 0 ? 0 : ratingDistribution[2]! / totalReviews,
              ),
              ERatingProcessIndicator(
                text: '1',
                value: totalReviews == 0 ? 0 : ratingDistribution[1]! / totalReviews,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
