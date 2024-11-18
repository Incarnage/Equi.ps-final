import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class CouponCode extends StatelessWidget {
  const CouponCode({super.key});

  @override
  Widget build(BuildContext context) {
    return ERoundedcontainer(
      showBorder: true,
      backgroundColor: Colors.white,
      padding: EdgeInsets.only(
          top: TSizes.small,
          left: TSizes.medium,
          right: TSizes.small,
          bottom: TSizes.small),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Have a promo code?',
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
            ),
          ),

          //button
          SizedBox(
              width: 80,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Apply'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black.withOpacity(0.5),
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    side: BorderSide(color: Colors.grey.withOpacity(0.1))),
              ))
        ],
      ),
    );
  }
}
