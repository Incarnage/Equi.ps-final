import 'package:equips_v2/common/widgets/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context:
            Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
        barrierDismissible:
            false, // the dialog can't be dismissed by tapping outside it
        builder: (_) => PopScope(
            canPop: false, // Disable popping with the back button
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250), // adjust spacing as needed
                  EAnimatedLoaderWidget(text: text, animation: 'assets/pic/equips-json.json'),
                ],
              ),
            )));
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!)
        .pop(); // close the dialog using the navigator
  }
}
