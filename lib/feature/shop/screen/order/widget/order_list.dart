import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceItems),
      itemBuilder: (_, index) => ERoundedcontainer(
        showBorder: true,
        borderColor: const Color(0xFF25291C),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.all(TSizes.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row 1
            Row(
              children: [
                // 1 - Icon
                const Icon(
                  Iconsax.ship,
                  color: const Color(0xFF25291C),
                ),
                const SizedBox(width: TSizes.spaceItems / 2),

                // 2 - Status and Date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Processing",
                          style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: const Color(0xFF25291C),
                              fontWeightDelta: 1)),
                      Text("01 Oct 2024",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(color: const Color(0xFF25291C)))
                    ],
                  ),
                ),

                // 3 - Icon
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.arrow_right_34,
                        size: TSizes.iconSmall))
              ],
            ),

            const SizedBox(height: TSizes.spaceItems),

            // Row 2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // 1 - Icon
                      const Icon(
                        Iconsax.tag,
                        color: const Color(0xFF25291C),
                      ),
                      const SizedBox(width: TSizes.spaceItems / 2),

                      // 2 - Status and Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(
                                        color: const Color(0xFF25291C),
                                        fontWeightDelta: 1)),
                            Text("#3245f6",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: const Color(0xFF25291C)))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      // 1 - Icon
                      const Icon(
                        Iconsax.calendar,
                        color: Colors.white,
                      ),
                      const SizedBox(width: TSizes.spaceItems / 2),

                      // 2 - Status and Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Shipping Date",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(
                                        color: const Color(0xFF25291C),
                                        fontWeightDelta: 1)),
                            Text("30 Sep 2023",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: const Color(0xFF25291C)))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
