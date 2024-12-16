import 'package:equips_v2/common/widgets/icons/e_circular_icons.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddRemoveCartItem extends StatelessWidget {
  const AddRemoveCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ECircularIcons(
            icon: Iconsax.minus,
            width: 32,
            height: 32,
            size: TSizes.medium,
            color: Colors.black,
            backgroundColor: Color.fromARGB(255, 206, 206, 206)),
        const SizedBox(
          width: TSizes.spaceItems,
        ),
        Text(
          '2',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: TSizes.spaceItems,
        ),
        const ECircularIcons(
            icon: Iconsax.add,
            width: 32,
            height: 32,
            size: TSizes.medium,
            color: Colors.black,
            backgroundColor: Colors.lightGreen),
      ],
    );
  }
}
