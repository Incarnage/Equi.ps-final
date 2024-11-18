import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ESingleAddress extends StatelessWidget {
  const ESingleAddress({
    super.key,
    required this.selectedAddress,
  });

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    return ERoundedcontainer(
      padding: const EdgeInsets.all(TSizes.medium),
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress
          ? const Color.fromARGB(255, 108, 115, 92).withOpacity(.5)
          : Colors.transparent,
      borderColor: const Color(0xFF25291C), // placeholder
      margin: const EdgeInsets.only(bottom: TSizes.spaceItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle5 : null,
              color: const Color(0xFF25291C), // placeholder
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Amethyst Moran",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TSizes.small / 2),
              const Text("(+63) 99 3312 158",
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: TSizes.small / 2),
              const Text("123 California St., San Luis, Naga City, 4400, PH",
                  softWrap: true)
            ],
          )
        ],
      ),
    );
  }
}
