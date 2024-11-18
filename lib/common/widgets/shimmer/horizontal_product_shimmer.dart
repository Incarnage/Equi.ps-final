import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class EHorizontalProductShimmer extends StatelessWidget {
  const EHorizontalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext) {
    return Container(
      margin: const EdgeInsets.only(bottom: TSizes.spaceSections),
      height: 120,
      child: ListView.separated(
          itemCount: itemCount,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) =>
              const SizedBox(width: TSizes.spaceItems),
          itemBuilder: (_, __) => const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShimmerEffect(width: 120, height: 120),
                  SizedBox(width: TSizes.spaceItems),

                  // Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: TSizes.spaceItems / 2),
                      ShimmerEffect(width: 160, height: 15),
                      SizedBox(height: TSizes.spaceItems / 2),
                      ShimmerEffect(width: 110, height: 15),
                      SizedBox(height: TSizes.spaceItems / 2),
                      ShimmerEffect(width: 80, height: 15),
                      Spacer(),
                    ],
                  )
                ],
              )),
    );
  }
}
