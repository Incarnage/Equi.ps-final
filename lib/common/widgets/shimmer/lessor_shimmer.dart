import 'package:equips_v2/common/widgets/layouts/gridLayout.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:flutter/material.dart';

class LessorShimmer extends StatelessWidget {
  const LessorShimmer({super.key, this.itemcount = 4});
  final int itemcount;
  @override
  Widget build(BuildContext context) {
    return EGridLayout(
        mainAxisExtent: 80,
        itemCount: itemcount,
        itemBuilder: (_, __) => const ShimmerEffect(width: 300, height: 70));
  }
}
