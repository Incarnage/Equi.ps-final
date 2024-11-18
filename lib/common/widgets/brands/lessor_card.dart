import 'package:equips_v2/common/images/e_circular_image.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/text/brandTitle_with_verifiedIcon.dart';
import 'package:equips_v2/feature/auth/controller/signUp/widgets/usermodel.dart';
import 'package:equips_v2/feature/shop/models/lessor_model.dart';
import 'package:equips_v2/utilities/constants/enums.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class ELessorCard extends StatelessWidget {
  const ELessorCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.lessor,
  });

  final UserModel lessor;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ERoundedcontainer(
        padding: const EdgeInsets.all(TSizes.small),
        backgroundColor: Colors.white,
        child: Row(
          children: [
            // Icon
            Flexible(
              child: ECircularImage(
                isNetworkImage: true,
                image: lessor.profilePicture,
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(width: TSizes.spaceItems),

            // Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min, // adjusts aligment
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  brandTitleWithVerifiedIcon(
                    title: lessor.fullName,
                    brandTextSize: TextSizes.small,
                    textColor: Colors.black,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
