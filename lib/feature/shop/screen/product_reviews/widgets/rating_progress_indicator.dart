import 'package:equips_v2/feature/shop/screen/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class OverallProductRatings extends StatelessWidget {
  const OverallProductRatings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child:
                Text("4.8", style: Theme.of(context).textTheme.displayLarge)),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              ERatingProcessIndicator(
                text: '5',
                value: 0.4,
              ),
              ERatingProcessIndicator(text: '4', value: 0.8),
              ERatingProcessIndicator(text: '3', value: 0.6),
              ERatingProcessIndicator(text: '2', value: 0.4),
              ERatingProcessIndicator(text: '1', value: 0.2),
            ],
          ),
        )
      ],
    );
  }
}
