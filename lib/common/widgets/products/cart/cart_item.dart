import 'package:equips_v2/common/images/e_rounded_image.dart';
import 'package:equips_v2/common/widgets/text/brandTitle_with_verifiedIcon.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Image
        ERoundedImage(
          imageUrl: "assets/pic/sound-system.PNG",
          width: 80,
          height: 60,
          padding: EdgeInsets.all(TSizes.small / 6),
          backgroundColor: Color.fromARGB(255, 234, 228, 228),
        ),
        SizedBox(
          width: TSizes.spaceItems,
        ),
        //title,price,and size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              brandTitleWithVerifiedIcon(title: 'ABC Lights & Sounds'),
              Flexible(
                child: EProductTitleText(
                  title: 'Sound System',
                  maxLines: 1,
                ),
              ),
              //attribute
              /* Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Color',
                    style: Theme.of(context).textTheme.bodyMedium),
                TextSpan(
                    text: 'Green',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: 'Size',
                    style: Theme.of(context).textTheme.bodyMedium),
                TextSpan(
                    text: 'UK 8', style: Theme.of(context).textTheme.bodySmall)
              ])) */
            ],
          ),
        )
      ],
    );
  }
}
