import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/text/section_heading.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        const SizedBox(
          height: TSizes.spaceItems / 2,
        ),
        Row(
          children: [
            const ERoundedcontainer(
              width: 60,
              height: 35,
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(TSizes.small),
              child: Image(
                image: AssetImage('assets/pic/gcash.png'),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: TSizes.spaceItems / 2,
            ),
            Text('Gcash', style: Theme.of(context).textTheme.bodyLarge)
          ],
        )
      ],
    );
  }
}
