import 'package:flutter/material.dart';

class EProductTitleText extends StatelessWidget {
  const EProductTitleText({
    super.key,
    required this.title,
    this.textColor,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
  });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;

  final dynamic textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context).textTheme.titleMedium
          : Theme.of(context).textTheme.bodySmall,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,

      // textColor: textColor,
    );
  }
}
