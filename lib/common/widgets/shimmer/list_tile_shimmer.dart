import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            ShimmerEffect(width: 50, height: 50),
            SizedBox(
              width: TSizes.spaceItems,
            ),
            Column(
              children: [
                ShimmerEffect(width: 100, height: 15),
                SizedBox(width: TSizes.spaceItems / 2),
                ShimmerEffect(width: 80, height: 12)
              ],
            )
          ],
        )
      ],
    );
  }
}
