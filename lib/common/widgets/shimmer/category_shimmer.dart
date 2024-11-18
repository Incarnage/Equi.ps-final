import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          shrinkWrap: true,
          itemCount: itemCount,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceItems),
          itemBuilder: (_, __) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ShimmerEffect(width: 55, height: 55, radius: 55),
                SizedBox(height: TSizes.spaceItems / 2),

                // Text
                ShimmerEffect(width: 55, height: 8)
              ],
            );
          }),
    );
  }
}
