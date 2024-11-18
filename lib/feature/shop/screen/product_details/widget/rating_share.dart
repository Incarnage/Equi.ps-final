import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RatingAndShare extends StatelessWidget {
  const RatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //ratings
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(
              width: TSizes.spaceItems / 2,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: '5.0 ', style: Theme.of(context).textTheme.labelLarge),
              TextSpan(
                  text: '(100)',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(fontStyle: FontStyle.italic))
            ]))
          ],
        ),

        //share
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.share,
              size: TSizes.iconMedium,
            ))
      ],
    );
  }
}
