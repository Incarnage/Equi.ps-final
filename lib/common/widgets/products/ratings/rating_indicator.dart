import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class ERatingBarIndicator extends StatelessWidget {
  const ERatingBarIndicator({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: 3.5,
        itemSize: 20,
        unratedColor: Colors.grey,
        itemBuilder: (_, __) => Icon(Iconsax.star1, color: Colors.black));
  }
}
