import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/common/images/e_circular_image.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/common/widgets/custom_shapes/container/eSectionHeading.dart';
import 'package:equips_v2/feature/auth/screen/home/widget/shimmer.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:equips_v2/feature/shop/controller/product/images_controller.dart';
import 'package:equips_v2/feature/shop/models/product_model.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_controller.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_date_picker.dart';
import 'package:equips_v2/feature/shop/order/widgets/order_info.dart';

import 'package:equips_v2/utilities/constants/size.dart';
import 'package:equips_v2/utilities/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PayScreen extends StatelessWidget {
  PayScreen({super.key, required this.product});

  final ProductModel product;
  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> imageFile = Rx<XFile?>(null);
  final RxString selectedfromTime = "Select Time".obs;
  final RxString selectedtoTime = "Select Time".obs;

  final RxString lessorGcashPhoto = "".obs;
  final RxString lessorGcashNumber = "".obs;
  Rx<double> totalDuration = 0.0.obs;
  Rx<double> finalPrice = 0.0.obs;
  Rx<double> partialPrice = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());

    final controller = UserController.instance;
    final ordercontroller = OrderController.instance;
    fetchLessorGcashPhoto(product.lessor!.id);

    // Update duration when dates or times are changed
    ordercontroller.fromDate.addListener(() {
      updateTotalDuration(ordercontroller);
    });
    ordercontroller.toDate.addListener(() {
      updateTotalDuration(ordercontroller);
    });
    ordercontroller.fromTime.addListener(() {
      updateTotalDuration(ordercontroller);
    });
    ordercontroller.toTime.addListener(() {
      updateTotalDuration(ordercontroller);
    });

    return Form(
        key: ordercontroller.orderFormKey,
        child: Scaffold(
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
                vertical: TSizes.defaultSpace / 2),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(TSizes.cardRaidusLarge),
                    topRight: Radius.circular(TSizes.cardRaidusLarge))),
            child: SizedBox(
              width: double.infinity,
              child: Obx(() {
                // Only show Pay button if Gcash information is available
                return lessorGcashPhoto.value.isNotEmpty
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF25291C)),
                            backgroundColor: const Color(0xFF25291C)),
                        onPressed: () {
                          // Validate the order form key
                          if (ordercontroller.orderFormKey.currentState!
                              .validate()) {
                            // Check if 'From Time', 'To Time', and proof of payment are provided
                            if (ordercontroller.fromTime.text.isEmpty ||
                                ordercontroller.toTime.text.isEmpty) {
                              ELoaders.errorSnackBar(
                                title: "Invalid Time Selection",
                                message:
                                    'Please select both start and end times.',
                              );
                            } else if (ordercontroller.imageFile.value ==
                                null) {
                              ELoaders.errorSnackBar(
                                title: "Proof of Payment Missing",
                                message: 'Please upload proof of payment.',
                              );
                            } else {
                              // If all required fields are filled, proceed with the payment
                              ordercontroller.pay(product);
                            }
                          } else {
                            // If form validation fails, show a generic error
                            ELoaders.errorSnackBar(
                              title: "Oh Snap!",
                              message: 'Please fill all required fields.',
                            );
                          }
                        },
                        child: const Text('Pay'),
                      )
                    : const SizedBox
                        .shrink(); // Hide the Pay button if no Gcash info
              }),
            ),
          ),
          appBar: const TAppbar(showBackArrow: true, title: Text("Payment")),

          // BODY
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const ESectionHeading(
                          title: "Rental Date",
                          showActionButton: false,
                        ),
                        const SizedBox(height: TSizes.spaceItems),
                        SelectDate(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a start date';
                            }
                            return null;
                          },
                          controller: ordercontroller.fromDate,
                          title: "From",
                        ),
                        const SizedBox(height: TSizes.spaceItems),
                        SelectDate(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a start date';
                            }
                            return null;
                          },
                          controller: ordercontroller.toDate,
                          title: "Until",
                        ),
                        const SizedBox(height: TSizes.spaceItems),
                        const ESectionHeading(
                          title: "Selected Time",
                          showActionButton: false,
                        ),
                        const SizedBox(height: TSizes.spaceItems),
                        SelectTime(
                          title: "From Time",
                          controller: ordercontroller.fromTime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a start time';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: TSizes.spaceItems),

                        // Time Picker for To Time
                        SelectTime(
                          title: "To Time",
                          controller: ordercontroller.toTime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an end time';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: TSizes.spaceItems),
                        Obx(() {
                          final networkImage = lessorGcashPhoto.value;
                          final image = (networkImage.isNotEmpty)
                              ? networkImage
                              : 'assets/pic/profile-icon.png';

                          return controller.imageUploading.value
                              ? const ShimmerEffect(
                                  width: 80,
                                  height: 80,
                                  radius: 80,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    if (networkImage.isNotEmpty) {
                                      ImagesController.instance
                                          .showEnlargedImage(networkImage);
                                    } else {
                                      ELoaders.errorSnackBar(
                                        title: 'Error',
                                        message:
                                            'No image available to enlarge',
                                      );
                                    }
                                  },
                                  child: ECircularImage(
                                    image: image,
                                    width: 300,
                                    height: 300,
                                    isNetworkImage: networkImage.isNotEmpty,
                                  ),
                                );
                        }),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              product.lessor!.name,
                              style:
                                  const TextStyle(fontSize: TSizes.fontLarge),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              lessorGcashNumber.value,
                              style:
                                  const TextStyle(fontSize: TSizes.fontLarge),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Details
                  const SizedBox(height: TSizes.spaceItems / 2),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceItems),

                  // Heading Profile Info
                  const ESectionHeading(
                    title: "Payment Option",
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceItems),

                  Obx(() {
                    return OrderInfo(
                      title: "Full",
                      value: finalPrice.value.toString(),
                    );
                  }),
                  Obx(() {
                    return OrderInfo(
                      title: "Partial",
                      value: partialPrice.value.toString(),
                    );
                  }),

                  const SizedBox(height: TSizes.spaceItems),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceItems),

                  // Heading Personal Info
                  ESectionHeading(
                      title: "Proof of Payment",
                      showActionButton: false,
                      onPressed: () {}),
                  const SizedBox(height: TSizes.spaceItems),

                  TextButton(
                    onPressed: () async {
                      final pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        ordercontroller.setImageFile(
                            pickedFile); // Set the picked image in the controller
                      } else {
                        ELoaders.errorSnackBar(
                            title: 'Error', message: 'No image selected');
                      }
                    },
                    child: const Text(
                      "Upload Proof of Payment",
                      style: TextStyle(color: Color(0xFF25291C)),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceItems),

                  Obx(() {
                    if (ordercontroller.imageFile.value != null) {
                      return Image.file(
                        File(ordercontroller.imageFile.value!.path),
                        height: 100,
                      );
                    } else {
                      return const Text("No image selected.");
                    }
                  }),

                  const Divider(),
                ],
              ),
            ),
          ),
        ));
  }

  void fetchLessorGcashPhoto(String lessorId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> lessorDoc = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(lessorId)
          .get();

      if (lessorDoc.exists) {
        final lessorData = lessorDoc.data();
        lessorGcashPhoto.value = lessorData?['Gcash'] ?? '';
        lessorGcashNumber.value = lessorData?['GcashNumber'] ?? '';
      } else {
        ELoaders.errorSnackBar(title: 'Error', message: 'Lessor not found');
      }
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  void updateTotalDuration(OrderController ordercontroller) {
    // Only calculate if the date and time fields are not empty
    if (ordercontroller.fromDate.text.isNotEmpty &&
        ordercontroller.toDate.text.isNotEmpty &&
        ordercontroller.fromTime.text.isNotEmpty &&
        ordercontroller.toTime.text.isNotEmpty) {
      double duration = calculateDuration(
        ordercontroller.fromDate.text,
        ordercontroller.toDate.text,
        ordercontroller.fromTime.text,
        ordercontroller.toTime.text,
      );

      if (duration > 0) {
        totalDuration.value = duration;

        if (product.pduration > 0) {
          finalPrice.value = product.price * (duration / product.pduration);
          partialPrice.value = finalPrice.value / 2; // Half of final price
        } else {
          finalPrice.value = 0.0;
          partialPrice.value = 0.0;
        }
      } else {
        totalDuration.value = 0.0;
        partialPrice.value = 0.0;
        finalPrice.value = 0.0;
      }
    } else {
      totalDuration.value = 0.0;
      finalPrice.value = 0.0;
      partialPrice.value = 0.0;
    }
  }

  double calculateDuration(
      String fromDate, String toDate, String fromTime, String toTime) {
    try {
      DateTime startDateTime =
          DateFormat('MM-dd-yyyy HH:mm a').parse('$fromDate $fromTime');
      DateTime endDateTime =
          DateFormat('MM-dd-yyyy HH:mm a').parse('$toDate $toTime');
      Duration duration = endDateTime.difference(startDateTime);

      if (duration.isNegative) {
        return 0.0; // If the end time is earlier than the start time, return 0
      }
      return duration.inHours.toDouble(); // Duration in hours
    } catch (e) {
      return 0.0;
    }
  }
}
