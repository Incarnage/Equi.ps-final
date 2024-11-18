import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/device/device_util.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ESearchContainer extends StatelessWidget {
  const ESearchContainer({
    super.key,
    this.onTap,
    required this.text,
    this.showBorder = true,
    this.showBackground = true,
    this.icon = Iconsax.search_normal,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final VoidCallback? onTap;
  final String text;
  final bool showBorder;
  final bool showBackground;
  final IconData? icon;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Container(
          width: EDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.medium),
          decoration: BoxDecoration(
              color:
                  showBackground ? Colors.white : Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(TSizes.cardRaidusLarge),
              border: showBorder
                  ? Border.all(color: const Color(0xFF25291C))
                  : null),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
              ),
              const SizedBox(
                width: TSizes.spaceItems,
              ),
              Text(text, style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
        ),
      ),
    );
  }
}
