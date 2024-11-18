import 'package:equips_v2/utilities/constants/size.dart';

import 'package:flutter/material.dart';

class ECircularIcons extends StatelessWidget {
  const ECircularIcons({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.size = TSizes.large,
    this.onPressed,
    this.color,
    this.backgroundColor,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(100)),
        child: IconButton(
            onPressed: onPressed, icon: Icon(icon, color: color, size: size)));
  }
}









/* 
class ECircularIcon extends StatelessWidget {
  const ECircularIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.white),
      child: IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart5)),
    );
  }
}
*/