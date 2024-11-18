import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class NotificationGrid extends StatelessWidget {
  const NotificationGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 150, // the height of the card
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(), // make it scrollable
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: mainAxisExtent,
          mainAxisSpacing: TSizes.gridViewSpacing,
          crossAxisSpacing: TSizes.gridViewSpacing,
        ),
        itemBuilder: itemBuilder);
  }
}
