import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/products/ratings/rating_indicator.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Profile Pic and Name
            Row(
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage("assets/pic/ac.jpg")),
                const SizedBox(width: TSizes.spaceItems),
                Text("Amethyst Claudia",
                    style: Theme.of(context).textTheme.bodyMedium)
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),

        const SizedBox(height: TSizes.spaceItems / 2),

        // Star and Date of Comment
        Row(
          children: [
            const ERatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceItems),
            Text("01 Nov 2023", style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),

        const SizedBox(height: TSizes.spaceItems / 2),

        // Comment of the Lessee
        const ReadMoreText(
          "Equips mobile app has a user friendly UI/UX Design. I was able to navigate easily the app. Looking forward to more innovations. Great job!",
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: " show less",
          trimCollapsedText: " show more",
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF25291C)),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF25291C)),
        ),

        const SizedBox(height: TSizes.spaceItems / 2),

        // Company Review or Lessor's Reply
        const ERoundedcontainer(
          backgroundColor: Color(0xFF25291C),
          child: Padding(
            padding: EdgeInsets.all(TSizes.medium),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ABC Rental by Miggy",
                        style: TextStyle(color: Colors.white)),
                    Text("11 Nov, 2023",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                ),
                SizedBox(height: TSizes.spaceSections / 2),
                ReadMoreText(
                  "Equips mobile app has a user friendly UI/UX Design. I was able to navigate easily the app. Looking forward to more innovations. Great job!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: " show less",
                  trimCollapsedText: " show more",
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD233)),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD233)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceSections / 2),
      ],
    );
  }
}
