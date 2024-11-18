import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// a widget for displaying an animated loading indicator with optional text and action button
class EAnimatedLoaderWidget extends StatelessWidget {
  // Default constructor for the EAnimationLoaderWidget

  // Parameters:
  /*

  text: the text to be displayed below the animation
  animation: the path to the Lottie animation file
  showAction: whether to show an action button below the text
  actionText: the text to be displayed on the action button
  onActionPressed: Callback function to be executed when the action button is pressed

  */
  const EAnimatedLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      this.showAction = false,
      this.actionText,
      this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              width: MediaQuery.of(context).size.width *
                  0.8), // Display Lottie animation
          const SizedBox(height: TSizes.defaultSpace),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
