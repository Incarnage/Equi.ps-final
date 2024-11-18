import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class EVerticalProductShimmer extends StatelessWidget {
  const EVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return EGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //pic
                  ShimmerEffect(width: 180, height: 180),
                  SizedBox(
                    height: TSizes.spaceItems,
                  ),

                  //text
                  ShimmerEffect(width: 160, height: 15),
                  SizedBox(height: TSizes.spaceItems / 2),
                  ShimmerEffect(width: 110, height: 15)
                ],
              ),
            ));
  }
}
