import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/ERoundedContainer.dart';
import 'package:equips_v2/common/widgets/products/ratings/rating_indicator.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  final String userName;
  final double rating;
  final Timestamp reviewDate;
  final String userComment;

  const UserReviewCard({
    Key? key,
    required this.userName,
    required this.rating,
    required this.reviewDate,
    required this.userComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Info (Profile and Name)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: TSizes.spaceItems),
                Text(
                  userName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceItems / 2),

        // Rating and Date of Review
        Row(
          children: [
            ERatingBarIndicator(rating: rating),
            const SizedBox(width: TSizes.spaceItems),
            Text(
                "${reviewDate.toDate().month}/${reviewDate.toDate().day}/${reviewDate.toDate().year.toString().substring(2)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceItems / 2),

        // User Comment
        ReadMoreText(
          userComment,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: " show less",
          trimCollapsedText: " show more",
          moreStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF25291C),
          ),
          lessStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF25291C),
          ),
        ),

        const SizedBox(height: TSizes.spaceItems / 2),
      ],
    );
  }
}
