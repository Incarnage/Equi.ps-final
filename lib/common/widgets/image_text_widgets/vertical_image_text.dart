import 'package:equips_v2/common/images/e_circular_image.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.onTap,
    this.isNetworkImage = true,
  });
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //circular Icon
            ECircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: TSizes.small * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: Colors.black,
            ),
            //text
            const SizedBox(
              height: TSizes.spaceItems / 2,
            ),
            Expanded(
              child: SizedBox(
                
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
