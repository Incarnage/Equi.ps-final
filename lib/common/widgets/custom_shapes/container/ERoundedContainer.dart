import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class ERoundedcontainer extends StatelessWidget {
  const ERoundedcontainer(
      {super.key,
      this.width,
      this.height,
      this.child,
      this.showBorder = false,
      this.radius = TSizes.cardRaidusLarge,
      this.borderColor = Colors.blueAccent,
      this.backgroundColor = Colors.white,
      this.padding,
      this.margin});

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
