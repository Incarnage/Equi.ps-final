// ignore_for_file: use_build_context_synchronously

import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_model.dart';

import 'package:equips_v2/feature/shop/screen/product_reviews/widgets/user_review_model.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RateLessorProduct extends StatefulWidget {
  final OrderModel order;

  RateLessorProduct({super.key, required this.order});

  @override
  _RateLessorProductState createState() => _RateLessorProductState();
}

class _RateLessorProductState extends State<RateLessorProduct> {
  final userController = UserController.instance;
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0.0;

  void _submitReview() {
    if (_rating == 0.0 || _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide a rating and comment.')),
      );
      return;
    }

    final review = UserReviewModel(
      senderID: userController.user.value.id,
      senderName: userController.user.value.firstName,
      productID: widget.order.productId, // Replace with actual product ID
      rating: _rating,
      message: _commentController.text,
      timestamp: Timestamp.now(),
    );

    // Save to Firestore or any other database
    FirebaseFirestore.instance
        .collection('reviews')
        .add(review.toMap())
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review submitted successfully!')),
      );
      _commentController.clear();
      setState(() {
        _rating = 0.0;
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $error')),
      );
    });

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Rate Product',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'How was your rental experience, ${userController.user.value.firstName}?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: TSizes.fontLarge,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                const Text(
                  'Rate your Rental Experience!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add a comment',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _commentController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your comment here...',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitReview,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25291C),
                            side: const BorderSide(color: Color(0xFF25291C))),
                        child: const Text('Submit'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
