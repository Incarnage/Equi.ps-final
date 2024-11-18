import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class BoxesShimmer extends StatelessWidget {
  const BoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: ShimmerEffect(width: 150, height: 110)),
            SizedBox(
              width: TSizes.spaceItems,
            ),
            Expanded(child: ShimmerEffect(width: 150, height: 110)),
            SizedBox(
              width: TSizes.spaceItems,
            ),
            Expanded(child: ShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}
