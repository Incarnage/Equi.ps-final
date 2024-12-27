import 'package:cloud_firestore/cloud_firestore.dart';
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
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color(0xFF25291C),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF25291C))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),

              // Rating and Date of Review
              Row(
                children: [
                  Expanded(child: ERatingBarIndicator(rating: rating)),
                  const SizedBox(width: TSizes.spaceItems),
                  Text(
                    "${reviewDate.toDate().month}/${reviewDate.toDate().day}/${reviewDate.toDate().year.toString().substring(2)}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceItems / 2),

              // User Comment
              ReadMoreText(
                userComment,
                style: const TextStyle(
                  color: Colors.white,
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
                  color: Colors.white,
                ),
                lessStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: TSizes.spaceItems / 2),
            ],
          ),
        ),
        const SizedBox(
          height: TSizes.spaceItems,
        )
      ],
    );
  }
}
