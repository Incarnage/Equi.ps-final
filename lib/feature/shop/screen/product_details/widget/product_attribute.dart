import 'package:equips_v2/common/chips/choice_chip.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/products%20cart/product_price.dart';
import 'package:equips_v2/common/widgets/text/productTitle_text.dart';
import 'package:equips_v2/common/widgets/text/section_heading.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class ProductAttribute extends StatelessWidget {
  const ProductAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //select attribute desc and price
        ERoundedcontainer(
          padding: const EdgeInsets.all(TSizes.medium),
          backgroundColor:
              const Color.fromARGB(255, 110, 118, 91), // Color(0xFF25291C),
          child: Column(
            children: [
              Row(
                children: [
                  const SectionHeading(
                    title: 'Variation',
                    textColor: Colors.white,
                    showActionButton: false,
                  ),
                  const SizedBox(
                    width: TSizes.spaceItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const EProductTitleText(
                              title: 'Price : ',
                              smallSize: true,
                              textColor: Colors.black),
                          const SizedBox(
                            width: TSizes.spaceItems,
                          ),
                          //actual price
                          Text(
                            '\$15',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: TSizes.spaceItems,
                          ),
                          //sale price
                          const ProductPriceText(price: '20')
                        ],
                      ),

                      //stock availability
                      Row(
                        children: [
                          const EProductTitleText(
                            textColor: Colors.black,
                            title: 'Stock : ',
                            smallSize: true,
                          ),
                          Text(
                            'In Stock',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .apply(color: Colors.white),
                          )
                        ],
                      ),

                      //variation desc
                    ],
                  ),
                ],
              ),
              const EProductTitleText(
                title: 'basta desc can go up to 4 lines',
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(
          height: TSizes.spaceItems,
        ),

        //attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              title: 'Colors',
              showActionButton: false,
            ),
            const SizedBox(
              height: TSizes.spaceItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                EChoiceChip(
                  text: 'Green',
                  selected: true,
                  onSelected: (value) {},
                ),
                EChoiceChip(
                  text: 'Green',
                  selected: false,
                  onSelected: (value) {},
                ),
                EChoiceChip(
                  text: 'Gren',
                  selected: false,
                  onSelected: (value) {},
                )
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              title: 'Sizes',
              showActionButton: false,
            ),
            const SizedBox(
              height: TSizes.spaceItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                EChoiceChip(
                  text: 'EU 34',
                  selected: true,
                  onSelected: (value) {},
                ),
                EChoiceChip(
                  text: 'EU 36',
                  selected: false,
                  onSelected: (value) {},
                ),
                EChoiceChip(
                  text: 'EU 38',
                  selected: false,
                  onSelected: (value) {},
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
